import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:decimal/decimal.dart';
import 'package:yandex_school_finance/core/datasource_failures.dart';
import 'package:yandex_school_finance/core/enums/period_enum.dart';
import 'package:yandex_school_finance/domain/repositories/transaction_repository.dart';

class GetAccountStatistics {
  GetAccountStatistics(this._transactionRepository);

  final TransactionRepository _transactionRepository;

  Future<Either<Failure, Map<DateTime, Decimal>>> call(
    int accountId,
    DateTime startDate,
    DateTime endDate,
    PeriodEnum? period,
  ) async {
    final failOrTransactions = await _transactionRepository
        .getTransactionsInPeriod(
          accountId,
          startDate: startDate,
          endDate: endDate,
        );

    return failOrTransactions.fold(Left.new, (transactions) {
      final map = <DateTime, Decimal>{};
      DateTime currentDate = startDate;
      while (currentDate.isBefore(endDate) ||
          currentDate.isAtSameMomentAs(endDate)) {
        map[currentDate] = transactions
            .where(
              (el) =>
                  (period == PeriodEnum.month
                      ? el.transactionDate.day == currentDate.day
                      : true) &&
                  el.transactionDate.month == currentDate.month &&
                  el.transactionDate.year == currentDate.year,
            )
            .fold(
              Decimal.zero,
              (sum, el) =>
                  el.category.isIncome ? sum + el.amount : sum - el.amount,
            );

        if (period == PeriodEnum.month) {
          currentDate = currentDate.add(const Duration(days: 1));
        } else {
          currentDate = currentDate.copyWith(month: currentDate.month + 1);
        }
      }
      return Right(map);
    });
  }
}
