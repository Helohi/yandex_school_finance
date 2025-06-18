import 'package:get_it/get_it.dart';
import 'package:yandex_school_finance/data/datasources/swagger/swagger_bank_account_datasource.dart';
import 'package:yandex_school_finance/data/datasources/swagger/swagger_category_datasource.dart';
import 'package:yandex_school_finance/data/datasources/swagger/swagger_transaction_datasource.dart';
import 'package:yandex_school_finance/data/repositories/swagger_repositories/swagger_bank_account_repositories.dart';
import 'package:yandex_school_finance/data/repositories/swagger_repositories/swagger_category_repository.dart';
import 'package:yandex_school_finance/data/repositories/swagger_repositories/swagger_transaction_repository.dart';
import 'package:yandex_school_finance/domain/repositories/bank_account_repository.dart';
import 'package:yandex_school_finance/domain/repositories/category_repository.dart';
import 'package:yandex_school_finance/domain/repositories/transaction_repository.dart';
import 'package:yandex_school_finance/domain/use_cases/get_today_transactions.dart';

final sl = GetIt.instance;

void init() {
  // DataSources
  sl.registerFactory(() => SwaggerBankAccountDatasource());

  sl.registerFactory(() => SwaggerCategoryDatasource());

  sl.registerFactory(() => SwaggerTransactionDatasource());

  // Repositories
  sl.registerFactory<BankAccountRepository>(
    () => SwaggerBankAccountRepositories(sl()),
  );

  sl.registerFactory<CategoryRepository>(() => SwaggerCategoryRepository(sl()));

  sl.registerFactory<TransactionRepository>(
    () => SwaggerTransactionRepository(sl()),
  );

  // Use Cases
  sl.registerFactory(
    () => GetTodayTransactions(
      transactionRepository: sl(),
      accountRepository: sl(),
    ),
  );
}
