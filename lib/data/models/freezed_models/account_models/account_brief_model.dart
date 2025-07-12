import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yandex_school_finance/core/enums/currency_enum.dart';
import 'package:yandex_school_finance/core/utils/decimal_converter.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_response_model.dart';

part 'account_brief_model.freezed.dart';
part 'account_brief_model.g.dart';

@freezed
abstract class AccountBriefModel with _$AccountBriefModel {
  const factory AccountBriefModel({
    required int id,
    required String name,
    @DecimalConverter() required Decimal balance,
    required CurrencyEnum currency,
  }) = _AccountBriefModel;

  factory AccountBriefModel.fromJson(Map<String, Object?> json) =>
      _$AccountBriefModelFromJson(json);

  factory AccountBriefModel.fromAccountModel(AccountModel accountModel) =>
      AccountBriefModel(
        id: accountModel.id,
        name: accountModel.name,
        balance: accountModel.balance,
        currency: accountModel.currency,
      );

  factory AccountBriefModel.fromAccountResponseModel(
    AccountResponseModel account,
  ) => AccountBriefModel(
    id: account.id,
    name: account.name,
    balance: account.balance,
    currency: account.currency,
  );
}
