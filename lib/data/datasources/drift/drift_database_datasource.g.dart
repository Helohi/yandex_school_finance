// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database_datasource.dart';

// ignore_for_file: type=lint
class $TransactionTableTable extends TransactionTable
    with TableInfo<$TransactionTableTable, TransactionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<int> remoteId = GeneratedColumn<int>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
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
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
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
  @override
  late final GeneratedColumnWithTypeConverter<String, DateTime>
  transactionDate = GeneratedColumn<DateTime>(
    'transaction_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  ).withConverter<String>($TransactionTableTable.$convertertransactionDate);
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
  late final GeneratedColumnWithTypeConverter<String, DateTime> createdAt =
      GeneratedColumn<DateTime>(
        'created_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      ).withConverter<String>($TransactionTableTable.$convertercreatedAt);
  @override
  late final GeneratedColumnWithTypeConverter<String, DateTime> updatedAt =
      GeneratedColumn<DateTime>(
        'updated_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      ).withConverter<String>($TransactionTableTable.$converterupdatedAt);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    remoteId,
    accountId,
    categoryId,
    amount,
    transactionDate,
    comment,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transaction_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransactionTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remote_id'],
      ),
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      transactionDate: $TransactionTableTable.$convertertransactionDate.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}transaction_date'],
        )!,
      ),
      comment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comment'],
      ),
      createdAt: $TransactionTableTable.$convertercreatedAt.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}created_at'],
        )!,
      ),
      updatedAt: $TransactionTableTable.$converterupdatedAt.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}updated_at'],
        )!,
      ),
    );
  }

  @override
  $TransactionTableTable createAlias(String alias) {
    return $TransactionTableTable(attachedDatabase, alias);
  }

  static TypeConverter<String, DateTime> $convertertransactionDate =
      DateTimeTypeConverter();
  static TypeConverter<String, DateTime> $convertercreatedAt =
      DateTimeTypeConverter();
  static TypeConverter<String, DateTime> $converterupdatedAt =
      DateTimeTypeConverter();
}

class TransactionTableData extends DataClass
    implements Insertable<TransactionTableData> {
  final int id;
  final int? remoteId;
  final int accountId;
  final int categoryId;
  final double amount;
  final String transactionDate;
  final String? comment;
  final String createdAt;
  final String updatedAt;
  const TransactionTableData({
    required this.id,
    this.remoteId,
    required this.accountId,
    required this.categoryId,
    required this.amount,
    required this.transactionDate,
    this.comment,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<int>(remoteId);
    }
    map['account_id'] = Variable<int>(accountId);
    map['category_id'] = Variable<int>(categoryId);
    map['amount'] = Variable<double>(amount);
    {
      map['transaction_date'] = Variable<DateTime>(
        $TransactionTableTable.$convertertransactionDate.toSql(transactionDate),
      );
    }
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String>(comment);
    }
    {
      map['created_at'] = Variable<DateTime>(
        $TransactionTableTable.$convertercreatedAt.toSql(createdAt),
      );
    }
    {
      map['updated_at'] = Variable<DateTime>(
        $TransactionTableTable.$converterupdatedAt.toSql(updatedAt),
      );
    }
    return map;
  }

  TransactionTableCompanion toCompanion(bool nullToAbsent) {
    return TransactionTableCompanion(
      id: Value(id),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      accountId: Value(accountId),
      categoryId: Value(categoryId),
      amount: Value(amount),
      transactionDate: Value(transactionDate),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TransactionTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionTableData(
      id: serializer.fromJson<int>(json['id']),
      remoteId: serializer.fromJson<int?>(json['remoteId']),
      accountId: serializer.fromJson<int>(json['accountId']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      amount: serializer.fromJson<double>(json['amount']),
      transactionDate: serializer.fromJson<String>(json['transactionDate']),
      comment: serializer.fromJson<String?>(json['comment']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'remoteId': serializer.toJson<int?>(remoteId),
      'accountId': serializer.toJson<int>(accountId),
      'categoryId': serializer.toJson<int>(categoryId),
      'amount': serializer.toJson<double>(amount),
      'transactionDate': serializer.toJson<String>(transactionDate),
      'comment': serializer.toJson<String?>(comment),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  TransactionTableData copyWith({
    int? id,
    Value<int?> remoteId = const Value.absent(),
    int? accountId,
    int? categoryId,
    double? amount,
    String? transactionDate,
    Value<String?> comment = const Value.absent(),
    String? createdAt,
    String? updatedAt,
  }) => TransactionTableData(
    id: id ?? this.id,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    accountId: accountId ?? this.accountId,
    categoryId: categoryId ?? this.categoryId,
    amount: amount ?? this.amount,
    transactionDate: transactionDate ?? this.transactionDate,
    comment: comment.present ? comment.value : this.comment,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  TransactionTableData copyWithCompanion(TransactionTableCompanion data) {
    return TransactionTableData(
      id: data.id.present ? data.id.value : this.id,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      amount: data.amount.present ? data.amount.value : this.amount,
      transactionDate: data.transactionDate.present
          ? data.transactionDate.value
          : this.transactionDate,
      comment: data.comment.present ? data.comment.value : this.comment,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionTableData(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('accountId: $accountId, ')
          ..write('categoryId: $categoryId, ')
          ..write('amount: $amount, ')
          ..write('transactionDate: $transactionDate, ')
          ..write('comment: $comment, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    remoteId,
    accountId,
    categoryId,
    amount,
    transactionDate,
    comment,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionTableData &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.accountId == this.accountId &&
          other.categoryId == this.categoryId &&
          other.amount == this.amount &&
          other.transactionDate == this.transactionDate &&
          other.comment == this.comment &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TransactionTableCompanion extends UpdateCompanion<TransactionTableData> {
  final Value<int> id;
  final Value<int?> remoteId;
  final Value<int> accountId;
  final Value<int> categoryId;
  final Value<double> amount;
  final Value<String> transactionDate;
  final Value<String?> comment;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  const TransactionTableCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.amount = const Value.absent(),
    this.transactionDate = const Value.absent(),
    this.comment = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TransactionTableCompanion.insert({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    required int accountId,
    required int categoryId,
    required double amount,
    required String transactionDate,
    this.comment = const Value.absent(),
    required String createdAt,
    required String updatedAt,
  }) : accountId = Value(accountId),
       categoryId = Value(categoryId),
       amount = Value(amount),
       transactionDate = Value(transactionDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<TransactionTableData> custom({
    Expression<int>? id,
    Expression<int>? remoteId,
    Expression<int>? accountId,
    Expression<int>? categoryId,
    Expression<double>? amount,
    Expression<DateTime>? transactionDate,
    Expression<String>? comment,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (accountId != null) 'account_id': accountId,
      if (categoryId != null) 'category_id': categoryId,
      if (amount != null) 'amount': amount,
      if (transactionDate != null) 'transaction_date': transactionDate,
      if (comment != null) 'comment': comment,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TransactionTableCompanion copyWith({
    Value<int>? id,
    Value<int?>? remoteId,
    Value<int>? accountId,
    Value<int>? categoryId,
    Value<double>? amount,
    Value<String>? transactionDate,
    Value<String?>? comment,
    Value<String>? createdAt,
    Value<String>? updatedAt,
  }) {
    return TransactionTableCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      accountId: accountId ?? this.accountId,
      categoryId: categoryId ?? this.categoryId,
      amount: amount ?? this.amount,
      transactionDate: transactionDate ?? this.transactionDate,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<int>(remoteId.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (transactionDate.present) {
      map['transaction_date'] = Variable<DateTime>(
        $TransactionTableTable.$convertertransactionDate.toSql(
          transactionDate.value,
        ),
      );
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(
        $TransactionTableTable.$convertercreatedAt.toSql(createdAt.value),
      );
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(
        $TransactionTableTable.$converterupdatedAt.toSql(updatedAt.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionTableCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('accountId: $accountId, ')
          ..write('categoryId: $categoryId, ')
          ..write('amount: $amount, ')
          ..write('transactionDate: $transactionDate, ')
          ..write('comment: $comment, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AccountTableTable extends AccountTable
    with TableInfo<$AccountTableTable, AccountTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
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
  @override
  late final GeneratedColumnWithTypeConverter<CurrencyEnum, String> currency =
      GeneratedColumn<String>(
        'currency',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<CurrencyEnum>($AccountTableTable.$convertercurrency);
  @override
  late final GeneratedColumnWithTypeConverter<String, DateTime> createdAt =
      GeneratedColumn<DateTime>(
        'created_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      ).withConverter<String>($AccountTableTable.$convertercreatedAt);
  @override
  late final GeneratedColumnWithTypeConverter<String, DateTime> updatedAt =
      GeneratedColumn<DateTime>(
        'updated_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      ).withConverter<String>($AccountTableTable.$converterupdatedAt);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    name,
    balance,
    currency,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'account_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AccountTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      balance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}balance'],
      )!,
      currency: $AccountTableTable.$convertercurrency.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}currency'],
        )!,
      ),
      createdAt: $AccountTableTable.$convertercreatedAt.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}created_at'],
        )!,
      ),
      updatedAt: $AccountTableTable.$converterupdatedAt.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}updated_at'],
        )!,
      ),
    );
  }

  @override
  $AccountTableTable createAlias(String alias) {
    return $AccountTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CurrencyEnum, String, String> $convertercurrency =
      const EnumNameConverter<CurrencyEnum>(CurrencyEnum.values);
  static TypeConverter<String, DateTime> $convertercreatedAt =
      DateTimeTypeConverter();
  static TypeConverter<String, DateTime> $converterupdatedAt =
      DateTimeTypeConverter();
}

class AccountTableData extends DataClass
    implements Insertable<AccountTableData> {
  final int id;
  final int userId;
  final String name;
  final double balance;
  final CurrencyEnum currency;
  final String createdAt;
  final String updatedAt;
  const AccountTableData({
    required this.id,
    required this.userId,
    required this.name,
    required this.balance,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['name'] = Variable<String>(name);
    map['balance'] = Variable<double>(balance);
    {
      map['currency'] = Variable<String>(
        $AccountTableTable.$convertercurrency.toSql(currency),
      );
    }
    {
      map['created_at'] = Variable<DateTime>(
        $AccountTableTable.$convertercreatedAt.toSql(createdAt),
      );
    }
    {
      map['updated_at'] = Variable<DateTime>(
        $AccountTableTable.$converterupdatedAt.toSql(updatedAt),
      );
    }
    return map;
  }

  AccountTableCompanion toCompanion(bool nullToAbsent) {
    return AccountTableCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      balance: Value(balance),
      currency: Value(currency),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AccountTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountTableData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      balance: serializer.fromJson<double>(json['balance']),
      currency: $AccountTableTable.$convertercurrency.fromJson(
        serializer.fromJson<String>(json['currency']),
      ),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'name': serializer.toJson<String>(name),
      'balance': serializer.toJson<double>(balance),
      'currency': serializer.toJson<String>(
        $AccountTableTable.$convertercurrency.toJson(currency),
      ),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  AccountTableData copyWith({
    int? id,
    int? userId,
    String? name,
    double? balance,
    CurrencyEnum? currency,
    String? createdAt,
    String? updatedAt,
  }) => AccountTableData(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    name: name ?? this.name,
    balance: balance ?? this.balance,
    currency: currency ?? this.currency,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AccountTableData copyWithCompanion(AccountTableCompanion data) {
    return AccountTableData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      balance: data.balance.present ? data.balance.value : this.balance,
      currency: data.currency.present ? data.currency.value : this.currency,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountTableData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('balance: $balance, ')
          ..write('currency: $currency, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, name, balance, currency, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountTableData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.balance == this.balance &&
          other.currency == this.currency &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AccountTableCompanion extends UpdateCompanion<AccountTableData> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> name;
  final Value<double> balance;
  final Value<CurrencyEnum> currency;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  const AccountTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.balance = const Value.absent(),
    this.currency = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AccountTableCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String name,
    required double balance,
    required CurrencyEnum currency,
    required String createdAt,
    required String updatedAt,
  }) : userId = Value(userId),
       name = Value(name),
       balance = Value(balance),
       currency = Value(currency),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<AccountTableData> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? name,
    Expression<double>? balance,
    Expression<String>? currency,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (balance != null) 'balance': balance,
      if (currency != null) 'currency': currency,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AccountTableCompanion copyWith({
    Value<int>? id,
    Value<int>? userId,
    Value<String>? name,
    Value<double>? balance,
    Value<CurrencyEnum>? currency,
    Value<String>? createdAt,
    Value<String>? updatedAt,
  }) {
    return AccountTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      balance: balance ?? this.balance,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (balance.present) {
      map['balance'] = Variable<double>(balance.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(
        $AccountTableTable.$convertercurrency.toSql(currency.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(
        $AccountTableTable.$convertercreatedAt.toSql(createdAt.value),
      );
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(
        $AccountTableTable.$converterupdatedAt.toSql(updatedAt.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('balance: $balance, ')
          ..write('currency: $currency, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CategoryTableTable extends CategoryTable
    with TableInfo<$CategoryTableTable, CategoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
  static const VerificationMeta _emojiMeta = const VerificationMeta('emoji');
  @override
  late final GeneratedColumn<String> emoji = GeneratedColumn<String>(
    'emoji',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isIncomeMeta = const VerificationMeta(
    'isIncome',
  );
  @override
  late final GeneratedColumn<bool> isIncome = GeneratedColumn<bool>(
    'is_income',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_income" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, emoji, isIncome];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoryTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('emoji')) {
      context.handle(
        _emojiMeta,
        emoji.isAcceptableOrUnknown(data['emoji']!, _emojiMeta),
      );
    } else if (isInserting) {
      context.missing(_emojiMeta);
    }
    if (data.containsKey('is_income')) {
      context.handle(
        _isIncomeMeta,
        isIncome.isAcceptableOrUnknown(data['is_income']!, _isIncomeMeta),
      );
    } else if (isInserting) {
      context.missing(_isIncomeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      emoji: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emoji'],
      )!,
      isIncome: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_income'],
      )!,
    );
  }

  @override
  $CategoryTableTable createAlias(String alias) {
    return $CategoryTableTable(attachedDatabase, alias);
  }
}

class CategoryTableData extends DataClass
    implements Insertable<CategoryTableData> {
  final int id;
  final String name;
  final String emoji;
  final bool isIncome;
  const CategoryTableData({
    required this.id,
    required this.name,
    required this.emoji,
    required this.isIncome,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['emoji'] = Variable<String>(emoji);
    map['is_income'] = Variable<bool>(isIncome);
    return map;
  }

  CategoryTableCompanion toCompanion(bool nullToAbsent) {
    return CategoryTableCompanion(
      id: Value(id),
      name: Value(name),
      emoji: Value(emoji),
      isIncome: Value(isIncome),
    );
  }

  factory CategoryTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      emoji: serializer.fromJson<String>(json['emoji']),
      isIncome: serializer.fromJson<bool>(json['isIncome']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'emoji': serializer.toJson<String>(emoji),
      'isIncome': serializer.toJson<bool>(isIncome),
    };
  }

  CategoryTableData copyWith({
    int? id,
    String? name,
    String? emoji,
    bool? isIncome,
  }) => CategoryTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    emoji: emoji ?? this.emoji,
    isIncome: isIncome ?? this.isIncome,
  );
  CategoryTableData copyWithCompanion(CategoryTableCompanion data) {
    return CategoryTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      emoji: data.emoji.present ? data.emoji.value : this.emoji,
      isIncome: data.isIncome.present ? data.isIncome.value : this.isIncome,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('emoji: $emoji, ')
          ..write('isIncome: $isIncome')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, emoji, isIncome);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.emoji == this.emoji &&
          other.isIncome == this.isIncome);
}

class CategoryTableCompanion extends UpdateCompanion<CategoryTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> emoji;
  final Value<bool> isIncome;
  const CategoryTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.emoji = const Value.absent(),
    this.isIncome = const Value.absent(),
  });
  CategoryTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String emoji,
    required bool isIncome,
  }) : name = Value(name),
       emoji = Value(emoji),
       isIncome = Value(isIncome);
  static Insertable<CategoryTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? emoji,
    Expression<bool>? isIncome,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (emoji != null) 'emoji': emoji,
      if (isIncome != null) 'is_income': isIncome,
    });
  }

  CategoryTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? emoji,
    Value<bool>? isIncome,
  }) {
    return CategoryTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      isIncome: isIncome ?? this.isIncome,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (emoji.present) {
      map['emoji'] = Variable<String>(emoji.value);
    }
    if (isIncome.present) {
      map['is_income'] = Variable<bool>(isIncome.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('emoji: $emoji, ')
          ..write('isIncome: $isIncome')
          ..write(')'))
        .toString();
  }
}

class $BackupOperationTableTable extends BackupOperationTable
    with TableInfo<$BackupOperationTableTable, BackupOperationTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BackupOperationTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<EntityEnum, int> entityType =
      GeneratedColumn<int>(
        'entity_type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<EntityEnum>(
        $BackupOperationTableTable.$converterentityType,
      );
  @override
  late final GeneratedColumnWithTypeConverter<OperationEnum, int>
  operationType =
      GeneratedColumn<int>(
        'operation_type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<OperationEnum>(
        $BackupOperationTableTable.$converteroperationType,
      );
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<int> localId = GeneratedColumn<int>(
    'local_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<int> remoteId = GeneratedColumn<int>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entityType,
    operationType,
    localId,
    remoteId,
    payload,
    timestamp,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'backup_operation_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<BackupOperationTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    } else if (isInserting) {
      context.missing(_localIdMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BackupOperationTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BackupOperationTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      entityType: $BackupOperationTableTable.$converterentityType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}entity_type'],
        )!,
      ),
      operationType: $BackupOperationTableTable.$converteroperationType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}operation_type'],
        )!,
      ),
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remote_id'],
      ),
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
    );
  }

  @override
  $BackupOperationTableTable createAlias(String alias) {
    return $BackupOperationTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<EntityEnum, int, int> $converterentityType =
      const EnumIndexConverter<EntityEnum>(EntityEnum.values);
  static JsonTypeConverter2<OperationEnum, int, int> $converteroperationType =
      const EnumIndexConverter<OperationEnum>(OperationEnum.values);
}

class BackupOperationTableData extends DataClass
    implements Insertable<BackupOperationTableData> {
  final int id;
  final EntityEnum entityType;
  final OperationEnum operationType;
  final int localId;
  final int? remoteId;
  final String payload;
  final DateTime timestamp;
  const BackupOperationTableData({
    required this.id,
    required this.entityType,
    required this.operationType,
    required this.localId,
    this.remoteId,
    required this.payload,
    required this.timestamp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['entity_type'] = Variable<int>(
        $BackupOperationTableTable.$converterentityType.toSql(entityType),
      );
    }
    {
      map['operation_type'] = Variable<int>(
        $BackupOperationTableTable.$converteroperationType.toSql(operationType),
      );
    }
    map['local_id'] = Variable<int>(localId);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<int>(remoteId);
    }
    map['payload'] = Variable<String>(payload);
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  BackupOperationTableCompanion toCompanion(bool nullToAbsent) {
    return BackupOperationTableCompanion(
      id: Value(id),
      entityType: Value(entityType),
      operationType: Value(operationType),
      localId: Value(localId),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      payload: Value(payload),
      timestamp: Value(timestamp),
    );
  }

  factory BackupOperationTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BackupOperationTableData(
      id: serializer.fromJson<int>(json['id']),
      entityType: $BackupOperationTableTable.$converterentityType.fromJson(
        serializer.fromJson<int>(json['entityType']),
      ),
      operationType: $BackupOperationTableTable.$converteroperationType
          .fromJson(serializer.fromJson<int>(json['operationType'])),
      localId: serializer.fromJson<int>(json['localId']),
      remoteId: serializer.fromJson<int?>(json['remoteId']),
      payload: serializer.fromJson<String>(json['payload']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entityType': serializer.toJson<int>(
        $BackupOperationTableTable.$converterentityType.toJson(entityType),
      ),
      'operationType': serializer.toJson<int>(
        $BackupOperationTableTable.$converteroperationType.toJson(
          operationType,
        ),
      ),
      'localId': serializer.toJson<int>(localId),
      'remoteId': serializer.toJson<int?>(remoteId),
      'payload': serializer.toJson<String>(payload),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  BackupOperationTableData copyWith({
    int? id,
    EntityEnum? entityType,
    OperationEnum? operationType,
    int? localId,
    Value<int?> remoteId = const Value.absent(),
    String? payload,
    DateTime? timestamp,
  }) => BackupOperationTableData(
    id: id ?? this.id,
    entityType: entityType ?? this.entityType,
    operationType: operationType ?? this.operationType,
    localId: localId ?? this.localId,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    payload: payload ?? this.payload,
    timestamp: timestamp ?? this.timestamp,
  );
  BackupOperationTableData copyWithCompanion(
    BackupOperationTableCompanion data,
  ) {
    return BackupOperationTableData(
      id: data.id.present ? data.id.value : this.id,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      operationType: data.operationType.present
          ? data.operationType.value
          : this.operationType,
      localId: data.localId.present ? data.localId.value : this.localId,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      payload: data.payload.present ? data.payload.value : this.payload,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BackupOperationTableData(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('operationType: $operationType, ')
          ..write('localId: $localId, ')
          ..write('remoteId: $remoteId, ')
          ..write('payload: $payload, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entityType,
    operationType,
    localId,
    remoteId,
    payload,
    timestamp,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BackupOperationTableData &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.operationType == this.operationType &&
          other.localId == this.localId &&
          other.remoteId == this.remoteId &&
          other.payload == this.payload &&
          other.timestamp == this.timestamp);
}

class BackupOperationTableCompanion
    extends UpdateCompanion<BackupOperationTableData> {
  final Value<int> id;
  final Value<EntityEnum> entityType;
  final Value<OperationEnum> operationType;
  final Value<int> localId;
  final Value<int?> remoteId;
  final Value<String> payload;
  final Value<DateTime> timestamp;
  const BackupOperationTableCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.operationType = const Value.absent(),
    this.localId = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.payload = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  BackupOperationTableCompanion.insert({
    this.id = const Value.absent(),
    required EntityEnum entityType,
    required OperationEnum operationType,
    required int localId,
    this.remoteId = const Value.absent(),
    required String payload,
    required DateTime timestamp,
  }) : entityType = Value(entityType),
       operationType = Value(operationType),
       localId = Value(localId),
       payload = Value(payload),
       timestamp = Value(timestamp);
  static Insertable<BackupOperationTableData> custom({
    Expression<int>? id,
    Expression<int>? entityType,
    Expression<int>? operationType,
    Expression<int>? localId,
    Expression<int>? remoteId,
    Expression<String>? payload,
    Expression<DateTime>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (operationType != null) 'operation_type': operationType,
      if (localId != null) 'local_id': localId,
      if (remoteId != null) 'remote_id': remoteId,
      if (payload != null) 'payload': payload,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  BackupOperationTableCompanion copyWith({
    Value<int>? id,
    Value<EntityEnum>? entityType,
    Value<OperationEnum>? operationType,
    Value<int>? localId,
    Value<int?>? remoteId,
    Value<String>? payload,
    Value<DateTime>? timestamp,
  }) {
    return BackupOperationTableCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      operationType: operationType ?? this.operationType,
      localId: localId ?? this.localId,
      remoteId: remoteId ?? this.remoteId,
      payload: payload ?? this.payload,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<int>(
        $BackupOperationTableTable.$converterentityType.toSql(entityType.value),
      );
    }
    if (operationType.present) {
      map['operation_type'] = Variable<int>(
        $BackupOperationTableTable.$converteroperationType.toSql(
          operationType.value,
        ),
      );
    }
    if (localId.present) {
      map['local_id'] = Variable<int>(localId.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<int>(remoteId.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BackupOperationTableCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('operationType: $operationType, ')
          ..write('localId: $localId, ')
          ..write('remoteId: $remoteId, ')
          ..write('payload: $payload, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

abstract class _$DriftDatabaseDatasource extends GeneratedDatabase {
  _$DriftDatabaseDatasource(QueryExecutor e) : super(e);
  $DriftDatabaseDatasourceManager get managers =>
      $DriftDatabaseDatasourceManager(this);
  late final $TransactionTableTable transactionTable = $TransactionTableTable(
    this,
  );
  late final $AccountTableTable accountTable = $AccountTableTable(this);
  late final $CategoryTableTable categoryTable = $CategoryTableTable(this);
  late final $BackupOperationTableTable backupOperationTable =
      $BackupOperationTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    transactionTable,
    accountTable,
    categoryTable,
    backupOperationTable,
  ];
}

typedef $$TransactionTableTableCreateCompanionBuilder =
    TransactionTableCompanion Function({
      Value<int> id,
      Value<int?> remoteId,
      required int accountId,
      required int categoryId,
      required double amount,
      required String transactionDate,
      Value<String?> comment,
      required String createdAt,
      required String updatedAt,
    });
typedef $$TransactionTableTableUpdateCompanionBuilder =
    TransactionTableCompanion Function({
      Value<int> id,
      Value<int?> remoteId,
      Value<int> accountId,
      Value<int> categoryId,
      Value<double> amount,
      Value<String> transactionDate,
      Value<String?> comment,
      Value<String> createdAt,
      Value<String> updatedAt,
    });

class $$TransactionTableTableFilterComposer
    extends Composer<_$DriftDatabaseDatasource, $TransactionTableTable> {
  $$TransactionTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<String, String, DateTime>
  get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<String, String, DateTime> get createdAt =>
      $composableBuilder(
        column: $table.createdAt,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<String, String, DateTime> get updatedAt =>
      $composableBuilder(
        column: $table.updatedAt,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );
}

class $$TransactionTableTableOrderingComposer
    extends Composer<_$DriftDatabaseDatasource, $TransactionTableTable> {
  $$TransactionTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
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

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TransactionTableTableAnnotationComposer
    extends Composer<_$DriftDatabaseDatasource, $TransactionTableTable> {
  $$TransactionTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<int> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumnWithTypeConverter<String, DateTime> get transactionDate =>
      $composableBuilder(
        column: $table.transactionDate,
        builder: (column) => column,
      );

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  GeneratedColumnWithTypeConverter<String, DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<String, DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$TransactionTableTableTableManager
    extends
        RootTableManager<
          _$DriftDatabaseDatasource,
          $TransactionTableTable,
          TransactionTableData,
          $$TransactionTableTableFilterComposer,
          $$TransactionTableTableOrderingComposer,
          $$TransactionTableTableAnnotationComposer,
          $$TransactionTableTableCreateCompanionBuilder,
          $$TransactionTableTableUpdateCompanionBuilder,
          (
            TransactionTableData,
            BaseReferences<
              _$DriftDatabaseDatasource,
              $TransactionTableTable,
              TransactionTableData
            >,
          ),
          TransactionTableData,
          PrefetchHooks Function()
        > {
  $$TransactionTableTableTableManager(
    _$DriftDatabaseDatasource db,
    $TransactionTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> remoteId = const Value.absent(),
                Value<int> accountId = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> transactionDate = const Value.absent(),
                Value<String?> comment = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
              }) => TransactionTableCompanion(
                id: id,
                remoteId: remoteId,
                accountId: accountId,
                categoryId: categoryId,
                amount: amount,
                transactionDate: transactionDate,
                comment: comment,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> remoteId = const Value.absent(),
                required int accountId,
                required int categoryId,
                required double amount,
                required String transactionDate,
                Value<String?> comment = const Value.absent(),
                required String createdAt,
                required String updatedAt,
              }) => TransactionTableCompanion.insert(
                id: id,
                remoteId: remoteId,
                accountId: accountId,
                categoryId: categoryId,
                amount: amount,
                transactionDate: transactionDate,
                comment: comment,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TransactionTableTableProcessedTableManager =
    ProcessedTableManager<
      _$DriftDatabaseDatasource,
      $TransactionTableTable,
      TransactionTableData,
      $$TransactionTableTableFilterComposer,
      $$TransactionTableTableOrderingComposer,
      $$TransactionTableTableAnnotationComposer,
      $$TransactionTableTableCreateCompanionBuilder,
      $$TransactionTableTableUpdateCompanionBuilder,
      (
        TransactionTableData,
        BaseReferences<
          _$DriftDatabaseDatasource,
          $TransactionTableTable,
          TransactionTableData
        >,
      ),
      TransactionTableData,
      PrefetchHooks Function()
    >;
typedef $$AccountTableTableCreateCompanionBuilder =
    AccountTableCompanion Function({
      Value<int> id,
      required int userId,
      required String name,
      required double balance,
      required CurrencyEnum currency,
      required String createdAt,
      required String updatedAt,
    });
typedef $$AccountTableTableUpdateCompanionBuilder =
    AccountTableCompanion Function({
      Value<int> id,
      Value<int> userId,
      Value<String> name,
      Value<double> balance,
      Value<CurrencyEnum> currency,
      Value<String> createdAt,
      Value<String> updatedAt,
    });

class $$AccountTableTableFilterComposer
    extends Composer<_$DriftDatabaseDatasource, $AccountTableTable> {
  $$AccountTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get userId => $composableBuilder(
    column: $table.userId,
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

  ColumnWithTypeConverterFilters<CurrencyEnum, CurrencyEnum, String>
  get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<String, String, DateTime> get createdAt =>
      $composableBuilder(
        column: $table.createdAt,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<String, String, DateTime> get updatedAt =>
      $composableBuilder(
        column: $table.updatedAt,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );
}

class $$AccountTableTableOrderingComposer
    extends Composer<_$DriftDatabaseDatasource, $AccountTableTable> {
  $$AccountTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get userId => $composableBuilder(
    column: $table.userId,
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

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AccountTableTableAnnotationComposer
    extends Composer<_$DriftDatabaseDatasource, $AccountTableTable> {
  $$AccountTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get balance =>
      $composableBuilder(column: $table.balance, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CurrencyEnum, String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumnWithTypeConverter<String, DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<String, DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AccountTableTableTableManager
    extends
        RootTableManager<
          _$DriftDatabaseDatasource,
          $AccountTableTable,
          AccountTableData,
          $$AccountTableTableFilterComposer,
          $$AccountTableTableOrderingComposer,
          $$AccountTableTableAnnotationComposer,
          $$AccountTableTableCreateCompanionBuilder,
          $$AccountTableTableUpdateCompanionBuilder,
          (
            AccountTableData,
            BaseReferences<
              _$DriftDatabaseDatasource,
              $AccountTableTable,
              AccountTableData
            >,
          ),
          AccountTableData,
          PrefetchHooks Function()
        > {
  $$AccountTableTableTableManager(
    _$DriftDatabaseDatasource db,
    $AccountTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> balance = const Value.absent(),
                Value<CurrencyEnum> currency = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
              }) => AccountTableCompanion(
                id: id,
                userId: userId,
                name: name,
                balance: balance,
                currency: currency,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userId,
                required String name,
                required double balance,
                required CurrencyEnum currency,
                required String createdAt,
                required String updatedAt,
              }) => AccountTableCompanion.insert(
                id: id,
                userId: userId,
                name: name,
                balance: balance,
                currency: currency,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AccountTableTableProcessedTableManager =
    ProcessedTableManager<
      _$DriftDatabaseDatasource,
      $AccountTableTable,
      AccountTableData,
      $$AccountTableTableFilterComposer,
      $$AccountTableTableOrderingComposer,
      $$AccountTableTableAnnotationComposer,
      $$AccountTableTableCreateCompanionBuilder,
      $$AccountTableTableUpdateCompanionBuilder,
      (
        AccountTableData,
        BaseReferences<
          _$DriftDatabaseDatasource,
          $AccountTableTable,
          AccountTableData
        >,
      ),
      AccountTableData,
      PrefetchHooks Function()
    >;
typedef $$CategoryTableTableCreateCompanionBuilder =
    CategoryTableCompanion Function({
      Value<int> id,
      required String name,
      required String emoji,
      required bool isIncome,
    });
typedef $$CategoryTableTableUpdateCompanionBuilder =
    CategoryTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> emoji,
      Value<bool> isIncome,
    });

class $$CategoryTableTableFilterComposer
    extends Composer<_$DriftDatabaseDatasource, $CategoryTableTable> {
  $$CategoryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emoji => $composableBuilder(
    column: $table.emoji,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isIncome => $composableBuilder(
    column: $table.isIncome,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CategoryTableTableOrderingComposer
    extends Composer<_$DriftDatabaseDatasource, $CategoryTableTable> {
  $$CategoryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emoji => $composableBuilder(
    column: $table.emoji,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isIncome => $composableBuilder(
    column: $table.isIncome,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoryTableTableAnnotationComposer
    extends Composer<_$DriftDatabaseDatasource, $CategoryTableTable> {
  $$CategoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get emoji =>
      $composableBuilder(column: $table.emoji, builder: (column) => column);

  GeneratedColumn<bool> get isIncome =>
      $composableBuilder(column: $table.isIncome, builder: (column) => column);
}

class $$CategoryTableTableTableManager
    extends
        RootTableManager<
          _$DriftDatabaseDatasource,
          $CategoryTableTable,
          CategoryTableData,
          $$CategoryTableTableFilterComposer,
          $$CategoryTableTableOrderingComposer,
          $$CategoryTableTableAnnotationComposer,
          $$CategoryTableTableCreateCompanionBuilder,
          $$CategoryTableTableUpdateCompanionBuilder,
          (
            CategoryTableData,
            BaseReferences<
              _$DriftDatabaseDatasource,
              $CategoryTableTable,
              CategoryTableData
            >,
          ),
          CategoryTableData,
          PrefetchHooks Function()
        > {
  $$CategoryTableTableTableManager(
    _$DriftDatabaseDatasource db,
    $CategoryTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoryTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoryTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoryTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> emoji = const Value.absent(),
                Value<bool> isIncome = const Value.absent(),
              }) => CategoryTableCompanion(
                id: id,
                name: name,
                emoji: emoji,
                isIncome: isIncome,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String emoji,
                required bool isIncome,
              }) => CategoryTableCompanion.insert(
                id: id,
                name: name,
                emoji: emoji,
                isIncome: isIncome,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoryTableTableProcessedTableManager =
    ProcessedTableManager<
      _$DriftDatabaseDatasource,
      $CategoryTableTable,
      CategoryTableData,
      $$CategoryTableTableFilterComposer,
      $$CategoryTableTableOrderingComposer,
      $$CategoryTableTableAnnotationComposer,
      $$CategoryTableTableCreateCompanionBuilder,
      $$CategoryTableTableUpdateCompanionBuilder,
      (
        CategoryTableData,
        BaseReferences<
          _$DriftDatabaseDatasource,
          $CategoryTableTable,
          CategoryTableData
        >,
      ),
      CategoryTableData,
      PrefetchHooks Function()
    >;
typedef $$BackupOperationTableTableCreateCompanionBuilder =
    BackupOperationTableCompanion Function({
      Value<int> id,
      required EntityEnum entityType,
      required OperationEnum operationType,
      required int localId,
      Value<int?> remoteId,
      required String payload,
      required DateTime timestamp,
    });
typedef $$BackupOperationTableTableUpdateCompanionBuilder =
    BackupOperationTableCompanion Function({
      Value<int> id,
      Value<EntityEnum> entityType,
      Value<OperationEnum> operationType,
      Value<int> localId,
      Value<int?> remoteId,
      Value<String> payload,
      Value<DateTime> timestamp,
    });

class $$BackupOperationTableTableFilterComposer
    extends Composer<_$DriftDatabaseDatasource, $BackupOperationTableTable> {
  $$BackupOperationTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<EntityEnum, EntityEnum, int> get entityType =>
      $composableBuilder(
        column: $table.entityType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<OperationEnum, OperationEnum, int>
  get operationType => $composableBuilder(
    column: $table.operationType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BackupOperationTableTableOrderingComposer
    extends Composer<_$DriftDatabaseDatasource, $BackupOperationTableTable> {
  $$BackupOperationTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get operationType => $composableBuilder(
    column: $table.operationType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BackupOperationTableTableAnnotationComposer
    extends Composer<_$DriftDatabaseDatasource, $BackupOperationTableTable> {
  $$BackupOperationTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<EntityEnum, int> get entityType =>
      $composableBuilder(
        column: $table.entityType,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<OperationEnum, int> get operationType =>
      $composableBuilder(
        column: $table.operationType,
        builder: (column) => column,
      );

  GeneratedColumn<int> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<int> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);
}

class $$BackupOperationTableTableTableManager
    extends
        RootTableManager<
          _$DriftDatabaseDatasource,
          $BackupOperationTableTable,
          BackupOperationTableData,
          $$BackupOperationTableTableFilterComposer,
          $$BackupOperationTableTableOrderingComposer,
          $$BackupOperationTableTableAnnotationComposer,
          $$BackupOperationTableTableCreateCompanionBuilder,
          $$BackupOperationTableTableUpdateCompanionBuilder,
          (
            BackupOperationTableData,
            BaseReferences<
              _$DriftDatabaseDatasource,
              $BackupOperationTableTable,
              BackupOperationTableData
            >,
          ),
          BackupOperationTableData,
          PrefetchHooks Function()
        > {
  $$BackupOperationTableTableTableManager(
    _$DriftDatabaseDatasource db,
    $BackupOperationTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BackupOperationTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BackupOperationTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$BackupOperationTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<EntityEnum> entityType = const Value.absent(),
                Value<OperationEnum> operationType = const Value.absent(),
                Value<int> localId = const Value.absent(),
                Value<int?> remoteId = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
              }) => BackupOperationTableCompanion(
                id: id,
                entityType: entityType,
                operationType: operationType,
                localId: localId,
                remoteId: remoteId,
                payload: payload,
                timestamp: timestamp,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required EntityEnum entityType,
                required OperationEnum operationType,
                required int localId,
                Value<int?> remoteId = const Value.absent(),
                required String payload,
                required DateTime timestamp,
              }) => BackupOperationTableCompanion.insert(
                id: id,
                entityType: entityType,
                operationType: operationType,
                localId: localId,
                remoteId: remoteId,
                payload: payload,
                timestamp: timestamp,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BackupOperationTableTableProcessedTableManager =
    ProcessedTableManager<
      _$DriftDatabaseDatasource,
      $BackupOperationTableTable,
      BackupOperationTableData,
      $$BackupOperationTableTableFilterComposer,
      $$BackupOperationTableTableOrderingComposer,
      $$BackupOperationTableTableAnnotationComposer,
      $$BackupOperationTableTableCreateCompanionBuilder,
      $$BackupOperationTableTableUpdateCompanionBuilder,
      (
        BackupOperationTableData,
        BaseReferences<
          _$DriftDatabaseDatasource,
          $BackupOperationTableTable,
          BackupOperationTableData
        >,
      ),
      BackupOperationTableData,
      PrefetchHooks Function()
    >;

class $DriftDatabaseDatasourceManager {
  final _$DriftDatabaseDatasource _db;
  $DriftDatabaseDatasourceManager(this._db);
  $$TransactionTableTableTableManager get transactionTable =>
      $$TransactionTableTableTableManager(_db, _db.transactionTable);
  $$AccountTableTableTableManager get accountTable =>
      $$AccountTableTableTableManager(_db, _db.accountTable);
  $$CategoryTableTableTableManager get categoryTable =>
      $$CategoryTableTableTableManager(_db, _db.categoryTable);
  $$BackupOperationTableTableTableManager get backupOperationTable =>
      $$BackupOperationTableTableTableManager(_db, _db.backupOperationTable);
}
