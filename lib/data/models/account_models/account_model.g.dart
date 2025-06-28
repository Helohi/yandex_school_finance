// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountModel _$AccountModelFromJson(Map<String, dynamic> json) =>
    _AccountModel(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      name: json['name'] as String,
      balance: const DecimalConverter().fromJson(json['balance'] as String),
      currency: $enumDecode(_$CurrencyEnumEnumMap, json['currency']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$AccountModelToJson(_AccountModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'balance': const DecimalConverter().toJson(instance.balance),
      'currency': _$CurrencyEnumEnumMap[instance.currency]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$CurrencyEnumEnumMap = {
  CurrencyEnum.RUB: 'RUB',
  CurrencyEnum.USD: 'USD',
  CurrencyEnum.EUR: 'EUR',
};
