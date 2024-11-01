import 'package:dio/dio.dart';
import 'package:logger/web.dart';
import 'package:nijimas/core/constant/env_constant.dart';
import 'package:nijimas/core/request/toggle_follow_request.dart';
import 'package:nijimas/repository/interceptor/auth_interceptor.dart';

class FollowRequestRepository {
  final Dio _dio;
  final Logger _logger;
  FollowRequestRepository({required Logger logger})
      : _dio = Dio(),
        _logger = logger {
    _dio.interceptors.add(AuthInterceptor());
  }

  Future<void> doFollowRequest(ToggleFollowRequest request) async {
    final response = await _dio.post("${Env.baseUrl}/follow-request",
        data: request.toJson());
    if (response.statusCode == 200) {
      return;
    }
    _logger.e(response.data);
    throw Exception(
        "Failed to do follow request with status code: ${response.statusCode}");
  }

  Future<void> deleteFollowRequest(ToggleFollowRequest request) async {
    final response = await _dio.delete("${Env.baseUrl}/follow-request",
        data: request.toJson());
    if (response.statusCode == 204) {
      return;
    }
    _logger.e(response.data);
    throw Exception(
        "Failed to delete follow request with status code: ${response.statusCode}");
  }
}
