import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yandex_school_finance/core/enums/currency_enum.dart';
import 'package:yandex_school_finance/core/utils/decimal_converter.dart';

part 'account_update_request_model.freezed.dart';
part 'account_update_request_model.g.dart';

@freezed
abstract class AccountUpdateRequestModel with _$AccountUpdateRequestModel {
  const factory AccountUpdateRequestModel({
    required String name,
    @DecimalConverter() required Decimal balance,
    required CurrencyEnum currency,
  }) = _AccountUpdateRequestModel;

  factory AccountUpdateRequestModel.fromJson(Map<String, Object?> json) =>
      _$AccountUpdateRequestModelFromJson(json);
}
