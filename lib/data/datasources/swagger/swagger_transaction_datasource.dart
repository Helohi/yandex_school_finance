import 'package:dio/dio.dart';
import 'package:yandex_school_finance/core/datasource_failures.dart';
import 'package:yandex_school_finance/data/models/freezed_models/transaction_models/transaction_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/transaction_models/transaction_request_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/transaction_models/transaction_response_model.dart';

class SwaggerTransactionDatasource {
  SwaggerTransactionDatasource(this.dio);

  final Dio dio;

  Future<List<TransactionResponseModel>> getTransactionsInPeriod(
    int id, [
    DateTime? startDate,
    DateTime? endDate,
  ]) async {
    final response = await dio.get(
      '/transactions/account/$id/period',
      queryParameters: {
        if (startDate != null)
          "startDate": startDate.toIso8601String().split("T")[0],
        if (endDate != null) "endDate": endDate.toIso8601String().split("T")[0],
      },
    );

    if (response.statusCode == 400) {
      throw IncorrectIdFormat();
    } else if (response.statusCode == 401) {
      throw UnauthorizedRequest();
    }

    return (response.data as List)
        .map((el) => TransactionResponseModel.fromJson(el))
        .toList();
  }

  Future<TransactionModel> createTransaction(
    TransactionRequestModel transaction,
  ) async {
    final response = await dio.post(
      '/transactions',
      data: transaction.toJson(),
    );

    if (response.statusCode == 400) {
      throw IncorrectIdFormat();
    } else if (response.statusCode == 401) {
      throw UnauthorizedRequest();
    } else if (response.statusCode == 404) {
      throw AccountOrCategoryNotFound();
    }

    return TransactionModel.fromJson(response.data);
  }

  Future<TransactionResponseModel> updateTransactionById(
    int id,
    TransactionRequestModel transaction,
  ) async {
    final response = await dio.put(
      '/transactions/$id',
      data: transaction.toJson(),
    );

    if (response.statusCode == 400) {
      throw IncorrectIdFormat();
    } else if (response.statusCode == 401) {
      throw UnauthorizedRequest();
    } else if (response.statusCode == 404) {
      throw AccountOrCategoryNotFound();
    }

    return TransactionResponseModel.fromJson(response.data);
  }

  Future<void> removeTransactionById(int id) async {
    final response = await dio.delete('/transactions/$id');

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
