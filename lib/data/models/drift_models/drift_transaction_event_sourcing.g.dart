// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_transaction_event_sourcing.dart';

// ignore_for_file: type=lint
class $TransactionEventTable extends TransactionEvent
    with TableInfo<$TransactionEventTable, TransactionEventData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionEventTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _eventMeta = const VerificationMeta('event');
  @override
  late final GeneratedColumn<String> event = GeneratedColumn<String>(
    'event',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<int> accountId = GeneratedColumn<int>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transactionIdMeta = const VerificationMeta(
    'transactionId',
  );
  @override
  late final GeneratedColumn<int> transactionId = GeneratedColumn<int>(
    'transaction_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transactionDateMeta = const VerificationMeta(
    'transactionDate',
  );
  @override
  late final GeneratedColumn<DateTime> transactionDate =
      GeneratedColumn<DateTime>(
        'transaction_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _commentMeta = const VerificationMeta(
    'comment',
  );
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
    'comment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    event,
    accountId,
    transactionId,
    amount,
    transactionDate,
    comment,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transaction_event';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransactionEventData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('event')) {
      context.handle(
        _eventMeta,
        event.isAcceptableOrUnknown(data['event']!, _eventMeta),
      );
    } else if (isInserting) {
      context.missing(_eventMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
        _transactionIdMeta,
        transactionId.isAcceptableOrUnknown(
          data['transaction_id']!,
          _transactionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('transaction_date')) {
      context.handle(
        _transactionDateMeta,
        transactionDate.isAcceptableOrUnknown(
          data['transaction_date']!,
          _transactionDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionDateMeta);
    }
    if (data.containsKey('comment')) {
      context.handle(
        _commentMeta,
        comment.isAcceptableOrUnknown(data['comment']!, _commentMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  TransactionEventData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionEventData(
      event: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_id'],
      )!,
      transactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}transaction_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      transactionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}transaction_date'],
      )!,
      comment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comment'],
      ),
    );
  }

  @override
  $TransactionEventTable createAlias(String alias) {
    return $TransactionEventTable(attachedDatabase, alias);
  }
}

class TransactionEventData extends DataClass
    implements Insertable<TransactionEventData> {
  final String event;
  final int accountId;
  final int transactionId;
  final double amount;
  final DateTime transactionDate;
  final String? comment;
  const TransactionEventData({
    required this.event,
    required this.accountId,
    required this.transactionId,
    required this.amount,
    required this.transactionDate,
    this.comment,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['event'] = Variable<String>(event);
    map['account_id'] = Variable<int>(accountId);
    map['transaction_id'] = Variable<int>(transactionId);
    map['amount'] = Variable<double>(amount);
    map['transaction_date'] = Variable<DateTime>(transactionDate);
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String>(comment);
    }
    return map;
  }

  TransactionEventCompanion toCompanion(bool nullToAbsent) {
    return TransactionEventCompanion(
      event: Value(event),
      accountId: Value(accountId),
      transactionId: Value(transactionId),
      amount: Value(amount),
      transactionDate: Value(transactionDate),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
    );
  }

  factory TransactionEventData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionEventData(
      event: serializer.fromJson<String>(json['event']),
      accountId: serializer.fromJson<int>(json['accountId']),
      transactionId: serializer.fromJson<int>(json['transactionId']),
      amount: serializer.fromJson<double>(json['amount']),
      transactionDate: serializer.fromJson<DateTime>(json['transactionDate']),
      comment: serializer.fromJson<String?>(json['comment']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'event': serializer.toJson<String>(event),
      'accountId': serializer.toJson<int>(accountId),
      'transactionId': serializer.toJson<int>(transactionId),
      'amount': serializer.toJson<double>(amount),
      'transactionDate': serializer.toJson<DateTime>(transactionDate),
      'comment': serializer.toJson<String?>(comment),
    };
  }

  TransactionEventData copyWith({
    String? event,
    int? accountId,
    int? transactionId,
    double? amount,
    DateTime? transactionDate,
    Value<String?> comment = const Value.absent(),
  }) => TransactionEventData(
    event: event ?? this.event,
    accountId: accountId ?? this.accountId,
    transactionId: transactionId ?? this.transactionId,
    amount: amount ?? this.amount,
    transactionDate: transactionDate ?? this.transactionDate,
    comment: comment.present ? comment.value : this.comment,
  );
  TransactionEventData copyWithCompanion(TransactionEventCompanion data) {
    return TransactionEventData(
      event: data.event.present ? data.event.value : this.event,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      amount: data.amount.present ? data.amount.value : this.amount,
      transactionDate: data.transactionDate.present
          ? data.transactionDate.value
          : this.transactionDate,
      comment: data.comment.present ? data.comment.value : this.comment,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionEventData(')
          ..write('event: $event, ')
          ..write('accountId: $accountId, ')
          ..write('transactionId: $transactionId, ')
          ..write('amount: $amount, ')
          ..write('transactionDate: $transactionDate, ')
          ..write('comment: $comment')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    event,
    accountId,
    transactionId,
    amount,
    transactionDate,
    comment,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionEventData &&
          other.event == this.event &&
          other.accountId == this.accountId &&
          other.transactionId == this.transactionId &&
          other.amount == this.amount &&
          other.transactionDate == this.transactionDate &&
          other.comment == this.comment);
}

class TransactionEventCompanion extends UpdateCompanion<TransactionEventData> {
  final Value<String> event;
  final Value<int> accountId;
  final Value<int> transactionId;
  final Value<double> amount;
  final Value<DateTime> transactionDate;
  final Value<String?> comment;
  final Value<int> rowid;
  const TransactionEventCompanion({
    this.event = const Value.absent(),
    this.accountId = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.amount = const Value.absent(),
    this.transactionDate = const Value.absent(),
    this.comment = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionEventCompanion.insert({
    required String event,
    required int accountId,
    required int transactionId,
    required double amount,
    required DateTime transactionDate,
    this.comment = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : event = Value(event),
       accountId = Value(accountId),
       transactionId = Value(transactionId),
       amount = Value(amount),
       transactionDate = Value(transactionDate);
  static Insertable<TransactionEventData> custom({
    Expression<String>? event,
    Expression<int>? accountId,
    Expression<int>? transactionId,
    Expression<double>? amount,
    Expression<DateTime>? transactionDate,
    Expression<String>? comment,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (event != null) 'event': event,
      if (accountId != null) 'account_id': accountId,
      if (transactionId != null) 'transaction_id': transactionId,
      if (amount != null) 'amount': amount,
      if (transactionDate != null) 'transaction_date': transactionDate,
      if (comment != null) 'comment': comment,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionEventCompanion copyWith({
    Value<String>? event,
    Value<int>? accountId,
    Value<int>? transactionId,
    Value<double>? amount,
    Value<DateTime>? transactionDate,
    Value<String?>? comment,
    Value<int>? rowid,
  }) {
    return TransactionEventCompanion(
      event: event ?? this.event,
      accountId: accountId ?? this.accountId,
      transactionId: transactionId ?? this.transactionId,
      amount: amount ?? this.amount,
      transactionDate: transactionDate ?? this.transactionDate,
      comment: comment ?? this.comment,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (event.present) {
      map['event'] = Variable<String>(event.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<int>(transactionId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (transactionDate.present) {
      map['transaction_date'] = Variable<DateTime>(transactionDate.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionEventCompanion(')
          ..write('event: $event, ')
          ..write('accountId: $accountId, ')
          ..write('transactionId: $transactionId, ')
          ..write('amount: $amount, ')
          ..write('transactionDate: $transactionDate, ')
          ..write('comment: $comment, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AccountEventTable extends AccountEvent
    with TableInfo<$AccountEventTable, AccountEventData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountEventTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<int> accountId = GeneratedColumn<int>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _balanceMeta = const VerificationMeta(
    'balance',
  );
  @override
  late final GeneratedColumn<double> balance = GeneratedColumn<double>(
    'balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [accountId, name, balance, currency];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'account_event';
  @override
  VerificationContext validateIntegrity(
    Insertable<AccountEventData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('balance')) {
      context.handle(
        _balanceMeta,
        balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta),
      );
    } else if (isInserting) {
      context.missing(_balanceMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  AccountEventData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountEventData(
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      balance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}balance'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
    );
  }

  @override
  $AccountEventTable createAlias(String alias) {
    return $AccountEventTable(attachedDatabase, alias);
  }
}

class AccountEventData extends DataClass
    implements Insertable<AccountEventData> {
  final int accountId;
  final String name;
  final double balance;
  final String currency;
  const AccountEventData({
    required this.accountId,
    required this.name,
    required this.balance,
    required this.currency,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['account_id'] = Variable<int>(accountId);
    map['name'] = Variable<String>(name);
    map['balance'] = Variable<double>(balance);
    map['currency'] = Variable<String>(currency);
    return map;
  }

  AccountEventCompanion toCompanion(bool nullToAbsent) {
    return AccountEventCompanion(
      accountId: Value(accountId),
      name: Value(name),
      balance: Value(balance),
      currency: Value(currency),
    );
  }

  factory AccountEventData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountEventData(
      accountId: serializer.fromJson<int>(json['accountId']),
      name: serializer.fromJson<String>(json['name']),
      balance: serializer.fromJson<double>(json['balance']),
      currency: serializer.fromJson<String>(json['currency']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accountId': serializer.toJson<int>(accountId),
      'name': serializer.toJson<String>(name),
      'balance': serializer.toJson<double>(balance),
      'currency': serializer.toJson<String>(currency),
    };
  }

  AccountEventData copyWith({
    int? accountId,
    String? name,
    double? balance,
    String? currency,
  }) => AccountEventData(
    accountId: accountId ?? this.accountId,
    name: name ?? this.name,
    balance: balance ?? this.balance,
    currency: currency ?? this.currency,
  );
  AccountEventData copyWithCompanion(AccountEventCompanion data) {
    return AccountEventData(
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      name: data.name.present ? data.name.value : this.name,
      balance: data.balance.present ? data.balance.value : this.balance,
      currency: data.currency.present ? data.currency.value : this.currency,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountEventData(')
          ..write('accountId: $accountId, ')
          ..write('name: $name, ')
          ..write('balance: $balance, ')
          ..write('currency: $currency')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(accountId, name, balance, currency);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountEventData &&
          other.accountId == this.accountId &&
          other.name == this.name &&
          other.balance == this.balance &&
          other.currency == this.currency);
}

class AccountEventCompanion extends UpdateCompanion<AccountEventData> {
  final Value<int> accountId;
  final Value<String> name;
  final Value<double> balance;
  final Value<String> currency;
  final Value<int> rowid;
  const AccountEventCompanion({
    this.accountId = const Value.absent(),
    this.name = const Value.absent(),
    this.balance = const Value.absent(),
    this.currency = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AccountEventCompanion.insert({
    required int accountId,
    required String name,
    required double balance,
    required String currency,
    this.rowid = const Value.absent(),
  }) : accountId = Value(accountId),
       name = Value(name),
       balance = Value(balance),
       currency = Value(currency);
  static Insertable<AccountEventData> custom({
    Expression<int>? accountId,
    Expression<String>? name,
    Expression<double>? balance,
    Expression<String>? currency,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (accountId != null) 'account_id': accountId,
      if (name != null) 'name': name,
      if (balance != null) 'balance': balance,
      if (currency != null) 'currency': currency,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AccountEventCompanion copyWith({
    Value<int>? accountId,
    Value<String>? name,
    Value<double>? balance,
    Value<String>? currency,
    Value<int>? rowid,
  }) {
    return AccountEventCompanion(
      accountId: accountId ?? this.accountId,
      name: name ?? this.name,
      balance: balance ?? this.balance,
      currency: currency ?? this.currency,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (balance.present) {
      map['balance'] = Variable<double>(balance.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountEventCompanion(')
          ..write('accountId: $accountId, ')
          ..write('name: $name, ')
          ..write('balance: $balance, ')
          ..write('currency: $currency, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$EventSourcingDatabase extends GeneratedDatabase {
  _$EventSourcingDatabase(QueryExecutor e) : super(e);
  $EventSourcingDatabaseManager get managers =>
      $EventSourcingDatabaseManager(this);
  late final $TransactionEventTable transactionEvent = $TransactionEventTable(
    this,
  );
  late final $AccountEventTable accountEvent = $AccountEventTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    transactionEvent,
    accountEvent,
  ];
}

typedef $$TransactionEventTableCreateCompanionBuilder =
    TransactionEventCompanion Function({
      required String event,
      required int accountId,
      required int transactionId,
      required double amount,
      required DateTime transactionDate,
      Value<String?> comment,
      Value<int> rowid,
    });
typedef $$TransactionEventTableUpdateCompanionBuilder =
    TransactionEventCompanion Function({
      Value<String> event,
      Value<int> accountId,
      Value<int> transactionId,
      Value<double> amount,
      Value<DateTime> transactionDate,
      Value<String?> comment,
      Value<int> rowid,
    });

class $$TransactionEventTableFilterComposer
    extends Composer<_$EventSourcingDatabase, $TransactionEventTable> {
  $$TransactionEventTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get event => $composableBuilder(
    column: $table.event,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TransactionEventTableOrderingComposer
    extends Composer<_$EventSourcingDatabase, $TransactionEventTable> {
  $$TransactionEventTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get event => $composableBuilder(
    column: $table.event,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TransactionEventTableAnnotationComposer
    extends Composer<_$EventSourcingDatabase, $TransactionEventTable> {
  $$TransactionEventTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get event =>
      $composableBuilder(column: $table.event, builder: (column) => column);

  GeneratedColumn<int> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<int> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);
}

class $$TransactionEventTableTableManager
    extends
        RootTableManager<
          _$EventSourcingDatabase,
          $TransactionEventTable,
          TransactionEventData,
          $$TransactionEventTableFilterComposer,
          $$TransactionEventTableOrderingComposer,
          $$TransactionEventTableAnnotationComposer,
          $$TransactionEventTableCreateCompanionBuilder,
          $$TransactionEventTableUpdateCompanionBuilder,
          (
            TransactionEventData,
            BaseReferences<
              _$EventSourcingDatabase,
              $TransactionEventTable,
              TransactionEventData
            >,
          ),
          TransactionEventData,
          PrefetchHooks Function()
        > {
  $$TransactionEventTableTableManager(
    _$EventSourcingDatabase db,
    $TransactionEventTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionEventTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionEventTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionEventTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> event = const Value.absent(),
                Value<int> accountId = const Value.absent(),
                Value<int> transactionId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<DateTime> transactionDate = const Value.absent(),
                Value<String?> comment = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionEventCompanion(
                event: event,
                accountId: accountId,
                transactionId: transactionId,
                amount: amount,
                transactionDate: transactionDate,
                comment: comment,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String event,
                required int accountId,
                required int transactionId,
                required double amount,
                required DateTime transactionDate,
                Value<String?> comment = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionEventCompanion.insert(
                event: event,
                accountId: accountId,
                transactionId: transactionId,
                amount: amount,
                transactionDate: transactionDate,
                comment: comment,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TransactionEventTableProcessedTableManager =
    ProcessedTableManager<
      _$EventSourcingDatabase,
      $TransactionEventTable,
      TransactionEventData,
      $$TransactionEventTableFilterComposer,
      $$TransactionEventTableOrderingComposer,
      $$TransactionEventTableAnnotationComposer,
      $$TransactionEventTableCreateCompanionBuilder,
      $$TransactionEventTableUpdateCompanionBuilder,
      (
        TransactionEventData,
        BaseReferences<
          _$EventSourcingDatabase,
          $TransactionEventTable,
          TransactionEventData
        >,
      ),
      TransactionEventData,
      PrefetchHooks Function()
    >;
typedef $$AccountEventTableCreateCompanionBuilder =
    AccountEventCompanion Function({
      required int accountId,
      required String name,
      required double balance,
      required String currency,
      Value<int> rowid,
    });
typedef $$AccountEventTableUpdateCompanionBuilder =
    AccountEventCompanion Function({
      Value<int> accountId,
      Value<String> name,
      Value<double> balance,
      Value<String> currency,
      Value<int> rowid,
    });

class $$AccountEventTableFilterComposer
    extends Composer<_$EventSourcingDatabase, $AccountEventTable> {
  $$AccountEventTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AccountEventTableOrderingComposer
    extends Composer<_$EventSourcingDatabase, $AccountEventTable> {
  $$AccountEventTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AccountEventTableAnnotationComposer
    extends Composer<_$EventSourcingDatabase, $AccountEventTable> {
  $$AccountEventTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get balance =>
      $composableBuilder(column: $table.balance, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);
}

class $$AccountEventTableTableManager
    extends
        RootTableManager<
          _$EventSourcingDatabase,
          $AccountEventTable,
          AccountEventData,
          $$AccountEventTableFilterComposer,
          $$AccountEventTableOrderingComposer,
          $$AccountEventTableAnnotationComposer,
          $$AccountEventTableCreateCompanionBuilder,
          $$AccountEventTableUpdateCompanionBuilder,
          (
            AccountEventData,
            BaseReferences<
              _$EventSourcingDatabase,
              $AccountEventTable,
              AccountEventData
            >,
          ),
          AccountEventData,
          PrefetchHooks Function()
        > {
  $$AccountEventTableTableManager(
    _$EventSourcingDatabase db,
    $AccountEventTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountEventTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountEventTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountEventTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> accountId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> balance = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccountEventCompanion(
                accountId: accountId,
                name: name,
                balance: balance,
                currency: currency,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int accountId,
                required String name,
                required double balance,
                required String currency,
                Value<int> rowid = const Value.absent(),
              }) => AccountEventCompanion.insert(
                accountId: accountId,
                name: name,
                balance: balance,
                currency: currency,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AccountEventTableProcessedTableManager =
    ProcessedTableManager<
      _$EventSourcingDatabase,
      $AccountEventTable,
      AccountEventData,
      $$AccountEventTableFilterComposer,
      $$AccountEventTableOrderingComposer,
      $$AccountEventTableAnnotationComposer,
      $$AccountEventTableCreateCompanionBuilder,
      $$AccountEventTableUpdateCompanionBuilder,
      (
        AccountEventData,
        BaseReferences<
          _$EventSourcingDatabase,
          $AccountEventTable,
          AccountEventData
        >,
      ),
      AccountEventData,
      PrefetchHooks Function()
    >;

class $EventSourcingDatabaseManager {
  final _$EventSourcingDatabase _db;
  $EventSourcingDatabaseManager(this._db);
  $$TransactionEventTableTableManager get transactionEvent =>
      $$TransactionEventTableTableManager(_db, _db.transactionEvent);
  $$AccountEventTableTableManager get accountEvent =>
      $$AccountEventTableTableManager(_db, _db.accountEvent);
}
