import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/web.dart';
import 'package:nijimas/core/constant/env_constants.dart';
import 'package:nijimas/core/model/follow_request.dart';
import 'package:nijimas/core/request/toggle_follow_request_request.dart';
import 'package:nijimas/repository/interceptor/auth_interceptor.dart';

class FollowRequestRepository {
  final Dio _dio;
  final Logger _logger;
  FollowRequestRepository({required Logger logger})
      : _dio = Dio(),
        _logger = logger {
    _dio.interceptors.add(AuthInterceptor());
  }

  Future<void> doFollowRequest(ToggleFollowRequestRequest request) async {
    final response = await _dio.post("${Env.baseUrl}/follow-requests",
        data: request.toJson());
    if (response.statusCode == HttpStatus.created) {
      return;
    }
    _logger.e(response.data);
    throw Exception(
        "Failed to do follow request with status code: ${response.statusCode}");
  }

  Future<void> cancelFollowRequest(String targetUid) async {
    final response = await _dio.delete(
      "${Env.baseUrl}/follow-requests/$targetUid",
    );
    if (response.statusCode == HttpStatus.ok) {
      return;
    }
    _logger.e(response.data);
    throw Exception(
        "Failed to delete follow request with status code: ${response.statusCode}");
  }

  Future<void> handleFollowRequest(
    String requestId,
    String status,
  ) async {
    final response = await _dio.put(
      "${Env.baseUrl}/follow-requests/$requestId",
      queryParameters: {"action": status},
    );

    if (response.statusCode == HttpStatus.ok) {
      return;
    }

    _logger.e(response.data);
    throw Exception(
        "Failed to handle follow request with status code: ${response.statusCode}");
  }

  Future<List<FollowRequest>> getFollowRequests() async {
    final response = await _dio.get("${Env.baseUrl}/follow-requests");
    if (response.statusCode == HttpStatus.ok) {
      return (response.data as List)
          .map((e) => FollowRequest.fromJson(e))
          .toList();
    }
    _logger.e(response.data);

    throw Exception(
        "Failed to get follow requests with status code: ${response.statusCode}");
  }
}
