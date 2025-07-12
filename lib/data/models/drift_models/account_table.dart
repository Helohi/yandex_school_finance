import 'package:drift/drift.dart';
import 'package:yandex_school_finance/core/enums/currency_enum.dart';
import 'package:yandex_school_finance/core/utils/date_time_converter.dart';

class AccountTable extends Table {
  IntColumn get id => integer()();
  IntColumn get userId => integer()();
  TextColumn get name => text()();
  RealColumn get balance => real()();
  TextColumn get currency => textEnum<CurrencyEnum>()();
  DateTimeColumn get createdAt => dateTime().map(DateTimeTypeConverter())();
  DateTimeColumn get updatedAt => dateTime().map(DateTimeTypeConverter())();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
