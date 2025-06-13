// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_create_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountCreateRequestModel _$AccountCreateRequestModelFromJson(
  Map<String, dynamic> json,
) => _AccountCreateRequestModel(
  name: json['name'] as String,
  balance: const DecimalConverter().fromJson(json['balance'] as String),
  currency: json['currency'] as String,
);

Map<String, dynamic> _$AccountCreateRequestModelToJson(
  _AccountCreateRequestModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'balance': const DecimalConverter().toJson(instance.balance),
  'currency': instance.currency,
};
