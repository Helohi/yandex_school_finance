import 'dart:convert';
import 'dart:developer';

import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:yandex_school_finance/core/enums/entity_enum.dart';
import 'package:yandex_school_finance/core/enums/operation_enum.dart';
import 'package:yandex_school_finance/data/datasources/drift/drift_database_datasource.dart';
import 'package:yandex_school_finance/data/datasources/swagger/swagger_bank_account_datasource.dart';
import 'package:yandex_school_finance/data/datasources/swagger/swagger_category_datasource.dart';
import 'package:yandex_school_finance/data/datasources/swagger/swagger_transaction_datasource.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_brief_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_update_request_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/category_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/transaction_models/transaction_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/transaction_models/transaction_request_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/transaction_models/transaction_response_model.dart';

const dioInternetExceptionTypes = {
  DioExceptionType.connectionTimeout,
  DioExceptionType.connectionError,
  DioExceptionType.receiveTimeout,
  DioExceptionType.sendTimeout,
};

class SwaggerDriftConnection {
  SwaggerDriftConnection(
    this._dio,
    this._driftDatabaseDatasource,
    this._categoryDatasource,
    this._accountDatasource,
    this._transactionDatasource,
  );

  final Dio _dio;
  final DriftDatabaseDatasource _driftDatabaseDatasource;
  final SwaggerCategoryDatasource _categoryDatasource;
  final SwaggerBankAccountDatasource _accountDatasource;
  final SwaggerTransactionDatasource _transactionDatasource;

  /// EventSource

  Future<bool> sync() async {
    try {
      final events = await _driftDatabaseDatasource.getBackupOperations();
      for (final event in events) {
        await doEvent(event);
        _driftDatabaseDatasource.removeBackupOperationById(event.id);
      }
      return true;
    } catch (e) {
      log("${e.runtimeType} in $runtimeType.sync: $e");
      return false;
    }
  }

  Future doEvent<T>(BackupOperationTableData event) async {
    switch (event.entityType) {
      case EntityEnum.transaction:
        switch (event.operationType) {
          case OperationEnum.create:
            final response = await _dio.post(
              "/transactions",
              data: event.payload,
            );
            final transaction = TransactionModel.fromJson(response.data);
            await removeLocallyTransactionById(event.localId);
            await createLocallyTransaction(
              TransactionRequestModel.fromTransactionModel(transaction),
              transaction.id,
            );
            return;
          case OperationEnum.read:
            return;
          case OperationEnum.update:
            final response = await _dio.put(
              "/transactions/${event.remoteId}",
              data: event.payload,
            );
            final transaction = TransactionResponseModel.fromJson(
              response.data,
            );
            await _driftDatabaseDatasource.updateTransactionByLocalId(
              event.localId,
              TransactionTableCompanion(
                remoteId: Value(transaction.id),
                accountId: Value(transaction.account.id),
                categoryId: Value(transaction.category.id),
                amount: Value(transaction.amount.toDouble()),
                transactionDate: Value(
                  transaction.transactionDate.toIso8601String(),
                ),
                createdAt: Value(transaction.createdAt.toIso8601String()),
                updatedAt: Value(transaction.updatedAt.toIso8601String()),
              ),
            );
            return;
          case OperationEnum.delete:
            await _dio.delete("/transactions/${event.remoteId}");
            return;
        }
      case EntityEnum.account:
        if (event.operationType == OperationEnum.update) {
          final response = await _dio.put(
            "/accounts/${event.remoteId}",
            data: event.payload,
          );
          final accountModel = AccountModel.fromJson(response.data);

          await _driftDatabaseDatasource.updateAccountById(
            event.localId,
            AccountTableCompanion(
              userId: Value(accountModel.userId),
              name: Value(accountModel.name),
              balance: Value(accountModel.balance.toDouble()),
              currency: Value(accountModel.currency),
              createdAt: Value(accountModel.createdAt.toIso8601String()),
              updatedAt: Value(accountModel.updatedAt.toIso8601String()),
            ),
          );
        }
        return;
      case EntityEnum.category:
        return;
    }
  }

  Future<BackupOperationTableData> addUpdateAccountByIdBackup(
    int localId,
    int remoteId,
    AccountUpdateRequestModel updatedAccount,
  ) {
    return _driftDatabaseDatasource.createOrUpdateBackupOperation(
      BackupOperationTableCompanion.insert(
        entityType: EntityEnum.account,
        operationType: OperationEnum.update,
        localId: localId,
        remoteId: Value(remoteId),
        payload: jsonEncode(updatedAccount.toJson()),
        timestamp: DateTime.now(),
      ),
    );
  }

  Future<BackupOperationTableData> addCreateTransactionBackup(
    int localId,
    TransactionRequestModel transaction,
  ) async {
    return _driftDatabaseDatasource.createOrUpdateBackupOperation(
      BackupOperationTableCompanion.insert(
        entityType: EntityEnum.transaction,
        operationType: OperationEnum.create,
        localId: localId,
        payload: jsonEncode(transaction.toJson()),
        timestamp: DateTime.now(),
      ),
    );
  }

  Future<BackupOperationTableData> addUpdateTransactionBackup(
    int localId,
    int remoteId,
    TransactionRequestModel transaction,
  ) {
    return _driftDatabaseDatasource.createOrUpdateBackupOperation(
      BackupOperationTableCompanion.insert(
        entityType: EntityEnum.transaction,
        operationType: OperationEnum.update,
        localId: localId,
        remoteId: Value(remoteId),
        payload: jsonEncode(transaction.toJson()),
        timestamp: DateTime.now(),
      ),
    );
  }

  Future<BackupOperationTableData> addDeleteTransactionBackup(
    int localId,
    int remoteId,
  ) {
    return _driftDatabaseDatasource.createOrUpdateBackupOperation(
      BackupOperationTableCompanion.insert(
        entityType: EntityEnum.transaction,
        operationType: OperationEnum.delete,
        localId: localId,
        remoteId: Value(remoteId),
        payload: "",
        timestamp: DateTime.now(),
      ),
    );
  }

  /// Accounts

  Future<void> _fillAccounts() async {
    final accounts = await _accountDatasource.getAccounts();
    for (final account in accounts) {
      await _driftDatabaseDatasource
          .into(_driftDatabaseDatasource.accountTable)
          .insert(
            AccountTableCompanion.insert(
              id: Value(account.id),
              userId: account.userId,
              name: account.name,
              balance: account.balance.toDouble(),
              currency: account.currency,
              createdAt: account.createdAt.toIso8601String(),
              updatedAt: account.updatedAt.toIso8601String(),
            ),
          );
    }
  }

  Future<List<AccountModel>> getAccounts() async {
    List<AccountTableData> accounts = await _driftDatabaseDatasource
        .getAccounts();
    if (accounts.isEmpty) {
      await _fillAccounts();
      accounts = await _driftDatabaseDatasource.getAccounts();
    }

    return accounts.map((el) => AccountModel.fromJson(el.toJson())).toList();
  }

  Future<AccountModel> getAccountById(int id) async {
    final account = await (_driftDatabaseDatasource.select(
      _driftDatabaseDatasource.accountTable,
    )..where((acc) => acc.id.equals(id))).getSingleOrNull();

    late final Map<String, dynamic> json;

    if (account != null) {
      json = account.toJson();
    } else {
      // Cannot use getAccountById as in response no "remoteAccount" data
      final remoteAccount = (await _accountDatasource.getAccounts()).firstWhere(
        (acc) => acc.id == id,
      );

      final localId = await _driftDatabaseDatasource
          .into(_driftDatabaseDatasource.accountTable)
          .insert(
            AccountTableCompanion.insert(
              userId: remoteAccount.id,
              name: remoteAccount.name,
              balance: remoteAccount.balance.toDouble(),
              currency: remoteAccount.currency,
              createdAt: remoteAccount.createdAt.toIso8601String(),
              updatedAt: remoteAccount.updatedAt.toIso8601String(),
            ),
          );

      json = (await _driftDatabaseDatasource.getAccountByLocalId(
        localId,
      )).toJson();
    }

    json["income_stats"] = [];
    json["expense_stats"] = [];
    return AccountModel.fromJson(json);
  }

  Future<AccountModel> updateLocallyAccountById(
    int id,
    AccountUpdateRequestModel updatedAccount,
  ) async {
    final json = (await _driftDatabaseDatasource.updateAccountById(
      id,
      AccountTableCompanion(
        name: Value(updatedAccount.name),
        balance: Value(updatedAccount.balance.toDouble()),
        currency: Value(updatedAccount.currency),
      ),
    )).toJson();

    return AccountModel.fromJson(json);
  }

  /// Category

  Future<void> _fillCategories() async {
    final categories = await _categoryDatasource.getCategories();

    for (final category in categories) {
      await _driftDatabaseDatasource
          .into(_driftDatabaseDatasource.categoryTable)
          .insert(
            CategoryTableCompanion.insert(
              name: category.name,
              emoji: category.emoji,
              isIncome: category.isIncome,
            ),
          );
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    List<CategoryTableData> categories = await _driftDatabaseDatasource
        .getCategories();
    if (categories.isEmpty) {
      await _fillCategories();
      categories = await _driftDatabaseDatasource.getCategories();
    }
    return categories.map((el) => CategoryModel.fromJson(el.toJson())).toList();
  }

  /// Transactions

  Future<void> _fillTransactions(int accountId) async {
    final transactions = await _transactionDatasource.getTransactionsInPeriod(
      accountId,
      DateTime(2000),
      DateTime.now(),
    );

    for (final transaction in transactions) {
      await _driftDatabaseDatasource.createTransaction(
        TransactionTableCompanion.insert(
          accountId: transaction.account.id,
          categoryId: transaction.category.id,
          amount: transaction.amount.toDouble(),
          transactionDate: transaction.transactionDate.toIso8601String(),
          comment: Value(transaction.comment),
          createdAt: transaction.createdAt.toIso8601String(),
          updatedAt: transaction.updatedAt.toIso8601String(),
        ),
      );
    }
  }

  Future<List<TransactionResponseModel>> getTransactionsInPeriod(
    int accountId, [
    DateTime? startDate,
    DateTime? endDate,
  ]) async {
    if ((await _driftDatabaseDatasource.getTransactionsByAccount(
      accountId,
    )).isEmpty) {
      await _fillTransactions(accountId);
    }

    final transactions = await _driftDatabaseDatasource.getTransactionsInPeriod(
      accountId,
      startDate,
      endDate,
    );
    final transactionsResponseModels = <TransactionResponseModel>[];

    for (final transaction in transactions) {
      final account = await getAccountById(transaction.accountId);
      final category = (await getCategories()).firstWhere(
        (el) => el.id == transaction.categoryId,
      );

      transactionsResponseModels.add(
        TransactionResponseModel(
          id: accountId,
          account: AccountBriefModel.fromAccountModel(account),
          category: category,
          amount: Decimal.parse(transaction.amount.toString()),
          transactionDate: DateTime.parse(
            transaction.transactionDate,
          ).toLocal(),
          createdAt: DateTime.parse(transaction.createdAt).toLocal(),
          updatedAt: DateTime.parse(transaction.updatedAt).toLocal(),
        ),
      );
    }

    return transactionsResponseModels;
  }

  Future<TransactionModel> createLocallyTransaction(
    TransactionRequestModel transaction, [
    int? remoteId,
  ]) async {
    return TransactionModel.fromJson(
      (await _driftDatabaseDatasource.createTransaction(
        TransactionTableCompanion.insert(
          remoteId: Value.absentIfNull(remoteId),
          amount: transaction.amount.toDouble(),
          accountId: transaction.accountId,
          categoryId: transaction.categoryId,
          transactionDate: transaction.transactionDate.toIso8601String(),
          comment: Value.absentIfNull(transaction.comment),
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        ),
      )).toJson(),
    );
  }

  Future<TransactionResponseModel> updateLocallyTransactionById(
    int id,
    TransactionRequestModel transaction, [
    bool isRemoteId = false,
  ]) async {
    final transactionTableData = TransactionTableCompanion(
      amount: Value(transaction.amount.toDouble()),
      accountId: Value(transaction.accountId),
      categoryId: Value(transaction.categoryId),
      transactionDate: Value(transaction.transactionDate.toIso8601String()),
    );
    late final TransactionTableData newTransaction;
    if (isRemoteId) {
      newTransaction = (await _driftDatabaseDatasource
          .updateTransactionByRemoteId(id, transactionTableData));
    } else {
      newTransaction = (await _driftDatabaseDatasource
          .updateTransactionByLocalId(id, transactionTableData));
    }

    return TransactionResponseModel(
      id: newTransaction.id,
      account: AccountBriefModel.fromJson(
        (await _driftDatabaseDatasource.getAccountByLocalId(
          newTransaction.accountId,
        )).toJson(),
      ),
      category: CategoryModel.fromJson(
        (await _driftDatabaseDatasource.getCategoryById(
          newTransaction.categoryId,
        )).toJson(),
      ),
      amount: Decimal.parse(newTransaction.amount.toString()),
      transactionDate: DateTime.parse(newTransaction.transactionDate).toLocal(),
      createdAt: DateTime.parse(newTransaction.createdAt).toLocal(),
      updatedAt: DateTime.parse(newTransaction.updatedAt).toLocal(),
    );
  }

  Future<TransactionTableData> removeLocallyTransactionById(int id) async {
    return await _driftDatabaseDatasource.removeTransactionById(id);
  }
}
