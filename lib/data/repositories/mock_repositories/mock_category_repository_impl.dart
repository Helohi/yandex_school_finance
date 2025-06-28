import 'package:dartz/dartz.dart';
import 'package:yandex_school_finance/core/datasource_failures.dart';
import 'package:yandex_school_finance/data/models/freezed_models/category_model.dart';
import 'package:yandex_school_finance/domain/repositories/category_repository.dart';

class MockCategoryRepositoryImpl implements CategoryRepository {
  final List<Map<String, Object?>> categories = [
    {"id": 1, "name": "Зарплата", "emoji": "💰", "isIncome": true},
    {"id": 2, "name": "Обучение", "emoji": "📚", "isIncome": false},
    {"id": 3, "name": "Дары", "emoji": "🎁", "isIncome": true},
    {"id": 4, "name": "Траты на Дом", "emoji": "🏠", "isIncome": false},
  ];

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      await Future.delayed(Duration(seconds: 1));

      return Right(
        categories.map((category) => CategoryModel.fromJson(category)).toList(),
      );
    } catch (e) {
      return Left(UnhandledFailure());
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategoriesWithType(
    bool isIncome,
  ) async {
    try {
      await Future.delayed(Duration(seconds: 1));

      return Right(
        categories
            .where((category) => category["isIncome"] == isIncome)
            .map((category) => CategoryModel.fromJson(category))
            .toList(),
      );
    } catch (e) {
      return Left(UnhandledFailure());
    }
  }
}
