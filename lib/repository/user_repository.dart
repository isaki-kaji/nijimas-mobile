import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/web.dart';
import 'package:nijimas/core/constant/env_constant.dart';
import 'package:nijimas/core/model/app_user.dart';
import 'package:nijimas/repository/interceptor/auth_interceptor.dart';
import 'package:nijimas/core/util/exception.dart';
import 'package:nijimas/core/model/user_detail.dart';
import 'package:nijimas/core/request/create_user_request.dart';
import 'package:nijimas/core/request/update_user_request.dart';

class UserRepository {
  final Dio _dio;
  final Logger _logger;
  UserRepository({required Logger logger})
      : _dio = Dio(),
        _logger = logger {
    _dio.interceptors.add(AuthInterceptor());
  }

  Future<dynamic> createUser(CreateUserRequest request) async {
    final response =
        await _dio.post("${Env.baseUrl}/users", data: request.toJson());
    if (response.statusCode == HttpStatus.created) {
      return response.data;
    }
    if (response.statusCode == HttpStatus.conflict) {
      throw UserAlreadyExistsException();
    }
    _logger.e(response.data);
    throw Exception(
        "Failed to create user with status code: ${response.statusCode}");
  }

  Future<dynamic> getOwnUser() async {
    final response = await _dio.get("${Env.baseUrl}/users/me");
    if (response.statusCode == HttpStatus.ok) {
      return AppUser.fromJson(response.data);
    }
    _logger.e(response.data);
    throw Exception(
        "Failed to get user with status code: ${response.statusCode}");
  }

  Future<dynamic> getUser(String uid) async {
    final response = await _dio.get("${Env.baseUrl}/users/$uid");
    if (response.statusCode == HttpStatus.ok) {
      return UserDetail.fromJson(response.data);
    }
    _logger.e(response.data);
    throw Exception(
        "Failed to get user with status code: ${response.statusCode}");
  }

  Future<void> updateUser(UpdateUserRequest request) async {
    final response =
        await _dio.put("${Env.baseUrl}/users", data: request.toJson());
    if (response.statusCode == HttpStatus.ok) {
      return;
    }
    _logger.e(response.data);
    throw Exception(
        "Failed to update user with status code: ${response.statusCode}");
  }
}
