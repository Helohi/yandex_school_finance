import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yandex_school_finance/core/utils/decimal_converter.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
abstract class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required int id,
    required int accountId,
    required int categoryId,
    @DecimalConverter() required Decimal amount,
    required DateTime transactionDate,
    String? comment,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, Object?> json) =>
      _$TransactionModelFromJson(json);
}
