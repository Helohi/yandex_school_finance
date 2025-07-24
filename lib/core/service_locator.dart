import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yandex_school_finance/core/interceptors/dio_deserializer_interceptor.dart';
import 'package:yandex_school_finance/core/interceptors/dio_retry_interceptor.dart';
import 'package:yandex_school_finance/data/datasources/drift/drift_database_datasource.dart';
import 'package:yandex_school_finance/data/datasources/swagger/swagger_bank_account_datasource.dart';
import 'package:yandex_school_finance/data/datasources/swagger/swagger_category_datasource.dart';
import 'package:yandex_school_finance/data/datasources/swagger/swagger_transaction_datasource.dart';
import 'package:yandex_school_finance/data/repositories/swagger_repositories/swagger_bank_account_repositories.dart';
import 'package:yandex_school_finance/data/repositories/swagger_repositories/swagger_category_repository.dart';
import 'package:yandex_school_finance/data/repositories/swagger_repositories/swagger_drift_connection.dart';
import 'package:yandex_school_finance/data/repositories/swagger_repositories/swagger_transaction_repository.dart';
import 'package:yandex_school_finance/domain/repositories/bank_account_repository.dart';
import 'package:yandex_school_finance/domain/repositories/category_repository.dart';
import 'package:yandex_school_finance/domain/repositories/transaction_repository.dart';
import 'package:yandex_school_finance/domain/use_cases/get_account_statistics.dart';
import 'package:yandex_school_finance/domain/use_cases/get_current_account.dart';
import 'package:yandex_school_finance/domain/use_cases/get_current_account_transactions_in_period.dart';
import 'package:yandex_school_finance/domain/use_cases/get_today_transactions.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(
    () =>
        Dio(
            BaseOptions(
              baseUrl: "https://shmr-finance.ru/api/v1",
              headers: {"Authorization": "Bearer ${dotenv.env["TOKEN"]}"},
              contentType: "application/json",
              responseType: ResponseType.plain,
            ),
          )
          ..interceptors.addAll([
            DioDeserializerInterceptor(),
            DioRetryInterceptor(),
          ]),
  );

  // DataSources
  sl.registerFactory(() => SwaggerBankAccountDatasource(sl()));

  sl.registerFactory(() => SwaggerCategoryDatasource(sl()));

  sl.registerFactory(() => SwaggerTransactionDatasource(sl()));

  // NOT IN PRODUCTION
  // sl.registerLazySingleton(() => DriftDatabaseDatasource()..dropEverything());
  sl.registerLazySingleton(() => DriftDatabaseDatasource());

  // Connectors
  sl.registerFactory(
    () => SwaggerDriftConnection(sl(), sl(), sl(), sl(), sl()),
  );

  // Repositories
  sl.registerFactory<BankAccountRepository>(
    () => SwaggerBankAccountRepositories(sl(), sl()),
  );

  sl.registerFactory<CategoryRepository>(() => SwaggerCategoryRepository(sl()));

  sl.registerFactory<TransactionRepository>(
    () => SwaggerTransactionRepository(sl(), sl()),
  );

  // Use Cases
  sl.registerFactory(() => GetCurrentAccountTransactionsInPeriod(sl(), sl()));
  sl.registerFactory(() => GetTodayTransactions(sl()));
  sl.registerFactory(() => GetCurrentAccount(sl()));
  sl.registerFactory(() => GetAccountStatistics(sl()));

  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  // sharedPreferences.clear();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);
}
