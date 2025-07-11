import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:yandex_school_finance/core/datasource_failures.dart';
import 'package:yandex_school_finance/data/datasources/swagger/swagger_bank_account_datasource.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_history_response_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_update_request_model.dart';
import 'package:yandex_school_finance/data/repositories/swagger_repositories/swagger_drift_connection.dart';
import 'package:yandex_school_finance/domain/entity/synced_response.dart';
import 'package:yandex_school_finance/domain/repositories/bank_account_repository.dart';

class SwaggerBankAccountRepositories implements BankAccountRepository {
  final SwaggerBankAccountDatasource _bankAccountDatasource;
  final SwaggerDriftConnection _driftConnection;

  SwaggerBankAccountRepositories(
    this._bankAccountDatasource,
    this._driftConnection,
  );

  @override
  Future<Either<Failure, SyncedResponse<AccountModel>>> getAccountById(
    int id,
  ) async {
    final bool isSynced = await _driftConnection.sync();

    try {
      final account = await _driftConnection.getAccountById(id);
      return Right(SyncedResponse(account, isSynced: isSynced));
    } catch (e) {
      log("${e.runtimeType} in $runtimeType.getAccountById: $e");
      return Left(UnhandledFailure());
    }
  }

  @override
  Future<Either<Failure, SyncedResponse<AccountHistoryResponseModel>>>
  getAccountHistory(int id) async {
    final isSynced = await _driftConnection.sync();

    try {
      return Right(
        SyncedResponse(
          await _bankAccountDatasource.getAccountHistory(id),
          isSynced: isSynced,
        ),
      );
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      log("${e.runtimeType} in $runtimeType.getAccountHistory: $e");
      return Left(UnhandledFailure());
    }
  }

  @override
  Future<Either<Failure, SyncedResponse<List<AccountModel>>>>
  getAccounts() async {
    final isSynced = await _driftConnection.sync();

    try {
      return Right(
        SyncedResponse(
          await _driftConnection.getAccounts(),
          isSynced: isSynced,
        ),
      );
    } on Failure catch (f) {
      return Left(f);
    } catch (e, stacktrace) {
      log("${e.runtimeType} in $runtimeType.getAccounts: $e\n$stacktrace");
      return Left(UnhandledFailure());
    }
  }

  @override
  Future<Either<Failure, SyncedResponse<AccountModel>>> updateAccountById(
    int id,
    AccountUpdateRequestModel updatedAccount,
  ) async {
    try {
      final updatedAccount_ = await _driftConnection.updateLocallyAccountById(
        id,
        updatedAccount,
      );
      await _driftConnection.addUpdateAccountByIdBackup(
        id,
        updatedAccount_.id,
        updatedAccount,
      );
      final isSynced = await _driftConnection.sync();
      return Right(SyncedResponse(updatedAccount_, isSynced: isSynced));
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      log("${e.runtimeType} in $runtimeType.updateAccountById: $e");
      return Left(UnhandledFailure());
    }
  }
}
