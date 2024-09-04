import 'package:dio/dio.dart';
import 'package:logger/web.dart';
import 'package:nijimas/core/constant/env_constant.dart';
import 'package:nijimas/core/model/monthly_summary_presentation.dart';
import 'package:nijimas/core/util/auth_interceptor.dart';
import 'package:nijimas/repository/abstract_summary_repository.dart';

class SummaryRepository extends AbstractSummaryRepository {
  final Dio _dio;
  final Logger _logger;
  SummaryRepository({required Logger logger})
      : _dio = Dio(),
        _logger = logger {
    _dio.interceptors.add(AuthInterceptor());
  }

  @override
  Future<MonthlySummaryPresentation> getMonthlySummary(
      {required String year, required String month}) async {
    try {
      final response =
          await _dio.get("${Env.baseUrl}/me/summaries/$year/$month");
      if (response.statusCode == 200) {
        print("リクエストされました");
        return MonthlySummaryPresentation.fromJson(response.data);
      } else {
        _logger.e("Error response: ${response.data}");
        throw Exception(
            "Failed to get monthly summary with status code: ${response.statusCode}");
      }
    } catch (e) {
      _logger.e("Exception: $e");
      throw Exception("Failed to get monthly summary: $e");
    }
  }
}
