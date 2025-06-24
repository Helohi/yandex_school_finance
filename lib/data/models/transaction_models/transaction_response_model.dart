import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yandex_school_finance/core/extensions/number_formatting.dart';
import 'package:yandex_school_finance/core/utils/decimal_converter.dart';
import 'package:yandex_school_finance/data/models/account_models/account_brief_model.dart';
import 'package:yandex_school_finance/data/models/category_model.dart';

part 'transaction_response_model.freezed.dart';
part 'transaction_response_model.g.dart';

@freezed
abstract class TransactionResponseModel with _$TransactionResponseModel {
  const factory TransactionResponseModel({
    required int id,
    required AccountBriefModel account,
    required CategoryModel category,
    @DecimalConverter() required Decimal amount,
    required DateTime transactionDate,
    String? comment,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _TransactionResponseModel;

  factory TransactionResponseModel.fromJson(Map<String, Object?> json) =>
      _$TransactionResponseModelFromJson(json);

  static String sumOfTransactions(List<TransactionResponseModel> transactions) {
    final sum = transactions.fold<double>(
      0,
      (value, element) => value + element.amount.toDouble(),
    );
    return sum.formatWithSpaces();
  }
}
