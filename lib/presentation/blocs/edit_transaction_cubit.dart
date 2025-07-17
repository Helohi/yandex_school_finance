import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_brief_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/category_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/transaction_models/transaction_request_model.dart';
import 'package:yandex_school_finance/domain/repositories/bank_account_repository.dart';
import 'package:yandex_school_finance/domain/repositories/category_repository.dart';
import 'package:yandex_school_finance/domain/repositories/transaction_repository.dart';

class EditTransactionCubit extends Cubit<EditTransactionUIState> {
  EditTransactionCubit(
    this._accountRepository,
    this._categoryRepository,
    this._transactionRepository,
  ) : super(InitialState());

  final BankAccountRepository _accountRepository;
  final CategoryRepository _categoryRepository;
  final TransactionRepository _transactionRepository;

  void loadAll(bool isIncome) {
    loadAccounts();
    loadCategories(isIncome);
  }

  Future<void> loadAccounts() async {
    emit(AccountsLoadingState());
    final failOrAccounts = await _accountRepository.getAccounts();

    failOrAccounts.fold(
      (fail) => emit(AccountsErrorState(message: fail.message)),
      (accounts) => emit(
        AccountsLoadedState(
          accounts: accounts.response
              .map((el) => AccountBriefModel.fromAccountModel(el))
              .toList(),
        ),
      ),
    );
  }

  Future<void> loadCategories(bool isIncome) async {
    emit(CategoriesLoadingState());

    final failOrCategories = await _categoryRepository.getCategories();

    failOrCategories.fold(
      (fail) => emit(CategoriesErrorState(message: fail.message)),
      (categories) => emit(
        CategoriesLoadedState(
          categories: categories.response
              .where((category) => category.isIncome == isIncome)
              .toList(),
        ),
      ),
    );
  }

  Future<void> createTransaction(TransactionRequestModel transaction) async {
    emit(TransactionEditLoadingState());

    final failOrTransaction = await _transactionRepository.createTransaction(
      transaction,
    );

    failOrTransaction.fold(
      (fail) => emit(TransactionEditError(message: fail.message)),
      (transaction) => emit(TransactionEditSuccessfully()),
    );
  }

  Future<void> updateTransaction(
    int id,
    TransactionRequestModel transaction,
  ) async {
    emit(TransactionEditLoadingState());

    final failOrTransaction = await _transactionRepository
        .updateTransactionById(id, transaction);

    failOrTransaction.fold(
      (fail) => emit(TransactionEditError(message: fail.message)),
      (transaction) => emit(TransactionEditSuccessfully()),
    );
  }

  Future<void> deleteTransaction(int id) async {
    emit(TransactionEditLoadingState());

    final failOrVoid = await _transactionRepository.removeTransactionById(id);

    failOrVoid.fold(
      (fail) => emit(TransactionEditError(message: fail.message)),
      (_) => emit(TransactionEditSuccessfully()),
    );
  }
}

sealed class EditTransactionUIState {}

class InitialState extends EditTransactionUIState {}

sealed class CategoryUIStates extends EditTransactionUIState {}

class CategoriesLoadingState extends CategoryUIStates {}

class CategoriesLoadedState extends CategoryUIStates {
  final List<CategoryModel> categories;

  CategoriesLoadedState({required this.categories});
}

class CategoriesErrorState extends CategoryUIStates {
  final String Function(BuildContext context) message;

  CategoriesErrorState({required this.message});
}

sealed class AccountUIStates extends EditTransactionUIState {}

class AccountsLoadingState extends AccountUIStates {}

class AccountsLoadedState extends AccountUIStates {
  final List<AccountBriefModel> accounts;

  AccountsLoadedState({required this.accounts});
}

class AccountsErrorState extends AccountUIStates {
  final String Function(BuildContext context) message;

  AccountsErrorState({required this.message});
}

sealed class TransactionStates extends EditTransactionUIState {}

class TransactionEditLoadingState extends TransactionStates {}

class TransactionEditSuccessfully extends TransactionStates {}

class TransactionEditError extends TransactionStates {
  final String Function(BuildContext context) message;

  TransactionEditError({required this.message});
}
