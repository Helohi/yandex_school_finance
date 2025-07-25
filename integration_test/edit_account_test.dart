import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
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
import 'package:yandex_school_finance/presentation/pages/material_app.dart';
import 'package:yandex_school_finance/core/service_locator.dart' as di;

import 'edit_account_test.mocks.dart';

@GenerateMocks([LocalAuthentication, DriftDatabaseDatasource])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await dotenv.load();
    await di.init();
    // await mockedDiInit();
  });

  testWidgets("Account name changing", (tester) async {
    await tester.pumpWidget(const FinanceApp());

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey("AccountPage button")));

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey("AccountEdit button")));

    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(ValueKey("NameTextField")),
      "accountTest",
    );

    await tester.tap(find.byKey(ValueKey("DoneIconButton")));

    await tester.pumpAndSettle();

    expect(find.text("accountTest"), findsOneWidget);
  });
}

Future<void> mockedDiInit() async {
  final sl = GetIt.instance;

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

  final localAuth = MockLocalAuthentication();
  when(localAuth.getAvailableBiometrics()).thenAnswer((_) async => []);
  sl.registerFactory<LocalAuthentication>(() => localAuth);

  // DataSources
  sl.registerFactory(() => SwaggerBankAccountDatasource(sl()));

  sl.registerFactory(() => SwaggerCategoryDatasource(sl()));

  sl.registerFactory(() => SwaggerTransactionDatasource(sl()));

  final driftDatabaseDatasource = MockDriftDatabaseDatasource();
  sl.registerLazySingleton<DriftDatabaseDatasource>(
    () => driftDatabaseDatasource,
  );

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
  SharedPreferences.setMockInitialValues({});
  final sharedPreferences = await SharedPreferences.getInstance();
  // sharedPreferences.clear();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);
}
