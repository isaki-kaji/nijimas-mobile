import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:nijimas/domain/request/create_user_request.dart';
import 'package:nijimas/repository/abstract_user_repository.dart';

final userRepositoryProvider = Provider<AbstractUserRepository>((ref) {
  return UserRepository();
});

class UserRepository extends AbstractUserRepository {
  final String baseUrl = "http://localhost:8080/user/create";

  @override
  Future<dynamic> createUser(CreateUserRequest request) async {
    try {
      final response = await http.post(Uri.parse(baseUrl),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode(request.toJson()));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to create user");
      }
    } catch (e) {
      print(e);
    }
  }
}
