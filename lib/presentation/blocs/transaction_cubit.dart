import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_school_finance/core/datasource_failures.dart';
import 'package:yandex_school_finance/data/models/transaction_models/transaction_response_model.dart';
import 'package:yandex_school_finance/domain/use_cases/get_today_transactions.dart';

class TransactionCubit extends Cubit<UIState> {
  TransactionCubit(this.getTodaysTransactions) : super(InitialState());

  final GetTodayTransactions getTodaysTransactions;

  Future<void> loadTodayTransactions(bool isIncome) async {
    emit(LoadingState());

    final failOrTransactions = await getTodaysTransactions(
      GetTodaysTransactionsParams(
        isIncome ? OperationType.income : OperationType.spend,
      ),
    );

    failOrTransactions.fold(
      (Failure fail) {
        emit(ErrorState(message: fail.message));
      },
      (List<TransactionResponseModel> transactions) {
        emit(LoadedState(transactions: transactions));
      },
    );
  }
}

sealed class UIState {}

class InitialState extends UIState {}

class LoadingState extends UIState {}

class LoadedState extends UIState {
  final List<TransactionResponseModel> transactions;

  LoadedState({required this.transactions});
}

class ErrorState extends UIState {
  final String message;

  ErrorState({required this.message});
}
