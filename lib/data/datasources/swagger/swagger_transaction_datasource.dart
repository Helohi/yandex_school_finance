import 'dart:convert';

import 'package:yandex_school_finance/core/datasource_failures.dart';
import 'package:yandex_school_finance/data/datasources/swagger/swagger_common.dart';
import 'package:yandex_school_finance/data/models/transaction_models/transaction_response_model.dart';
import 'package:http/http.dart' as http;

class SwaggerTransactionDatasource {
  Future<List<TransactionResponseModel>> getTransactionsInPeriod(
    int id, [
    DateTime? startDate,
    DateTime? endDate,
  ]) async {
    final response = await http.get(
      Uri.parse(
        "${SwaggerCommon.baseUrl}/transactions/account/$id/period",
      ).replace(
        queryParameters: {
          if (startDate != null)
            "startDate": startDate.toIso8601String().split("T")[0],
          if (endDate != null)
            "endDate": endDate.toIso8601String().split("T")[0],
        },
      ),
      headers: SwaggerCommon.authHeader,
    );

    if (response.statusCode == 400) {
      throw IncorrectIdFormat();
    } else if (response.statusCode == 401) {
      throw UnauthorizedRequest();
    }

    return (jsonDecode(response.body) as List)
        .map((el) => TransactionResponseModel.fromJson(el))
        .toList();
  }
}
