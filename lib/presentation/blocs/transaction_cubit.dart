import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_school_finance/core/datasource_failures.dart';
import 'package:yandex_school_finance/data/models/freezed_models/transaction_models/transaction_response_model.dart';
import 'package:yandex_school_finance/domain/use_cases/get_today_transactions.dart';

class TransactionCubit extends Cubit<TransactionUIState> {
  TransactionCubit(this.getTodaysTransactions) : super(InitialState());

  final GetTodayTransactions getTodaysTransactions;

  Future<void> loadTodayTransactions(bool isIncome) async {
    emit(LoadingState());

    final failOrTransactions = await getTodaysTransactions(isIncome);

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

sealed class TransactionUIState {}

class InitialState extends TransactionUIState {}

class LoadingState extends TransactionUIState {}

class LoadedState extends TransactionUIState {
  final List<TransactionResponseModel> transactions;

  LoadedState({required this.transactions});
}

class ErrorState extends TransactionUIState {
  final String Function(BuildContext context) message;

  ErrorState({required this.message});
}
