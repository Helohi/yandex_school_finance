import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yandex_school_finance/core/enums/currency_enum.dart';
import 'package:yandex_school_finance/core/utils/decimal_converter.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_history_model.dart';

part 'account_history_response_model.freezed.dart';
part 'account_history_response_model.g.dart';

@freezed
abstract class AccountHistoryResponseModel with _$AccountHistoryResponseModel {
  const factory AccountHistoryResponseModel({
    required int accountId,
    required String accountName,
    required CurrencyEnum currency,
    @DecimalConverter() required Decimal currentBalance,
    required List<AccountHistoryModel> history,
  }) = _AccountHistoryResponseModel;

  factory AccountHistoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AccountHistoryResponseModelFromJson(json);
}
