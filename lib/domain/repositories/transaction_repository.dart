import 'package:dartz/dartz.dart';
import 'package:yandex_school_finance/core/datasource_failures.dart';
import 'package:yandex_school_finance/data/models/transaction_models/transaction_model.dart';
import 'package:yandex_school_finance/data/models/transaction_models/transaction_request_model.dart';
import 'package:yandex_school_finance/data/models/transaction_models/transaction_response_model.dart';

abstract class TransactionRepository {
  Future<Either<Failure, TransactionModel>> createTransaction(
    TransactionRequestModel newTransaction,
  );

  Future<Either<Failure, TransactionResponseModel>> getTransactionById(int id);

  Future<Either<Failure, TransactionResponseModel>> updateTransactionById(
    int id,
    TransactionRequestModel updatedTransaction,
  );

  Future<Either<Failure, void>> removeTransactionById(int id);

  Future<Either<Failure, List<TransactionResponseModel>>>
  getTransactionsInPeriod(int id, {DateTime? startDate, DateTime? endDate});
}
