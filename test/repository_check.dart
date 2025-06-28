import 'dart:developer';

import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yandex_school_finance/core/enums/currency_enum.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_create_request_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_update_request_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/transaction_models/transaction_request_model.dart';
import 'package:yandex_school_finance/data/repositories/mock_repositories/mock_bank_account_repository_impl.dart';
import 'package:yandex_school_finance/data/repositories/mock_repositories/mock_category_repository_impl.dart';
import 'package:yandex_school_finance/data/repositories/mock_repositories/mock_transaction_repository_impl.dart';

void main() {
  test('Category Repository Test', () async {
    MockCategoryRepositoryImpl categoryRepository =
        MockCategoryRepositoryImpl();

    log(categoryRepository.categories.toString());

    log((await categoryRepository.getCategories()).toString());

    log((await categoryRepository.getCategoriesWithType(true)).toString());

    log((await categoryRepository.getCategoriesWithType(false)).toString());
  });

  test("Account Repository Test", () async {
    MockBankAccountRepositoryImpl accountRepository =
        MockBankAccountRepositoryImpl();

    log((await accountRepository.getAccounts()).toString());

    log(
      (await accountRepository.createAccount(
        AccountCreateRequestModel(
          name: "New Account",
          balance: Decimal.parse("10000"),
          currency: CurrencyEnum.RUB,
        ),
      )).toString(),
    );

    log((await accountRepository.getAccountById(0)).toString());

    log(
      (await accountRepository.updateAccountById(
        1,
        AccountUpdateRequestModel(
          balance: Decimal.parse("11200"),
          currency: CurrencyEnum.USD,
          name: "Updated Account",
        ),
      )).toString(),
    );

    log((await accountRepository.getAccountHistory(0)).toString());
  });

  test("Transaction Repository Test", () async {
    MockTransactionRepositoryImpl transactionRepository =
        MockTransactionRepositoryImpl();

    log(
      (await transactionRepository.createTransaction(
        TransactionRequestModel(
          accountId: 1,
          categoryId: 1,
          amount: Decimal.parse("12312"),
          transactionDate: DateTime.now(),
        ),
      )).toString(),
    );

    log((await transactionRepository.getTransactionById(1)).toString());

    log(
      (await transactionRepository.updateTransactionById(
        1,
        TransactionRequestModel(
          accountId: 1,
          categoryId: 1,
          amount: Decimal.parse("2334"),
          transactionDate: DateTime.now(),
        ),
      )).toString(),
    );

    await transactionRepository.removeTransactionById(1);

    log((await transactionRepository.getTransactionsInPeriod(1)).toString());
  });
}
