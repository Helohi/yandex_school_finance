// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionModel _$TransactionModelFromJson(
  Map<String, dynamic> json,
) => _TransactionModel(
  id: (json['id'] as num).toInt(),
  accountId: (json['accountId'] as num).toInt(),
  categoryId: (json['categoryId'] as num).toInt(),
  amount: const DecimalConverter().fromJson(json['amount'] as String),
  transactionDate: const DateTimeConverter().fromJson(
    json['transactionDate'] as String,
  ),
  comment: json['comment'] as String?,
  createdAt: const DateTimeConverter().fromJson(json['createdAt'] as String),
  updatedAt: const DateTimeConverter().fromJson(json['updatedAt'] as String),
);

Map<String, dynamic> _$TransactionModelToJson(
  _TransactionModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'accountId': instance.accountId,
  'categoryId': instance.categoryId,
  'amount': const DecimalConverter().toJson(instance.amount),
  'transactionDate': const DateTimeConverter().toJson(instance.transactionDate),
  'comment': instance.comment,
  'createdAt': const DateTimeConverter().toJson(instance.createdAt),
  'updatedAt': const DateTimeConverter().toJson(instance.updatedAt),
};
