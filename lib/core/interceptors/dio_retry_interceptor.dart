import 'dart:math';

import 'package:dio/dio.dart';
import 'package:yandex_school_finance/core/service_locator.dart';

const kMaxRetryCount = 5;
const kBaseRetryDelayInMilliseconds = 500;
const kStatusCodesToRetry = {500, 502, 503, 504, 408, 429};

class DioRetryInterceptor extends Interceptor {
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final retryCount = err.requestOptions.extra['retryCount'] ?? 0 + 1;
    if (!kStatusCodesToRetry.contains(err.response?.statusCode) ||
        retryCount > kMaxRetryCount) {
      return handler.next(err);
    }

    err.requestOptions.extra['retryCount'] = retryCount;
    final delay = _calculateDelay(retryCount);
    await Future.delayed(delay);

    try {
      final response = await sl.get<Dio>().fetch(err.requestOptions);
      handler.resolve(response);
    } catch (_) {
      return handler.next(err);
    }
  }

  Duration _calculateDelay(int retryCount) {
    final jitter = Random().nextDouble() * kBaseRetryDelayInMilliseconds;
    final delay = kBaseRetryDelayInMilliseconds * pow(2, retryCount - 1);
    return Duration(milliseconds: (delay + jitter).toInt());
  }
}
