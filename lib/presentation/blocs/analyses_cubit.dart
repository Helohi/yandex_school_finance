import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_school_finance/data/models/freezed_models/category_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/transaction_models/transaction_response_model.dart';
import 'package:yandex_school_finance/domain/use_cases/get_current_account_transactions_in_period.dart';

class AnalysesCubit extends Cubit<AnalysesUIState> {
  AnalysesCubit(this._getTransactionsInPeriodUseCase) : super(InitialState());

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
        final categorized = <CategoryModel, CategorizedTransactions>{};

        for (final transaction in transactions) {
          categorized[transaction.category] ??= CategorizedTransactions(
            category: transaction.category,
            transactions: [],
          );

          categorized[transaction.category]!.transactions.add(transaction);
        }

        emit(
          LoadedState(
            categorized: categorized.values.toList(),
            transactions: transactions,
          ),
        );
      },
    );
  }
}

sealed class AnalysesUIState {}

class InitialState extends AnalysesUIState {}

class LoadingState extends AnalysesUIState {}

class LoadedState extends AnalysesUIState {
  final List<CategorizedTransactions> categorized;
  final List<TransactionResponseModel> transactions;

  LoadedState({required this.categorized, required this.transactions});
}

class ErrorState extends AnalysesUIState {
  final String message;
  ErrorState({required this.message});
}

class CategorizedTransactions {
  final CategoryModel category;
  final List<TransactionResponseModel> transactions;

  CategorizedTransactions({required this.category, required this.transactions});
}
