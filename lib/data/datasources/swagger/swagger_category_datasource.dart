import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yandex_school_finance/core/datasource_failures.dart';
import 'package:yandex_school_finance/data/datasources/swagger/swagger_common.dart';
import 'package:yandex_school_finance/data/models/category_model.dart';

class SwaggerCategoryDatasource {
  Future<List<CategoryModel>> getCategories() async {
    final response = await http.get(
      Uri.parse("${SwaggerCommon.baseUrl}/categories"),
      headers: SwaggerCommon.authHeader,
    );

    if (response.statusCode == 401) {
      throw UnauthorizedRequest();
    }

    return (jsonDecode(response.body) as List)
        .map((el) => CategoryModel.fromJson(el))
        .toList();
  }
}
