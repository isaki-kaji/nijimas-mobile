import 'package:dio/dio.dart';
import 'package:logger/web.dart';
import 'package:nijimas/core/constant/env_constant.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/repository/interceptor/auth_interceptor.dart';
import 'package:nijimas/core/model/post.dart';
import 'package:nijimas/core/request/create_post_request.dart';

class PostRepository {
  final Dio _dio;
  final Logger _logger;
  PostRepository({required Logger logger})
      : _dio = Dio(),
        _logger = logger {
    _dio.interceptors.add(AuthInterceptor());
  }

  Future<dynamic> createPost(CreatePostRequest request) async {
    print(request.toJson());
    final response =
        await _dio.post("${Env.baseUrl}/posts", data: request.toJson());
    if (response.statusCode == 201) {
      return response.data;
    }
    _logger.e(response.data);
    throw Exception(
        "Failed to create post with status code: ${response.statusCode}");
  }

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

  Future<List<Post>> getOwnPostsByMainCategory(
      Map<PostQueryKey, dynamic> params) async {
    try {
      final response = await _dio.get("${Env.baseUrl}/me/posts",
          queryParameters: {
            "main-category": params[PostQueryKey.mainCategory]
          });
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

  Future<List<Post>> getOwnPostsBySubCategory(
      Map<PostQueryKey, dynamic> params) async {
    try {
      final response = await _dio.get("${Env.baseUrl}/me/posts",
          queryParameters: {"sub-category": params[PostQueryKey.subCategory]});
      if (response.statusCode == 200) {
        List<Post> posts =
            (response.data as List).map((post) => Post.fromJson(post)).toList();
        return posts;
      } else {
        _logger.e("Error response: ${response.data}");
        throw Exception(
            "Failed to get posts by sub category with status code: ${response.statusCode}");
      }
    } catch (e) {
      _logger.e("Exception: $e");
      throw Exception("Failed to get posts by sub category: $e");
    }
  }

  Future<List<Post>> getTimelinePosts() async {
    try {
      final response = await _dio.get("${Env.baseUrl}/me/timeline");
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
}
