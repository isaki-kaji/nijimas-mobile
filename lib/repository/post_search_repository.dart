import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/web.dart';
import 'package:nijimas/core/constant/env_constant.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/repository/interceptor/auth_interceptor.dart';
import 'package:nijimas/core/model/post.dart';

class PostSearchRepository {
  final Dio _dio;
  final Logger _logger;
  PostSearchRepository({required Logger logger})
      : _dio = Dio(),
        _logger = logger {
    _dio.interceptors.add(AuthInterceptor());
  }

  Future<List<Post>> getPostsByUid(Map<PostQueryKey, dynamic> params) async {
    try {
      final response = await _dio.get("${Env.baseUrl}/posts",
          queryParameters: {"uid": params[PostQueryKey.uid]});
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

  Future<List<Post>> getPostsByMainCategory(
      Map<PostQueryKey, dynamic> params) async {
    try {
      final response = await _dio.get("${Env.baseUrl}/posts", queryParameters: {
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

  Future<List<Post>> getPostsBySubCategory(
      Map<PostQueryKey, dynamic> params) async {
    try {
      final response = await _dio.get("${Env.baseUrl}/posts",
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

  Future<List<Post>> getPostsByMainCategoryAndSubCategory(
      Map<PostQueryKey, dynamic> params) async {
    try {
      final response = await _dio.get("${Env.baseUrl}/posts", queryParameters: {
        "main-category": params[PostQueryKey.mainCategory],
        "sub-category": params[PostQueryKey.subCategory]
      });
      if (response.statusCode == HttpStatus.ok) {
        List<Post> posts =
            (response.data as List).map((post) => Post.fromJson(post)).toList();
        return posts;
      } else {
        _logger.e("Error response: ${response.data}");
        throw Exception(
            "Failed to get posts by main category and sub category with status code: ${response.statusCode}");
      }
    } catch (e) {
      _logger.e("Exception: $e");
      throw Exception(
          "Failed to get posts by main category and sub category: $e");
    }
  }
}
