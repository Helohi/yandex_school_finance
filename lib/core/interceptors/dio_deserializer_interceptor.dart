import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:worker_manager/worker_manager.dart';

class DioDeserializerInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    response.data = await workerManager.execute(
      () => jsonDecode(response.data),
    );
    handler.next(response);
  }
}
