import 'package:yandex_school_finance/data/models/transaction_models/transaction_model.dart';
import 'package:yandex_school_finance/data/models/transaction_models/transaction_request_model.dart';
import 'package:yandex_school_finance/data/models/transaction_models/transaction_response_model.dart';

abstract class TransactionRepository {
  Future<TransactionModel> createTransaction(
    TransactionRequestModel newTransaction,
  );

  Future<TransactionResponseModel> getTransactionById(int id);

  Future<TransactionResponseModel> updateTransactionById(
    int id,
    TransactionRequestModel updatedTransaction,
  );

  Future<void> removeTransactionById(int id);

  Future<List<TransactionResponseModel>> getTransactionsInPeriod(
    int id, {
    String? startDate,
    String? endDate,
  });
}
