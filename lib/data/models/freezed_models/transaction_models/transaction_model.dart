import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yandex_school_finance/core/utils/date_time_converter.dart';
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
    @DateTimeConverter() required DateTime transactionDate,
    String? comment,
    @DateTimeConverter() required DateTime createdAt,
    @DateTimeConverter() required DateTime updatedAt,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, Object?> json) =>
      _$TransactionModelFromJson(json);
}
