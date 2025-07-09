import 'package:dio/dio.dart';
import 'package:yandex_school_finance/core/datasource_failures.dart';
import 'package:yandex_school_finance/data/models/freezed_models/category_model.dart';

class SwaggerCategoryDatasource {
  SwaggerCategoryDatasource(this.dio);

  final Dio dio;

  Future<List<CategoryModel>> getCategories() async {
    final response = await dio.get("/categories");

    if (response.statusCode == 401) {
      throw UnauthorizedRequest();
    }

    return (response.data as List)
        .map((el) => CategoryModel.fromJson(el))
        .toList();
  }
}
