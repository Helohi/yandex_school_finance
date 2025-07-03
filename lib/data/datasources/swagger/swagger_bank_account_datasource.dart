import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yandex_school_finance/core/datasource_failures.dart';
import 'package:yandex_school_finance/data/datasources/swagger/swagger_common.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_history_response_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_response_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_update_request_model.dart';

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

  Future<AccountModel> updateAccountById(
    int id,
    AccountUpdateRequestModel updatedAccount,
  ) async {
    final response = await http.put(
      Uri.parse("${SwaggerCommon.baseUrl}/accounts/$id"),
      headers: SwaggerCommon.authHeader
        ..addAll({"Content-Type": "application/json"}),
      body: jsonEncode(updatedAccount.toJson()),
    );

    if (response.statusCode == 400) {
      throw IncorrectIdFormat();
    } else if (response.statusCode == 401) {
      throw UnauthorizedRequest();
    } else if (response.statusCode == 404) {
      throw IdNotFound();
    }

    return AccountModel.fromJson(jsonDecode(response.body));
  }

  Future<AccountResponseModel> getAccountById(int id) async {
    final response = await http.get(
      Uri.parse("${SwaggerCommon.baseUrl}/accounts/$id"),
      headers: SwaggerCommon.authHeader,
    );

    if (response.statusCode == 400) {
      throw IncorrectIdFormat();
    } else if (response.statusCode == 401) {
      throw UnauthorizedRequest();
    } else if (response.statusCode == 404) {
      throw IdNotFound();
    }

    return AccountResponseModel.fromJson(jsonDecode(response.body));
  }

  Future<AccountHistoryResponseModel> getAccountHistory(int id) async {
    final response = await http.get(
      Uri.parse("${SwaggerCommon.baseUrl}/accounts/$id/history"),
      headers: SwaggerCommon.authHeader,
    );

    if (response.statusCode == 400) {
      throw IncorrectIdFormat();
    } else if (response.statusCode == 401) {
      throw UnauthorizedRequest();
    } else if (response.statusCode == 404) {
      throw IdNotFound();
    }

    return AccountHistoryResponseModel.fromJson(jsonDecode(response.body));
  }
}
