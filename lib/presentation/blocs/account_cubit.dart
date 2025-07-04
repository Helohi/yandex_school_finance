import 'package:decimal/decimal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_school_finance/core/enums/currency_enum.dart';
import 'package:yandex_school_finance/core/enums/period_enum.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_update_request_model.dart';
import 'package:yandex_school_finance/domain/repositories/bank_account_repository.dart';
import 'package:yandex_school_finance/domain/use_cases/get_account_statistics.dart';
import 'package:yandex_school_finance/domain/use_cases/get_current_account.dart';

class AccountCubit extends Cubit<MainAccountStateUI> {
  AccountCubit(
    this._getCurrentAccount,
    this._bankAccountRepository,
    this._getAccountStatistics,
  ) : super(InitialState());

  final GetCurrentAccount _getCurrentAccount;
  final BankAccountRepository _bankAccountRepository;
  final GetAccountStatistics _getAccountStatistics;

  AccountModel? _currentAccount;

  void loadAccount() async {
    emit(AccountLoadingState());

    final failOrAccount = await _getCurrentAccount();
    failOrAccount.fold(
      (fail) => emit(AccountErrorState(message: fail.message)),
      (account) {
        _currentAccount = account;
        emit(AccountLoadedState(account: account));
      },
    );
  }

  Future<void> updateAccount(int id, AccountUpdateRequestModel account) async {
    if (_currentAccount == null) {
      emit(AccountErrorState(message: "Счет не был загружен"));
      return;
    }

    emit(AccountLoadingState());

    final failOrAccount = await _bankAccountRepository.updateAccountById(
      id,
      account,
    );

    emit(
      AccountLoadedState(
        account: _currentAccount!.copyWith(
          name: account.name,
          balance: account.balance,
          currency: account.currency,
        ),
      ),
    );

    failOrAccount.fold(
      (fail) => emit(AccountErrorState(message: fail.message)),
      (account) => emit(AccountLoadedState(account: account)),
    );
  }

  Future<void> changeCurrency(CurrencyEnum currency) async {
    if (_currentAccount == null) {
      emit(AccountErrorState(message: "Счет не был выбран"));
    }
    emit(AccountLoadingState());

    final failOrAccount = await _bankAccountRepository.updateAccountById(
      _currentAccount!.id,
      AccountUpdateRequestModel(
        name: _currentAccount!.name,
        balance: _currentAccount!.balance,
        currency: currency,
      ),
    );
    emit(
      AccountLoadedState(
        account: _currentAccount!.copyWith(currency: currency),
      ),
    );

    failOrAccount.fold(
      (fail) => emit(AccountErrorState(message: fail.message)),
      (account) {
        _currentAccount = account;
        emit(AccountLoadedState(account: account));
      },
    );
  }

  Future<void> loadStatistics(PeriodEnum period) async {
    emit(AccountStatisticsLoadingState());

    final now = DateTime.now();
    final startDate = switch (period) {
      PeriodEnum.month => now.copyWith(month: now.month - 1),
      PeriodEnum.year => now.copyWith(year: now.year - 1),
    };

    if (_currentAccount == null) {
      emit(AccountStatisticsErrorState(message: "Счет не был загружен"));
      return;
    }

    final failOrMap = await _getAccountStatistics(
      _currentAccount!.id,
      startDate,
      now,
      period,
    );

    failOrMap.fold(
      (fail) => emit(AccountStatisticsErrorState(message: fail.message)),
      (map) => emit(AccountStatisticsLoadedState(statistics: map)),
    );
  }
}

sealed class MainAccountStateUI {}

class InitialState extends MainAccountStateUI {}

sealed class AccountStateUI extends MainAccountStateUI {}

class AccountLoadingState extends AccountStateUI {}

class AccountLoadedState extends AccountStateUI {
  final AccountModel account;

  AccountLoadedState({required this.account});
}

class AccountErrorState extends AccountStateUI {
  final String message;

  AccountErrorState({required this.message});
}

sealed class AccountStatisticsStateUI extends MainAccountStateUI {}

class AccountStatisticsLoadingState extends AccountStatisticsStateUI {}

class AccountStatisticsLoadedState extends AccountStatisticsStateUI {
  final Map<DateTime, Decimal> statistics;

  AccountStatisticsLoadedState({required this.statistics});
}

class AccountStatisticsErrorState extends AccountStatisticsStateUI {
  final String message;

  AccountStatisticsErrorState({required this.message});
}
