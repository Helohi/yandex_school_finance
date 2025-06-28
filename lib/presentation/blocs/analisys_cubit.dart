import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_school_finance/data/models/category_model.dart';
import 'package:yandex_school_finance/data/models/transaction_models/transaction_response_model.dart';
import 'package:yandex_school_finance/domain/use_cases/get_current_account_transactions_in_period.dart';

class AnalisysCubit extends Cubit<AnalisysUIState> {
  AnalisysCubit(this._getTransactionsInPeriodUseCase) : super(InitialState());

  final GetCurrentAccountTransactionsInPeriod _getTransactionsInPeriodUseCase;

  Future<void> getTransactionsInPeriod(
    bool isIncome, {
    required DateTime startDate,
    required DateTime endDate,
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
        final categorysed = <CategoryModel, CategorizedTransactions>{};

        for (final transaction in transactions) {
          categorysed[transaction.category] ??= CategorizedTransactions(
            category: transaction.category,
            transactions: [],
          );

          categorysed[transaction.category]!.transactions.add(transaction);
        }

        emit(
          LoadedState(
            categorysed: categorysed.values.toList(),
            transactions: transactions,
          ),
        );
      },
    );
  }
}

sealed class AnalisysUIState {}

class InitialState extends AnalisysUIState {}

class LoadingState extends AnalisysUIState {}

class LoadedState extends AnalisysUIState {
  final List<CategorizedTransactions> categorysed;
  final List<TransactionResponseModel> transactions;

  LoadedState({required this.categorysed, required this.transactions});
}

class ErrorState extends AnalisysUIState {
  final String message;
  ErrorState({required this.message});
}

class CategorizedTransactions {
  final CategoryModel category;
  final List<TransactionResponseModel> transactions;

  CategorizedTransactions({required this.category, required this.transactions});
}
