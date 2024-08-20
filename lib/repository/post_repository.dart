import 'package:dio/dio.dart';
import 'package:logger/web.dart';
import 'package:nijimas/core/constant/env_constant.dart';
import 'package:nijimas/core/util/auth_interceptor.dart';
import 'package:nijimas/core/model/post.dart';
import 'package:nijimas/core/request/create_post_request.dart';
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

  @override
  Future<List<Post>> getOwnPosts() async {
    try {
      final response = await _dio.get("${Env.baseUrl}/me/posts");
      if (response.statusCode == 200) {
        List<Post> posts =
            (response.data as List).map((post) => Post.fromJson(post)).toList();
        return posts;
      } else {
        _logger.e("Error response: ${response.data}");
        throw Exception(
            "Failed to get posts by uid with status code: ${response.statusCode}");
      }
    } catch (e) {
      _logger.e("Exception: $e");
      throw Exception("Failed to get posts by uid: $e");
    }
  }

  @override
  Future<List<Post>> getPostsByUid({required String uid}) async {
    try {
      final response = await _dio.get("${Env.baseUrl}/users/$uid/posts");
      if (response.statusCode == 200) {
        List<Post> posts =
            (response.data as List).map((post) => Post.fromJson(post)).toList();
        return posts;
      } else {
        _logger.e("Error response: ${response.data}");
        throw Exception(
            "Failed to get posts by uid with status code: ${response.statusCode}");
      }
    } catch (e) {
      _logger.e("Exception: $e");
      throw Exception("Failed to get posts by uid: $e");
    }
  }

  @override
  Future<List<Post>> getPostsByMainCategory(
      {required String mainCategory}) async {
    try {
      final response = await _dio.get("${Env.baseUrl}/posts",
          queryParameters: {"main-category": mainCategory});
      if (response.statusCode == 200) {
        List<Post> posts =
            (response.data as List).map((post) => Post.fromJson(post)).toList();
        return posts;
      } else {
        _logger.e("Error response: ${response.data}");
        throw Exception(
            "Failed to get posts by main category with status code: ${response.statusCode}");
      }
    } catch (e) {
      _logger.e("Exception: $e");
      throw Exception("Failed to get posts by main category: $e");
    }
  }
}
