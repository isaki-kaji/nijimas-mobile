import 'package:dio/dio.dart';

class TimezoneInterceptor extends Interceptor {
  TimezoneInterceptor();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers["Time-Zone"] = "Asia/Tokyo";
    handler.next(options);
  }
}
