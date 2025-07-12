import 'package:drift/drift.dart';
import 'package:yandex_school_finance/core/utils/date_time_converter.dart';

class TransactionTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get remoteId => integer().nullable().unique()();
  IntColumn get accountId => integer()();
  IntColumn get categoryId => integer()();
  RealColumn get amount => real()();
  DateTimeColumn get transactionDate =>
      dateTime().map(DateTimeTypeConverter())();
  TextColumn get comment => text().nullable()();
  DateTimeColumn get createdAt => dateTime().map(DateTimeTypeConverter())();
  DateTimeColumn get updatedAt => dateTime().map(DateTimeTypeConverter())();
}
