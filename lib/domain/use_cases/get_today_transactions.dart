import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:yandex_school_finance/core/datasource_failures.dart'
    show Failure;
import 'package:yandex_school_finance/data/models/account_models/account_model.dart';
import 'package:yandex_school_finance/data/models/transaction_models/transaction_response_model.dart';
import 'package:yandex_school_finance/domain/repositories/bank_account_repository.dart';
import 'package:yandex_school_finance/domain/repositories/transaction_repository.dart';

class GetTodayTransactions {
  final TransactionRepository transactionRepository;
  final BankAccountRepository accountRepository;

  GetTodayTransactions({
    required this.transactionRepository,
    required this.accountRepository,
  });

  Future<Either<Failure, List<TransactionResponseModel>>> call(
    GetTodaysTransactionsParams params,
  ) async {
    final failOrAccounts = await accountRepository.getAccounts();

    return failOrAccounts.fold((Failure fail) => Left(fail), (
      List<AccountModel> accounts,
    ) async {
      final now = DateTime.now();
      final failOrTransactions = await transactionRepository
          .getTransactionsInPeriod(
            accounts.first.id,
            startDate: now,
            endDate: now,
          );

      return failOrTransactions.fold(
        (Failure fail) => Left(fail),
        (List<TransactionResponseModel> transactions) => Right(
          transactions
              .where(
                (el) => switch (params.operationType) {
                  OperationType.all => true,
                  OperationType.income => el.category.isIncome,
                  OperationType.spend => !el.category.isIncome,
                },
              )
              .toList(),
        ),
      );
    });
  }
}

class GetTodaysTransactionsParams {
  const GetTodaysTransactionsParams(this.operationType);
  final OperationType operationType;
}

enum OperationType { all, income, spend }
