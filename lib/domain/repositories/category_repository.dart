import 'package:dartz/dartz.dart';
import 'package:yandex_school_finance/core/datasource_failures.dart';
import 'package:yandex_school_finance/data/models/freezed_models/category_model.dart';
import 'package:yandex_school_finance/domain/entity/synced_response.dart';

abstract class CategoryRepository {
  Future<Either<Failure, SyncedResponse<List<CategoryModel>>>> getCategories();
}
