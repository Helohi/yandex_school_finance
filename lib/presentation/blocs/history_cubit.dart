import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_school_finance/data/models/transaction_models/transaction_response_model.dart'
    show TransactionResponseModel;

class HistoryCubit extends Cubit<UIState> {
  HistoryCubit() : super(InitialState());

  Future<void> getTransactionsInPeriod(
    bool isIncome, {
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    emit(LoadingState());
    emit(ErrorState(message: "Not implemented"));
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
