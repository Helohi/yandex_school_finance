// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_update_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountUpdateRequestModel _$AccountUpdateRequestModelFromJson(
  Map<String, dynamic> json,
) => _AccountUpdateRequestModel(
  name: json['name'] as String,
  balance: const DecimalConverter().fromJson(json['balance'] as String),
  currency: $enumDecode(_$CurrencyEnumEnumMap, json['currency']),
);

Map<String, dynamic> _$AccountUpdateRequestModelToJson(
  _AccountUpdateRequestModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'balance': const DecimalConverter().toJson(instance.balance),
  'currency': _$CurrencyEnumEnumMap[instance.currency]!,
};

const _$CurrencyEnumEnumMap = {
  CurrencyEnum.RUB: 'RUB',
  CurrencyEnum.USD: 'USD',
  CurrencyEnum.EUR: 'EUR',
};
