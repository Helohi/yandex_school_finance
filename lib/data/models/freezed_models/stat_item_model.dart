import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yandex_school_finance/core/utils/decimal_converter.dart';

part 'stat_item_model.freezed.dart';
part 'stat_item_model.g.dart';

@freezed
abstract class StatItemModel with _$StatItemModel {
  factory StatItemModel({
    required int categoryId,
    required String categoryName,
    required String emoji,
    @DecimalConverter() required Decimal amount,
  }) = _StatItemModel;

  factory StatItemModel.fromJson(Map<String, Object?> json) =>
      _$StatItemModelFromJson(json);
}
