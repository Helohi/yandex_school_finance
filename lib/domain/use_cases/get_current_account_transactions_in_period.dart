import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:yandex_school_finance/core/datasource_failures.dart';
import 'package:yandex_school_finance/data/models/freezed_models/transaction_models/transaction_response_model.dart';
import 'package:yandex_school_finance/domain/repositories/bank_account_repository.dart';
import 'package:yandex_school_finance/domain/repositories/transaction_repository.dart';

class GetCurrentAccountTransactionsInPeriod {
  GetCurrentAccountTransactionsInPeriod(
    BankAccountRepository accountRepository,
    TransactionRepository transactionRepository,
  ) : _accountRepository = accountRepository,
      _transactionRepository = transactionRepository;

  final BankAccountRepository _accountRepository;
  final TransactionRepository _transactionRepository;

  Future<Either<Failure, List<TransactionResponseModel>>> call(
    bool isIncome, [
    DateTime? startDate,
    DateTime? endDate,
  ]) async {
    final failOrAccounts = await _accountRepository.getAccounts();

    if (startDate != null && endDate != null) {
      if (startDate.isAfter(endDate)) {
        endDate = startDate;
      } else if (endDate.isBefore(startDate)) {
        startDate = endDate;
      }
    }

    return failOrAccounts.fold(Left.new, (accounts) async {
      final failOrTransactions = await _transactionRepository
          .getTransactionsInPeriod(
            accounts.first.id,
            startDate: startDate,
            endDate: endDate,
          );
      return failOrTransactions.fold(Left.new, (transactions) {
        return Right(
          transactions.where((el) => el.category.isIncome == isIncome).toList(),
        );
      });
    });
  }
}
