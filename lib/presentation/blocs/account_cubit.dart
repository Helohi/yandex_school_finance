import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_school_finance/core/enums/currency_enum.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_update_request_model.dart';
import 'package:yandex_school_finance/domain/repositories/bank_account_repository.dart';
import 'package:yandex_school_finance/domain/use_cases/get_current_account.dart';

class AccountCubit extends Cubit<AccountStateUI> {
  AccountCubit(this.getCurrentAccount, this.bankAccountRepository)
    : super(InitialState());

  final GetCurrentAccount getCurrentAccount;
  final BankAccountRepository bankAccountRepository;

  AccountModel? _currentAccount;

  void loadAccount() async {
    emit(LoadingState());

    final failOrAccount = await getCurrentAccount();
    failOrAccount.fold((fail) => emit(ErrorState(message: fail.message)), (
      account,
    ) {
      _currentAccount = account;
      emit(LoadedState(account: account));
    });
  }

  Future<void> updateAccount(int id, AccountUpdateRequestModel account) async {
    if (_currentAccount == null) {
      emit(SnackBarState(message: "Счет не был загружен"));
      return;
    }

    emit(LoadingState());

    final failOrAccount = await bankAccountRepository.updateAccountById(
      id,
      account,
    );

    emit(
      LoadedState(
        account: _currentAccount!.copyWith(
          name: account.name,
          balance: account.balance,
          currency: account.currency,
        ),
      ),
    );

    failOrAccount.fold(
      (fail) => emit(SnackBarState(message: fail.message)),
      (account) => emit(LoadedState(account: account)),
    );
  }

  Future<void> changeCurrency(CurrencyEnum currency) async {
    if (_currentAccount == null) {
      emit(ErrorState(message: "Счет не был выбран"));
    }
    emit(LoadingState());

    final failOrAccount = await bankAccountRepository.updateAccountById(
      _currentAccount!.id,
      AccountUpdateRequestModel(
        name: _currentAccount!.name,
        balance: _currentAccount!.balance,
        currency: currency,
      ),
    );
    emit(LoadedState(account: _currentAccount!.copyWith(currency: currency)));

    failOrAccount.fold((fail) => emit(SnackBarState(message: fail.message)), (
      account,
    ) {
      _currentAccount = account;
      emit(LoadedState(account: account));
    });
  }
}

sealed class AccountStateUI {}

class InitialState extends AccountStateUI {}

class LoadingState extends AccountStateUI {}

class LoadedState extends AccountStateUI {
  final AccountModel account;

  LoadedState({required this.account});
}

class ErrorState extends AccountStateUI {
  final String message;

  ErrorState({required this.message});
}

class SnackBarState extends AccountStateUI {
  final String message;

  SnackBarState({required this.message});
}
