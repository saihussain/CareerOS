import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../models/skill_model.dart';

class SkillRepository {
  final Dio dio = ApiClient().dio;

  /// Get all skills
  Future<List<SkillModel>> getSkills() async {
    final response = await dio.get(
      "/skills",
    );

    final List data =
        response.data["skills"] ?? [];

    return data
        .map(
          (e) => SkillModel.fromJson(e),
        )
        .toList();
  }

  /// Add skill
  Future<void> addSkill({
    required String skillName,
    required String proficiency,
    required int yearsOfExperience,
  }) async {
    await dio.post(
      "/skills",
      data: {
        "skill_name": skillName,
        "proficiency": proficiency,
        "years_of_experience":
            yearsOfExperience,
      },
    );
  }

  /// Update skill
  Future<void> updateSkill({
    required int id,
    required String skillName,
    required String proficiency,
    required int yearsOfExperience,
  }) async {
    await dio.put(
      "/skills/$id",
      data: {
        "skill_name": skillName,
        "proficiency": proficiency,
        "years_of_experience":
            yearsOfExperience,
      },
    );
  }

  /// Delete skill
  Future<void> deleteSkill(
    int id,
  ) async {
    await dio.delete(
      "/skills/$id",
    );
  }
}