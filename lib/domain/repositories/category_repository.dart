import 'package:dartz/dartz.dart';
import 'package:yandex_school_finance/core/datasource_failures.dart';
import 'package:yandex_school_finance/data/models/category_model.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryModel>>> getCategories();

  Future<Either<Failure, List<CategoryModel>>> getCategoriesWithType(
    bool isIncome,
  );
}
