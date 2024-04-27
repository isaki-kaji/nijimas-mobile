import 'package:dio/dio.dart';
import 'package:logger/web.dart';
import 'package:nijimas/core/constant/env_constant.dart';
import 'package:nijimas/core/util/auth_interceptor.dart';
import 'package:nijimas/domain/request/create_post_request.dart';
import 'package:nijimas/repository/abstract_post_repository.dart';

class PostRepository extends AbstractPostRepository {
  final Dio _dio;
  final Logger _logger;
  PostRepository({required Logger logger})
      : _dio = Dio(),
        _logger = logger {
    _dio.interceptors.add(AuthInterceptor());
  }

  @override
  Future<dynamic> createPost(CreatePostRequest request) async {
    final response =
        await _dio.post("${Env.baseUrl}/posts", data: request.toJson());
    if (response.statusCode == 201) {
      return response.data;
    }
    _logger.e(response.data);
    throw Exception(
        "Failed to create post with status code: ${response.statusCode}");
  }
}
