import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:yandex_school_finance/core/enums/currency_enum.dart';
import 'package:yandex_school_finance/core/enums/entity_enum.dart';
import 'package:yandex_school_finance/core/enums/operation_enum.dart';
import 'package:yandex_school_finance/core/utils/date_time_converter.dart';
import 'package:yandex_school_finance/data/models/drift_models/account_table.dart';
import 'package:yandex_school_finance/data/models/drift_models/backup_operation_table.dart';
import 'package:yandex_school_finance/data/models/drift_models/category_table.dart';
import 'package:yandex_school_finance/data/models/drift_models/transaction_table.dart';

part "drift_database_datasource.g.dart";

@DriftDatabase(
  tables: [TransactionTable, AccountTable, CategoryTable, BackupOperationTable],
)
class DriftDatabaseDatasource extends _$DriftDatabaseDatasource {
  DriftDatabaseDatasource() : super(driftDatabase(name: 'local_database'));

  @override
  int get schemaVersion => 1;

  Future<void> dropEverything() async {
    final tables = allTables.toList().reversed;

    for (final table in tables) {
      await delete(table).go();
    }
  }

  /// Accounts

  Future<List<AccountTableData>> getAccounts() {
    return select(accountTable).get();
  }

  Future<AccountTableData> getAccountByLocalId(int id) {
    return (select(accountTable)..where((a) => a.id.equals(id))).getSingle();
  }

  Future<AccountTableData> updateAccountById(
    int id,
    AccountTableCompanion payload,
  ) async {
    await (update(accountTable)..where((a) => a.id.equals(id))).write(payload);
    return (select(accountTable)..where((a) => a.id.equals(id))).getSingle();
  }

  /// Category

  Future<List<CategoryTableData>> getCategories() {
    return select(categoryTable).get();
  }

  Future<CategoryTableData> getCategoryById(int id) {
    return (select(categoryTable)..where((c) => c.id.equals(id))).getSingle();
  }

  /// Transaction

  Future<List<TransactionTableData>> getTransactionsInPeriod(
    int accountId, [
    DateTime? startDate,
    DateTime? endDate,
  ]) {
    final now = DateTime.now();
    startDate ??= now.copyWith(day: 1, hour: 0, minute: 0, second: 0);
    endDate ??= now
        .copyWith(month: now.month + 1, day: 0, hour: 0, minute: 0, second: 0)
        .subtract(Duration(days: 1));

    return (select(transactionTable)..where(
          (t) =>
              t.accountId.equals(accountId) &
              t.transactionDate.isBetweenValues(startDate!, endDate!),
        ))
        .get();
  }

  Future<List<TransactionTableData>> getTransactionsByAccount(int accountId) {
    return (select(
      transactionTable,
    )..where((t) => t.accountId.equals(accountId))).get();
  }

  Future<TransactionTableData> createTransaction(
    TransactionTableCompanion transaction,
  ) async {
    final newId = await into(transactionTable).insert(transaction);

    return (select(
      transactionTable,
    )..where((t) => t.id.equals(newId))).getSingle();
  }

  Future<TransactionTableData> updateTransactionByLocalId(
    int id,
    TransactionTableCompanion transaction,
  ) async {
    await (update(
      transactionTable,
    )..where((t) => t.id.equals(id))).write(transaction);

    return (select(
      transactionTable,
    )..where((t) => t.id.equals(id))).getSingle();
  }

  Future<TransactionTableData> updateTransactionByRemoteId(
    int id,
    TransactionTableCompanion transaction,
  ) async {
    await (update(
      transactionTable,
    )..where((t) => t.remoteId.equals(id))).write(transaction);

    return (select(
      transactionTable,
    )..where((t) => t.remoteId.equals(id))).getSingle();
  }

  Future<TransactionTableData> removeTransactionById(int id) async {
    final transactionToDelete = await (select(
      transactionTable,
    )..where((t) => t.id.equals(id))).getSingle();

    await (delete(transactionTable)..where((t) => t.id.equals(id))).go();
    return transactionToDelete;
  }

  /// Backup Operations (Event Sourcing)

  Future<List<BackupOperationTableData>> getBackupOperations() {
    return select(backupOperationTable).get();
  }

  Future<BackupOperationTableData> createOrUpdateBackupOperation(
    BackupOperationTableCompanion operation,
  ) async {
    final localId = (await into(
      backupOperationTable,
    ).insertOnConflictUpdate(operation));
    return (select(
      backupOperationTable,
    )..where((o) => o.id.equals(localId))).getSingle();
  }

  Future<void> removeBackupOperationById(int id) {
    return (delete(backupOperationTable)..where((o) => o.id.equals(id))).go();
  }
}
