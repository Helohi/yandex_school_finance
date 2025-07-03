import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:yandex_school_finance/core/datasource_failures.dart';
import 'package:yandex_school_finance/data/datasources/swagger/swagger_bank_account_datasource.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_create_request_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_history_response_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_response_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_update_request_model.dart';
import 'package:yandex_school_finance/domain/repositories/bank_account_repository.dart';

class SwaggerBankAccountRepositories implements BankAccountRepository {
  final SwaggerBankAccountDatasource _bankAccountDatasource;

  SwaggerBankAccountRepositories(
    SwaggerBankAccountDatasource bankAccountDatasource,
  ) : _bankAccountDatasource = bankAccountDatasource;

  @override
  Future<Either<Failure, AccountModel>> createAccount(
    AccountCreateRequestModel newAccount,
  ) {
    // TODO: implement createAccount
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AccountResponseModel>> getAccountById(int id) async {
    try {
      return Right(await _bankAccountDatasource.getAccountById(id));
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      log("${e.runtimeType}: $e");
      return Left(UnhandledFailure());
    }
  }

  @override
  Future<Either<Failure, AccountHistoryResponseModel>> getAccountHistory(
    int id,
  ) async {
    try {
      return Right(await _bankAccountDatasource.getAccountHistory(id));
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      log("${e.runtimeType}: $e");
      return Left(UnhandledFailure());
    }
  }

  @override
  Future<Either<Failure, List<AccountModel>>> getAccounts() async {
    try {
      return Right(await _bankAccountDatasource.getAccounts());
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      log("${e.runtimeType}: $e");
      return Left(UnhandledFailure());
    }
  }

  @override
  Future<Either<Failure, AccountModel>> updateAccountById(
    int id,
    AccountUpdateRequestModel updatedAccount,
  ) async {
    try {
      return Right(
        await _bankAccountDatasource.updateAccountById(id, updatedAccount),
      );
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      log("${e.runtimeType}: $e");
      return Left(UnhandledFailure());
    }
  }
}
