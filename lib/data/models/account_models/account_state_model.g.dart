// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountStateModel _$AccountStateModelFromJson(Map<String, dynamic> json) =>
    _AccountStateModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      balance: const DecimalConverter().fromJson(json['balance'] as String),
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$AccountStateModelToJson(_AccountStateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'balance': const DecimalConverter().toJson(instance.balance),
      'currency': instance.currency,
    };
