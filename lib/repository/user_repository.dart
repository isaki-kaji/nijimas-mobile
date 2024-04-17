import 'package:dio/dio.dart';
import 'package:logger/web.dart';
import 'package:nijimas/core/constant/env_constant.dart';
import 'package:nijimas/core/util/auth_interceptor.dart';
import 'package:nijimas/core/util/exception.dart';
import 'package:nijimas/domain/request/create_user_request.dart';
import 'package:nijimas/domain/response/user_response.dart';
import 'package:nijimas/repository/abstract_user_repository.dart';

class UserRepository extends AbstractUserRepository {
  final Dio _dio;
  final Logger _logger;
  UserRepository({required Logger logger})
      : _dio = Dio(),
        _logger = logger {
    _dio.interceptors.add(AuthInterceptor());
  }

  @override
  Future<dynamic> createUser(CreateUserRequest request) async {
    final response =
        await _dio.post("${Env.baseUrl}/users", data: request.toJson());
    if (response.statusCode == 201) {
      return response.data;
    } else if (response.statusCode == 409) {
      throw UserAlreadyExistsException();
    } else {
      throw Exception(
          "Failed to create user with status code: ${response.statusCode}");
    }
  }

  @override
  Future<dynamic> getUser(String uid) async {
    final response = await _dio.get("${Env.baseUrl}/users/$uid");
    if (response.statusCode == 200) {
      return UserResponse.fromJson(response.data);
    } else {
      throw Exception(
          "Failed to get user with status code: ${response.statusCode}");
    }
  }
}
