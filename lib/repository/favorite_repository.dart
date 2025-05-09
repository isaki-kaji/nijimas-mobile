import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:nijimas/core/constant/env_constants.dart';
import 'package:nijimas/repository/interceptor/auth_interceptor.dart';
import 'package:nijimas/core/request/toggle_favorite_request.dart';

class FavoriteRepository {
  final Dio _dio;
  final Logger _logger;
  FavoriteRepository({required Logger logger})
      : _dio = Dio(),
        _logger = logger {
    _dio.interceptors.add(AuthInterceptor());
  }

  Future<bool> toggleFavorite(ToggleFavoriteRequest request) async {
    final response =
        await _dio.post("${Env.baseUrl}/favorites", data: request.toJson());

    if (response.statusCode == HttpStatus.created) {
      return true;
    }
    if (response.statusCode == HttpStatus.noContent) {
      return false;
    }

    _logger.e(response.data);
    throw Exception(
        "Failed to toggle favorite with status code: ${response.statusCode}");
  }
}
