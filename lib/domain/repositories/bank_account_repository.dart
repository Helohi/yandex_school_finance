import 'package:dartz/dartz.dart';
import 'package:yandex_school_finance/core/datasource_failures.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_create_request_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_history_response_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_response_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_update_request_model.dart';

abstract class BankAccountRepository {
  Future<Either<Failure, List<AccountModel>>> getAccounts();

  Future<Either<Failure, AccountModel>> createAccount(
    AccountCreateRequestModel newAccount,
  );

  Future<Either<Failure, AccountResponseModel>> getAccountById(int id);

  Future<Either<Failure, AccountModel>> updateAccountById(
    int id,
    AccountUpdateRequestModel updatedAccount,
  );

  Future<Either<Failure, AccountHistoryResponseModel>> getAccountHistory(
    int id,
  );
}
