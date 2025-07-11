// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_history_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountHistoryResponseModel _$AccountHistoryResponseModelFromJson(
  Map<String, dynamic> json,
) => _AccountHistoryResponseModel(
  accountId: (json['accountId'] as num).toInt(),
  accountName: json['accountName'] as String,
  currency: $enumDecode(_$CurrencyEnumEnumMap, json['currency']),
  currentBalance: const DecimalConverter().fromJson(json['currentBalance']),
  history: (json['history'] as List<dynamic>)
      .map((e) => AccountHistoryModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AccountHistoryResponseModelToJson(
  _AccountHistoryResponseModel instance,
) => <String, dynamic>{
  'accountId': instance.accountId,
  'accountName': instance.accountName,
  'currency': _$CurrencyEnumEnumMap[instance.currency]!,
  'currentBalance': const DecimalConverter().toJson(instance.currentBalance),
  'history': instance.history,
};

const _$CurrencyEnumEnumMap = {
  CurrencyEnum.RUB: 'RUB',
  CurrencyEnum.USD: 'USD',
  CurrencyEnum.EUR: 'EUR',
};
