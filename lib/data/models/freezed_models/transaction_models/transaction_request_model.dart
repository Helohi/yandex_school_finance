import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yandex_school_finance/core/utils/date_time_converter.dart';
import 'package:yandex_school_finance/core/utils/decimal_converter.dart';

part 'transaction_request_model.freezed.dart';
part 'transaction_request_model.g.dart';

@freezed
abstract class TransactionRequestModel with _$TransactionRequestModel {
  const factory TransactionRequestModel({
    required int accountId,
    required int categoryId,
    @DecimalConverter() required Decimal amount,
    @DateTimeConverter() required DateTime transactionDate,
    String? comment,
  }) = _TransactionRequestModel;

  factory TransactionRequestModel.fromJson(Map<String, Object?> json) =>
      _$TransactionRequestModelFromJson(json);
}
