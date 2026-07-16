import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../models/skill_model.dart';

class SkillRepository {
  final Dio dio = ApiClient().dio;

  Future<List<SkillModel>> getSkills() async {
    final response = await dio.get('/skills');

    final List data =
        response.data["skills"] ?? [];

    return data
        .map(
          (e) => SkillModel.fromJson(e),
        )
        .toList();
  }

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

  Future<void> deleteSkill(
    int id,
  ) async {
    await dio.delete(
      "/skills/$id",
    );
  }
}