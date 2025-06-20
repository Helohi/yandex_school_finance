import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yandex_school_finance/core/datasource_failures.dart';
import 'package:yandex_school_finance/data/datasources/swagger/swagger_common.dart';
import 'package:yandex_school_finance/data/models/account_models/account_model.dart';

class SwaggerBankAccountDatasource {
  Future<List<AccountModel>> getAccounts() async {
    final response = await http.get(
      Uri.parse("${SwaggerCommon.baseUrl}/accounts"),
      headers: SwaggerCommon.authHeader,
    );

    if (response.statusCode == 401) {
      throw UnauthorizedRequest();
    }

    return (jsonDecode(response.body) as List)
        .map((el) => AccountModel.fromJson(el))
        .toList();
  }
}
