// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_brief_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountBriefModel _$AccountBriefModelFromJson(Map<String, dynamic> json) =>
    _AccountBriefModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      balance: const DecimalConverter().fromJson(json['balance'] as String),
      currency: $enumDecode(_$CurrencyEnumEnumMap, json['currency']),
    );

Map<String, dynamic> _$AccountBriefModelToJson(_AccountBriefModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'balance': const DecimalConverter().toJson(instance.balance),
      'currency': _$CurrencyEnumEnumMap[instance.currency]!,
    };

const _$CurrencyEnumEnumMap = {
  CurrencyEnum.RUB: 'RUB',
  CurrencyEnum.USD: 'USD',
  CurrencyEnum.EUR: 'EUR',
};
