import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../models/achievement_model.dart';

class AchievementRepository {
  final Dio dio = ApiClient().dio;

  Future<List<AchievementModel>>
      getAchievements() async {
    final response =
        await dio.get("/achievements");

    final List data =
        response.data["achievements"] ?? [];

    return data
        .map(
          (e) =>
              AchievementModel.fromJson(e),
        )
        .toList();
  }

  Future<void> addAchievement({
    required String title,
    required String organization,
    required String achievementType,
    required String description,
    String? achievementDate,
  }) async {
    await dio.post(
      "/achievements",
      data: {
        "title": title,
        "organization": organization,
        "achievement_type":
            achievementType,
        "description": description,
        "achievement_date":
            achievementDate,
      },
    );
  }

  Future<void> deleteAchievement(
    int id,
  ) async {
    await dio.delete(
      "/achievements/$id",
    );
  }
}