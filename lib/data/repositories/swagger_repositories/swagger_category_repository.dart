import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:yandex_school_finance/core/datasource_failures.dart';
import 'package:yandex_school_finance/data/datasources/swagger/swagger_category_datasource.dart';
import 'package:yandex_school_finance/data/models/freezed_models/category_model.dart';
import 'package:yandex_school_finance/domain/repositories/category_repository.dart';

class SwaggerCategoryRepository implements CategoryRepository {
  final SwaggerCategoryDatasource _categoryDatasource;

  SwaggerCategoryRepository(SwaggerCategoryDatasource categoryDatasource)
    : _categoryDatasource = categoryDatasource;

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      return Right(await _categoryDatasource.getCategories());
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      log("${e.runtimeType}: $e");
      return Left(UnhandledFailure());
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategoriesWithType(
    bool isIncome,
  ) {
    // TODO: implement getCategoriesWithType
    throw UnimplementedError();
  }
}
