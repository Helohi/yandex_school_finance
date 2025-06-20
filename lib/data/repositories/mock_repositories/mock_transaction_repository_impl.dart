import 'package:dartz/dartz.dart';
import 'package:yandex_school_finance/core/datasource_failures.dart';
import 'package:yandex_school_finance/data/models/transaction_models/transaction_model.dart';
import 'package:yandex_school_finance/data/models/transaction_models/transaction_request_model.dart';
import 'package:yandex_school_finance/data/models/transaction_models/transaction_response_model.dart';
import 'package:yandex_school_finance/domain/repositories/transaction_repository.dart';

class MockTransactionRepositoryImpl implements TransactionRepository {
  final List<Map<String, Object?>> transactions = [];

  @override
  Future<Either<Failure, TransactionModel>> createTransaction(
    TransactionRequestModel newTransaction,
  ) async {
    try {
      await Future.delayed(Duration(seconds: 1));

      transactions.add(
        newTransaction.toJson()
          ..["id"] = transactions.length + 1
          ..["createdAt"] = DateTime.now().toIso8601String()
          ..["updatedAt"] = DateTime.now().toIso8601String(),
      );

      return Right(TransactionModel.fromJson(transactions.last));
    } catch (e) {
      return Left(UnhandledFailure());
    }
  }

  @override
  Future<Either<Failure, TransactionResponseModel>> getTransactionById(
    int id,
  ) async {
    try {
      await Future.delayed(Duration(seconds: 1));

      return Right(
        TransactionResponseModel.fromJson({
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
        }),
      );
    } catch (e) {
      return Left(UnhandledFailure());
    }
  }

  @override
  Future<Either<Failure, TransactionResponseModel>> updateTransactionById(
    int id,
    TransactionRequestModel updatedTransaction,
  ) async {
    try {
      await Future.delayed(Duration(seconds: 1));

      return Right(
        TransactionResponseModel.fromJson({
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
        }),
      );
    } catch (e) {
      return Left(UnhandledFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeTransactionById(int id) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      return Right(null);
    } catch (e) {
      return Left(UnhandledFailure());
    }
  }

  @override
  Future<Either<Failure, List<TransactionResponseModel>>>
  getTransactionsInPeriod(
    int id, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      await Future.delayed(Duration(seconds: 1));

      return Right(
        [
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
        ].map((el) => TransactionResponseModel.fromJson(el)).toList(),
      );
    } catch (e) {
      return Left(UnhandledFailure());
    }
  }
}
