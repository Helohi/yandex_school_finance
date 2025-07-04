import 'dart:convert';

import 'package:yandex_school_finance/core/datasource_failures.dart';
import 'package:yandex_school_finance/data/datasources/swagger/swagger_common.dart';
import 'package:http/http.dart' as http;
import 'package:yandex_school_finance/data/models/freezed_models/transaction_models/transaction_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/transaction_models/transaction_request_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/transaction_models/transaction_response_model.dart';

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

  Future<TransactionModel> createTransaction(
    TransactionRequestModel transaction,
  ) async {
    final response = await http.post(
      Uri.parse("${SwaggerCommon.baseUrl}/transactions"),
      headers: SwaggerCommon.authHeader
        ..addAll(SwaggerCommon.contentTypeHeader),
      body: jsonEncode(transaction.toJson()),
    );

    if (response.statusCode == 400) {
      throw IncorrectIdFormat();
    } else if (response.statusCode == 401) {
      throw UnauthorizedRequest();
    } else if (response.statusCode == 404) {
      throw AccountOrCategoryNotFound();
    }

    return TransactionModel.fromJson(jsonDecode(response.body));
  }

  Future<TransactionResponseModel> updateTransactionById(
    int id,
    TransactionRequestModel transaction,
  ) async {
    final response = await http.put(
      Uri.parse("${SwaggerCommon.baseUrl}/transactions/$id"),
      headers: SwaggerCommon.authHeader
        ..addAll(SwaggerCommon.contentTypeHeader),
      body: jsonEncode(transaction.toJson()),
    );

    if (response.statusCode == 400) {
      throw IncorrectIdFormat();
    } else if (response.statusCode == 401) {
      throw UnauthorizedRequest();
    } else if (response.statusCode == 404) {
      throw AccountOrCategoryNotFound();
    }

    return TransactionResponseModel.fromJson(jsonDecode(response.body));
  }

  Future<void> removeTransactionById(int id) async {
    final response = await http.delete(
      Uri.parse("${SwaggerCommon.baseUrl}/transactions/$id"),
      headers: SwaggerCommon.authHeader,
    );

    if (response.statusCode == 400) {
      throw IncorrectIdFormat();
    } else if (response.statusCode == 401) {
      throw UnauthorizedRequest();
    } else if (response.statusCode == 404) {
      throw AccountOrCategoryNotFound();
    }

    return;
  }
}
