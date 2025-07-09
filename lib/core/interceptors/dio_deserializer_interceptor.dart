import 'package:dio/dio.dart';

class DioDeserializerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.extra["retryCount"] ?? 0 < 4) {
      options.baseUrl = "https://httpstat.us"; // 503 Error/
    }
    return handler.next(options);
  }
}
