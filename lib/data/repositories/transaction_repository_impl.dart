import 'package:yandex_school_finance/data/models/transaction_models/transaction_model.dart';
import 'package:yandex_school_finance/data/models/transaction_models/transaction_request_model.dart';
import 'package:yandex_school_finance/data/models/transaction_models/transaction_response_model.dart';
import 'package:yandex_school_finance/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final List<Map<String, Object?>> transactions = [];

  @override
  Future<TransactionModel> createTransaction(
    TransactionRequestModel newTransaction,
  ) async {
    await Future.delayed(Duration(seconds: 1));

    transactions.add(
      newTransaction.toJson()
        ..["id"] = transactions.length + 1
        ..["createdAt"] = DateTime.now().toIso8601String()
        ..["updatedAt"] = DateTime.now().toIso8601String(),
    );

    return TransactionModel.fromJson(transactions.last);
  }

  @override
  Future<TransactionResponseModel> getTransactionById(int id) async {
    await Future.delayed(Duration(seconds: 1));

    return TransactionResponseModel.fromJson({
      "id": 1,
      "account": {
        "id": 1,
        "name": "Основной счёт",
        "balance": "1000.00",
        "currency": "RUB",
      },
      "category": {
        "id": 1,
        "name": "Зарплата",
        "emoji": "💰",
        "isIncome": true,
      },
      "amount": "500.00",
      "transactionDate": "2025-06-10T14:23:05.455Z",
      "comment": "Зарплата за месяц",
      "createdAt": "2025-06-10T14:23:05.455Z",
      "updatedAt": "2025-06-10T14:23:05.455Z",
    });
  }

  @override
  Future<TransactionResponseModel> updateTransactionById(
    int id,
    TransactionRequestModel updatedTransaction,
  ) async {
    await Future.delayed(Duration(seconds: 1));

    return TransactionResponseModel.fromJson({
      "id": 1,
      "account": {
        "id": 1,
        "name": "Основной счёт",
        "balance": "1000.00",
        "currency": "RUB",
      },
      "category": {
        "id": 1,
        "name": "Зарплата",
        "emoji": "💰",
        "isIncome": true,
      },
      "amount": "500.00",
      "transactionDate": "2025-06-10T14:24:08.834Z",
      "comment": "Зарплата за месяц",
      "createdAt": "2025-06-10T14:24:08.834Z",
      "updatedAt": "2025-06-10T14:24:08.834Z",
    });
  }

  @override
  Future<void> removeTransactionById(int id) async {
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Future<List<TransactionResponseModel>> getTransactionsInPeriod(
    int id, {
    String? startDate,
    String? endDate,
  }) async {
    await Future.delayed(Duration(seconds: 1));

    return [
      {
        "id": 1,
        "account": {
          "id": 1,
          "name": "Основной счёт",
          "balance": "1000.00",
          "currency": "RUB",
        },
        "category": {
          "id": 1,
          "name": "Зарплата",
          "emoji": "💰",
          "isIncome": true,
        },
        "amount": "500.00",
        "transactionDate": "2025-06-10T14:29:45.131Z",
        "comment": "Зарплата за месяц",
        "createdAt": "2025-06-10T14:29:45.131Z",
        "updatedAt": "2025-06-10T14:29:45.131Z",
      },
    ].map((el) => TransactionResponseModel.fromJson(el)).toList();
  }
}
