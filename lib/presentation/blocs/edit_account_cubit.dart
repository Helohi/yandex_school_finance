import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_update_request_model.dart';
import 'package:yandex_school_finance/domain/repositories/bank_account_repository.dart';

class EditAccountCubit extends Cubit<EditAccountUIState> {
  EditAccountCubit(this.accountRepository) : super(InitialState());

  final BankAccountRepository accountRepository;

  void showError(String message) => emit(ErrorState(message: (_) => message));

  void showAccount(AccountModel account) {
    emit(LoadingState());
    emit(
      LoadedState(
        accountResponseModel: AccountUpdateRequestModel(
          name: account.name,
          balance: account.balance,
          currency: account.currency,
        ),
      ),
    );
  }

  void loadAccountById(int id) async {
    emit(LoadingState());

    final failOrAccount = await accountRepository.getAccountById(id);
    failOrAccount.fold(
      (fail) => emit(ErrorState(message: fail.message)),
      (account) => emit(
        LoadedState(
          accountResponseModel: AccountUpdateRequestModel(
            name: account.response.name,
            balance: account.response.balance,
            currency: account.response.currency,
          ),
        ),
      ),
    );
  }
}

sealed class EditAccountUIState {}

class InitialState extends EditAccountUIState {}

class LoadingState extends EditAccountUIState {}

class LoadedState extends EditAccountUIState {
  AccountUpdateRequestModel accountResponseModel;

  LoadedState({required this.accountResponseModel});
}

class ErrorState extends EditAccountUIState {
  final String Function(BuildContext context) message;

  ErrorState({required this.message});
}
