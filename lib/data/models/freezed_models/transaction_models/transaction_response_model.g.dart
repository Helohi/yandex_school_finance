// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionResponseModel _$TransactionResponseModelFromJson(
  Map<String, dynamic> json,
) => _TransactionResponseModel(
  id: (json['id'] as num).toInt(),
  account: AccountBriefModel.fromJson(json['account'] as Map<String, dynamic>),
  category: CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
  amount: const DecimalConverter().fromJson(json['amount'] as String),
  transactionDate: const DateTimeConverter().fromJson(
    json['transactionDate'] as String,
  ),
  comment: json['comment'] as String?,
  createdAt: const DateTimeConverter().fromJson(json['createdAt'] as String),
  updatedAt: const DateTimeConverter().fromJson(json['updatedAt'] as String),
);

Map<String, dynamic> _$TransactionResponseModelToJson(
  _TransactionResponseModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'account': instance.account,
  'category': instance.category,
  'amount': const DecimalConverter().toJson(instance.amount),
  'transactionDate': const DateTimeConverter().toJson(instance.transactionDate),
  'comment': instance.comment,
  'createdAt': const DateTimeConverter().toJson(instance.createdAt),
  'updatedAt': const DateTimeConverter().toJson(instance.updatedAt),
};
