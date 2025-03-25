import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/web.dart';
import 'package:nijimas/core/constant/env_constants.dart';
import 'package:nijimas/core/model/sub_category.dart';
import 'package:nijimas/repository/interceptor/auth_interceptor.dart';

class SubCategoryRepository {
  final Dio _dio;
  final Logger _logger;
  SubCategoryRepository({required Logger logger})
      : _dio = Dio(),
        _logger = logger {
    _dio.interceptors.add(AuthInterceptor());
  }

  Future<List<SubCategory>> getUserUsedSubCategories() async {
    final response = await _dio.get("${Env.baseUrl}/me/sub-categories");
    if (response.statusCode == HttpStatus.ok) {
      return (response.data as List)
          .map((e) => SubCategory.fromJson(e))
          .toList();
    }
    _logger.e(response.data);
    throw Exception(
        "Failed to get sub category with status code: ${response.statusCode}");
  }
}
