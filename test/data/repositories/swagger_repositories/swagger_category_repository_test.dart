import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yandex_school_finance/core/datasource_failures.dart';
import 'package:yandex_school_finance/data/models/freezed_models/category_model.dart';
import 'package:yandex_school_finance/data/repositories/swagger_repositories/swagger_category_repository.dart';
import 'package:yandex_school_finance/data/repositories/swagger_repositories/swagger_drift_connection.dart';
import 'package:yandex_school_finance/domain/entity/synced_response.dart';

import 'swagger_category_repository_test.mocks.dart';

@GenerateMocks([SwaggerDriftConnection])
void main() {
  late final SwaggerDriftConnection mockDataSource;
  late final SwaggerCategoryRepository categoryRepository;

  setUpAll(() {
    mockDataSource = MockSwaggerDriftConnection();
    categoryRepository = SwaggerCategoryRepository(mockDataSource);
  });

  group("Swagger Category Repository ", () {
    final categories = [
      CategoryModel(id: 1, name: "Name", emoji: "💰", isIncome: true),
      CategoryModel(id: 2, name: "Loan pay", emoji: "💰", isIncome: false),
    ];

    test('returns synchronized categories', () async {
      when(mockDataSource.sync()).thenAnswer((_) async => true);
      when(mockDataSource.getCategories()).thenAnswer((_) async => categories);

      expect(
        await categoryRepository.getCategories(),
        Right(SyncedResponse(categories, isSynced: true)),
      );
    });

    test("returns unsynchronized categories", () async {
      when(mockDataSource.sync()).thenAnswer((_) async => false);
      when(mockDataSource.getCategories()).thenAnswer((_) async => categories);

      expect(
        await categoryRepository.getCategories(),
        Right(SyncedResponse(categories, isSynced: false)),
      );
    });

    test("returns failure instead of exception", () async {
      when(mockDataSource.sync()).thenAnswer((_) async => false);
      when(
        mockDataSource.getCategories(),
      ).thenAnswer((_) async => throw Exception());

      expect(
        await categoryRepository.getCategories(),
        Left(UnhandledFailure()),
      );
    });
  });
}
