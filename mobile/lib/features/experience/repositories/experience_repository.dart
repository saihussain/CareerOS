import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../models/experience_model.dart';

class ExperienceRepository {
  final Dio dio = ApiClient().dio;

  /// Get all experiences
  Future<List<ExperienceModel>> getExperiences() async {
    final response = await dio.get(
      '/experience',
    );

    final List data =
        response.data["experiences"] ?? [];

    return data
        .map(
          (e) => ExperienceModel.fromJson(e),
        )
        .toList();
  }

  /// Add experience
  Future<void> addExperience({
    required String companyName,
    required String jobTitle,
    required String employmentType,
    required String location,
    required String startDate,
    String? endDate,
    required bool currentlyWorking,
    required String description,
  }) async {
    await dio.post(
      "/experience",
      data: {
        "company_name": companyName,
        "job_title": jobTitle,
        "employment_type": employmentType,
        "location": location,
        "start_date": startDate,
        "end_date": endDate,
        "currently_working": currentlyWorking,
        "description": description,
      },
    );
  }

  /// Update experience
  Future<void> updateExperience({
    required int id,
    required String companyName,
    required String jobTitle,
    required String employmentType,
    required String location,
    required String startDate,
    String? endDate,
    required bool currentlyWorking,
    required String description,
  }) async {
    await dio.put(
      "/experience/$id",
      data: {
        "company_name": companyName,
        "job_title": jobTitle,
        "employment_type": employmentType,
        "location": location,
        "start_date": startDate,
        "end_date": endDate,
        "currently_working": currentlyWorking,
        "description": description,
      },
    );
  }

  /// Delete experience
  Future<void> deleteExperience(
    int id,
  ) async {
    await dio.delete(
      "/experience/$id",
    );
  }
}