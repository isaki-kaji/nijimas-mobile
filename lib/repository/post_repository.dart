import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/web.dart';
import 'package:nijimas/core/constant/env_constant.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/core/request/update_post_request.dart';
import 'package:nijimas/repository/interceptor/auth_interceptor.dart';
import 'package:nijimas/core/model/post.dart';
import 'package:nijimas/core/request/create_post_request.dart';

class PostRepository {
  final Dio _dio;
  final Logger _logger;
  PostRepository({required Logger logger})
      : _dio = Dio(BaseOptions(
          headers: {
            "Content-Type": "application/json",
          },
        )),
        _logger = logger {
    _dio.interceptors.add(AuthInterceptor());
  }

  Future<dynamic> createPost(CreatePostRequest request) async {
    final response =
        await _dio.post("${Env.baseUrl}/posts", data: request.toJson());
    if (response.statusCode == HttpStatus.created) {
      return response.data;
    }
    _logger.e(response.data);
    throw Exception(
        "Failed to create post with status code: ${response.statusCode}");
  }

  Future<dynamic> updatePost(String postId, UpdatePostRequest request) async {
    final response =
        await _dio.put("${Env.baseUrl}/posts/$postId", data: request.toJson());
    if (response.statusCode == HttpStatus.ok) {
      return response.data;
    }
    _logger.e(response.data);
    throw Exception(
        "Failed to update post with status code: ${response.statusCode}");
  }

  Future<void> deletePost(String postId) async {
    final response = await _dio.delete("${Env.baseUrl}/posts/$postId");
    if (response.statusCode == HttpStatus.ok) {
      return;
    }
    _logger.e(response.data);
    throw Exception(
        "Failed to delete post with status code: ${response.statusCode}");
  }

  Future<List<Post>> getOwnPosts() async {
    try {
      final response = await _dio.get("${Env.baseUrl}/posts/me");
      if (response.statusCode == HttpStatus.ok) {
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
      final response = await _dio.get("${Env.baseUrl}//posts/me",
          queryParameters: {
            "main-category": params[PostQueryKey.mainCategory]
          });
      if (response.statusCode == HttpStatus.ok) {
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
      final response = await _dio.get("${Env.baseUrl}/posts/me",
          queryParameters: {"sub-category": params[PostQueryKey.subCategory]});
      if (response.statusCode == HttpStatus.ok) {
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

  Future<List<Post>> getTimelinePosts(String? referenceId) async {
    try {
      final response = await _dio.get("${Env.baseUrl}/posts/timeline",
          queryParameters: {"reference": referenceId});
      if (response.statusCode == HttpStatus.ok) {
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
