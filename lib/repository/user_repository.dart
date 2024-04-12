import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/web.dart';
import 'package:nijimas/core/constant/env_constant.dart';
import 'package:nijimas/domain/request/create_user_request.dart';
import 'package:nijimas/repository/abstract_user_repository.dart';

class UserRepository extends AbstractUserRepository {
  final Logger _logger;
  UserRepository({required Logger logger}) : _logger = logger;

  @override
  Future<dynamic> createUser(CreateUserRequest request) async {
    final response = await http.post(Uri.parse("${Env.baseUrl}/users"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(request.toJson()));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      _logger.w("Failed to create user");
      throw Exception("Failed to create user");
    }
  }
}
