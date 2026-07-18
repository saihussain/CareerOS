import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../models/analytics_model.dart';

class AnalyticsRepository {
  final Dio dio = ApiClient().dio;

  Future<AnalyticsModel> getAnalytics() async {
    final response = await dio.get(
      "/analytics",
    );

    return AnalyticsModel.fromJson(
      response.data["data"],
    );
  }
}