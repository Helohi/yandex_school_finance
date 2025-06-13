import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yandex_school_finance/core/utils/decimal_converter.dart';

part 'account_state_model.freezed.dart';
part 'account_state_model.g.dart';

@freezed
abstract class AccountStateModel with _$AccountStateModel {
  const factory AccountStateModel({
    required int id,
    required String name,
    @DecimalConverter() required Decimal balance,
    required String currency,
  }) = _AccountStateModel;

  factory AccountStateModel.fromJson(Map<String, dynamic> json) =>
      _$AccountStateModelFromJson(json);
}
