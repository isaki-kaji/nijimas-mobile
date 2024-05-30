import 'package:dio/dio.dart';
import 'package:logger/web.dart';
import 'package:nijimas/core/constant/env_constant.dart';
import 'package:nijimas/core/util/auth_interceptor.dart';
import 'package:nijimas/core/util/exception.dart';
import 'package:nijimas/domain/request/create_user_request.dart';
import 'package:nijimas/domain/response/user_response.dart';

class UserRepository {
  final Dio _dio;
  final Logger _logger;
  UserRepository({required Logger logger})
      : _dio = Dio(),
        _logger = logger {
    _dio.interceptors.add(AuthInterceptor());
  }

  Future<UserResponse> createUser(CreateUserRequest request) async {
    final response =
        await _dio.post("${Env.baseUrl}/users", data: request.toJson());
    if (response.statusCode == 201) {
      return UserResponse.fromJson(response.data);
    }
    if (response.statusCode == 409) {
      throw UserAlreadyExistsException();
    }
    _logger.e(response.data);
    throw Exception(
        "Failed to create user with status code: ${response.statusCode}");
  }

  Future<UserResponse> getUser(String uid) async {
    final response = await _dio.get("${Env.baseUrl}/users/$uid");
    if (response.statusCode == 200) {
      return UserResponse.fromJson(response.data);
    }
    _logger.e(response.data);
    throw Exception(
        "Failed to get user with status code: ${response.statusCode}");
  }
}
