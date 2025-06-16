import 'package:yandex_school_finance/data/models/account_models/account_create_request_model.dart';
import 'package:yandex_school_finance/data/models/account_models/account_history_response_model.dart';
import 'package:yandex_school_finance/data/models/account_models/account_model.dart';
import 'package:yandex_school_finance/data/models/account_models/account_response_model.dart';
import 'package:yandex_school_finance/data/models/account_models/account_update_request_model.dart';

abstract class BankAccountRepository {
  Future<List<AccountModel>> getAccounts();

  Future<AccountModel> createAccount(AccountCreateRequestModel newAccount);

  Future<AccountResponseModel> getAccountById(int id);

  Future<AccountModel> updateAccountById(
    int id,
    AccountUpdateRequestModel updatedAccount,
  );

  Future<AccountHistoryResponseModel> getAccountHistory(int id);
}
