import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yandex_school_finance/core/utils/decimal_converter.dart';
import 'package:yandex_school_finance/data/models/stat_item_model.dart';

part 'account_response_model.freezed.dart';
part 'account_response_model.g.dart';

@freezed
abstract class AccountResponseModel with _$AccountResponseModel {
  const factory AccountResponseModel({
    required int id,
    required String name,
    @DecimalConverter() required Decimal balance,
    required String currency,
    required List<StatItemModel> incomeStats,
    required List<StatItemModel> expenseStats,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AccountResponseModel;

  factory AccountResponseModel.fromJson(Map<String, Object?> json) =>
      _$AccountResponseModelFromJson(json);
}
