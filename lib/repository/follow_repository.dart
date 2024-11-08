import 'package:dio/dio.dart';
import 'package:logger/web.dart';
import 'package:nijimas/core/constant/env_constant.dart';
import 'package:nijimas/core/request/toggle_follow_request_request.dart';
import 'package:nijimas/repository/interceptor/auth_interceptor.dart';

class FollowRepository {
  final Dio _dio;
  final Logger _logger;
  FollowRepository({required Logger logger})
      : _dio = Dio(),
        _logger = logger {
    _dio.interceptors.add(AuthInterceptor());
  }

  Future<void> toggleFollow(ToggleFollowRequestRequest request) async {
    final response =
        await _dio.post("${Env.baseUrl}/follows", data: request.toJson());
    if (response.statusCode == 201 || response.statusCode == 204) {
      return;
    }
    _logger.e(response.data);
    throw Exception(
        "Failed to toggle follow with status code: ${response.statusCode}");
  }
}
