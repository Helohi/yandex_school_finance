import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part "drift_transaction_event_sourcing.g.dart";

class TransactionEvent extends Table {
  TextColumn get event => text()();
  IntColumn get accountId => integer()();
  IntColumn get transactionId => integer()();
  RealColumn get amount => real()();
  DateTimeColumn get transactionDate => dateTime()();
  TextColumn get comment => text().nullable()();
}

class AccountEvent extends Table {
  IntColumn get accountId => integer()();
  TextColumn get name => text()();
  RealColumn get balance => real()();
  TextColumn get currency => text()();
}

@DriftDatabase(tables: [TransactionEvent, AccountEvent])
class EventSourcingDatabase extends _$EventSourcingDatabase {
  EventSourcingDatabase() : super(driftDatabase(name: 'event_sourcing'));

  @override
  int get schemaVersion => 1;
}
