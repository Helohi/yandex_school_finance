import 'package:dartz/dartz.dart';
import 'package:yandex_school_finance/core/datasource_failures.dart';
import 'package:yandex_school_finance/data/models/account_models/account_create_request_model.dart';
import 'package:yandex_school_finance/data/models/account_models/account_history_response_model.dart';
import 'package:yandex_school_finance/data/models/account_models/account_model.dart';
import 'package:yandex_school_finance/data/models/account_models/account_response_model.dart';
import 'package:yandex_school_finance/data/models/account_models/account_update_request_model.dart';
import 'package:yandex_school_finance/domain/repositories/bank_account_repository.dart';

class MockBankAccountRepositoryImpl implements BankAccountRepository {
  final List<Map<String, Object?>> accounts = [
    {
      "id": 1,
      "userId": 1,
      "name": "Основной счёт",
      "balance": "1000.00",
      "currency": "RUB",
      "createdAt": "2025-06-10T13:29:00.307Z",
      "updatedAt": "2025-06-10T13:29:00.307Z",
    },
  ];

  @override
  Future<Either<Failure, List<AccountModel>>> getAccounts() async {
    try {
      await Future.delayed(Duration(seconds: 1));
      return Right(accounts.map((el) => AccountModel.fromJson(el)).toList());
    } catch (e) {
      return Left(UnhandledFailure());
    }
  }

  @override
  Future<Either<Failure, AccountModel>> createAccount(
    AccountCreateRequestModel newAccount,
  ) async {
    await Future.delayed(Duration(seconds: 1));
    accounts.add(
      newAccount.toJson()
        ..["id"] = accounts.length + 1
        ..["userId"] = 1
        ..["createdAt"] = DateTime.now().toIso8601String()
        ..["updatedAt"] = DateTime.now().toIso8601String(),
    );

    return Right(AccountModel.fromJson(accounts.last));
  }

  @override
  Future<Either<Failure, AccountResponseModel>> getAccountById(int id) async {
    await Future.delayed(Duration(seconds: 1));

    return Right(
      AccountResponseModel.fromJson({
        "id": 1,
        "name": "Основной счёт",
        "balance": "1000.00",
        "currency": "RUB",
        "incomeStats": [
          {
            "categoryId": 1,
            "categoryName": "Зарплата",
            "emoji": "💰",
            "amount": "5000.00",
          },
        ],
        "expenseStats": [
          {
            "categoryId": 1,
            "categoryName": "Зарплата",
            "emoji": "💰",
            "amount": "5000.00",
          },
        ],
        "createdAt": "2025-06-10T20:58:47.421Z",
        "updatedAt": "2025-06-10T20:58:47.421Z",
      }),
    );
  }

  @override
  Future<Either<Failure, AccountModel>> updateAccountById(
    int id,
    AccountUpdateRequestModel updatedAccount,
  ) async {
    await Future.delayed(Duration(seconds: 1));
    final updatedAccountJson = updatedAccount.toJson();

    return Right(
      AccountModel.fromJson(
        accounts.firstWhere((el) => el["id"] == id)..updateAll(
          (key, value) => updatedAccountJson.containsKey(key)
              ? updatedAccountJson[key]
              : value,
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, AccountHistoryResponseModel>> getAccountHistory(
    int id,
  ) async {
    await Future.delayed(Duration(seconds: 1));

    return Right(
      AccountHistoryResponseModel.fromJson({
        "accountId": 1,
        "accountName": "Основной счет",
        "currency": "USD",
        "currentBalance": "2000.00",
        "history": [
          {
            "id": 1,
            "accountId": 1,
            "changeType": "MODIFICATION",
            "previousState": {
              "id": 1,
              "name": "Основной счет",
              "balance": "1000.00",
              "currency": "USD",
            },
            "newState": {
              "id": 1,
              "name": "Основной счет",
              "balance": "1000.00",
              "currency": "USD",
            },
            "changeTimestamp": "2025-06-10T14:02:22.174Z",
            "createdAt": "2025-06-10T14:02:22.174Z",
          },
        ],
      }),
    );
  }
}
