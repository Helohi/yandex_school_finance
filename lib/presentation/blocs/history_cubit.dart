import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_school_finance/data/models/transaction_models/transaction_response_model.dart'
    show TransactionResponseModel;
import 'package:yandex_school_finance/domain/use_cases/get_current_account_transactions_in_period.dart';

class HistoryCubit extends Cubit<HistoryUIState> {
  HistoryCubit(this._getTransactionsInPeriodUseCase) : super(InitialState());

  final GetCurrentAccountTransactionsInPeriod _getTransactionsInPeriodUseCase;

  Future<void> getTransactionsInPeriod(
    bool isIncome, {
    required DateTime startDate,
    required DateTime endDate,
    required String sortBy,
    required bool isAscending,
  }) async {
    emit(LoadingState());

    final failOrTransactions = await _getTransactionsInPeriodUseCase(
      isIncome,
      startDate,
      endDate,
    );

    failOrTransactions.fold(
      (fail) {
        emit(ErrorState(message: fail.message));
      },
      (transactions) {
        if (sortBy == "byDate") {
          transactions.sort(
            (a, b) => a.transactionDate.compareTo(b.transactionDate),
          );
        } else {
          transactions.sort((a, b) => a.amount.compareTo(b.amount));
        }

        if (!isAscending) {
          transactions = transactions.reversed.toList();
        }

        emit(LoadedState(transactions: transactions));
      },
    );
  }
}

sealed class HistoryUIState {}

class InitialState extends HistoryUIState {}

class LoadingState extends HistoryUIState {}

class LoadedState extends HistoryUIState {
  final List<TransactionResponseModel> transactions;

  LoadedState({required this.transactions});
}

class ErrorState extends HistoryUIState {
  final String message;

  ErrorState({required this.message});
}
