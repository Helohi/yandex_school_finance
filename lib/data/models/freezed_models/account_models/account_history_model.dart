import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_state_model.dart';

part 'account_history_model.freezed.dart';
part 'account_history_model.g.dart';

// ignore: constant_identifier_names
enum AccountHistoryChangeType { CREATION, MODIFICATION }

@freezed
abstract class AccountHistoryModel with _$AccountHistoryModel {
  const factory AccountHistoryModel({
    required int id,
    required int accountId,
    required AccountHistoryChangeType changeType,
    AccountStateModel? previousState,
    required AccountStateModel newState,
    required String changeTimestamp,
    required DateTime createdAt,
  }) = _AccountHistoryModel;

  factory AccountHistoryModel.fromJson(Map<String, Object?> json) =>
      _$AccountHistoryModelFromJson(json);
}
