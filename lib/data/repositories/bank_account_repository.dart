import 'package:yandex_school_finance/data/models/account_models/account_create_request_model.dart';
import 'package:yandex_school_finance/data/models/account_models/account_history_response_model.dart';
import 'package:yandex_school_finance/data/models/account_models/account_model.dart';
import 'package:yandex_school_finance/data/models/account_models/account_response_model.dart';
import 'package:yandex_school_finance/data/models/account_models/account_update_request_model.dart';

class BankAccountRepository {
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

  Future<List<AccountModel>> getAccounts() async {
    await Future.delayed(Duration(seconds: 1));
    return accounts.map((el) => AccountModel.fromJson(el)).toList();
  }

  Future<AccountModel> createAccount(
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

    return AccountModel.fromJson(accounts.last);
  }

  Future<AccountResponseModel> getAccountById(int id) async {
    await Future.delayed(Duration(seconds: 1));

    return AccountResponseModel.fromJson({
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
    });
  }

  Future<AccountModel> updateAccountById(
    int id,
    AccountUpdateRequestModel updatedAccount,
  ) async {
    await Future.delayed(Duration(seconds: 1));
    final updatedAccountJson = updatedAccount.toJson();

    return AccountModel.fromJson(
      accounts.firstWhere((el) => el["id"] == id)..updateAll(
        (key, value) => updatedAccountJson.containsKey(key)
            ? updatedAccountJson[key]
            : value,
      ),
    );
  }

  Future<AccountHistoryResponseModel> getAccountHistory(int id) async {
    await Future.delayed(Duration(seconds: 1));

    return AccountHistoryResponseModel.fromJson({
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
    });
  }
}
