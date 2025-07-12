import 'package:dio/dio.dart';
import 'package:yandex_school_finance/core/datasource_failures.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_history_response_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_update_request_model.dart';

class SwaggerBankAccountDatasource {
  SwaggerBankAccountDatasource(this.dio);

  final Dio dio;

  Future<List<AccountModel>> getAccounts() async {
    final response = await dio.get("/accounts");

    if (response.statusCode == 401) {
      throw UnauthorizedRequest();
    }

    return (response.data as List)
        .map((el) => AccountModel.fromJson(el))
        .toList();
  }

  Future<AccountModel> getAccountById(int id) async {
    final response = await dio.get("/accounts/$id");

    if (response.statusCode == 400) {
      throw IncorrectIdFormat();
    } else if (response.statusCode == 401) {
      throw UnauthorizedRequest();
    } else if (response.statusCode == 404) {
      throw IdNotFound();
    }

    return AccountModel.fromJson(response.data);
  }

  Future<AccountHistoryResponseModel> getAccountHistory(int id) async {
    final response = await dio.get("/accounts/$id/history");

    if (response.statusCode == 400) {
      throw IncorrectIdFormat();
    } else if (response.statusCode == 401) {
      throw UnauthorizedRequest();
    } else if (response.statusCode == 404) {
      throw IdNotFound();
    }

    return AccountHistoryResponseModel.fromJson(response.data);
  }

  Future<AccountModel> updateAccountById(
    int id,
    AccountUpdateRequestModel updatedAccount,
  ) async {
    final response = await dio.put(
      "/accounts/$id",
      data: updatedAccount.toJson(),
    );

    if (response.statusCode == 400) {
      throw IncorrectIdFormat();
    } else if (response.statusCode == 401) {
      throw UnauthorizedRequest();
    } else if (response.statusCode == 404) {
      throw IdNotFound();
    }

    return AccountModel.fromJson(response.data);
  }
}
