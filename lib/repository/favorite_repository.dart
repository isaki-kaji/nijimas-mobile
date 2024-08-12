import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:nijimas/core/constant/env_constant.dart';
import 'package:nijimas/core/util/auth_interceptor.dart';
import 'package:nijimas/core/request/toggle_favorite_request.dart';
import 'package:nijimas/repository/abstract_favorite_repository.dart';

class FavoriteRepository extends AbstractFavoriteRepository {
  final Dio _dio;
  final Logger _logger;
  FavoriteRepository({required Logger logger})
      : _dio = Dio(),
        _logger = logger {
    _dio.interceptors.add(AuthInterceptor());
  }

  @override
  Future<void> toggleFavorite(ToggleFavoriteRequest request) async {
    final response =
        await _dio.post("${Env.baseUrl}/favorites", data: request.toJson());
    if (response.statusCode == 201 || response.statusCode == 204) {
      return;
    }
    _logger.e(response.data);
    throw Exception(
        "Failed to toggle favorite with status code: ${response.statusCode}");
  }
}
