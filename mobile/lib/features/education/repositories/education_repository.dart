import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../models/education_model.dart';

class EducationRepository {
  final Dio dio = ApiClient().dio;

  /// Get all educations
  Future<List<EducationModel>> getEducations() async {
    final response = await dio.get('/education');

    final List data =
        response.data["educations"] ?? [];

    return data
        .map(
          (e) => EducationModel.fromJson(e),
        )
        .toList();
  }

  /// Add education
  Future<void> addEducation({
    required String institutionName,
    required String degree,
    required String fieldOfStudy,
    required int startYear,
    int? endYear,
    double? cgpa,
    required bool currentlyStudying,
  }) async {
    await dio.post(
      '/education',
      data: {
        "institution_name": institutionName,
        "degree": degree,
        "field_of_study": fieldOfStudy,
        "start_year": startYear,
        "end_year": endYear,
        "cgpa": cgpa,
        "currently_studying":
            currentlyStudying,
      },
    );
  }

  /// Update education
  Future<void> updateEducation({
    required int id,
    required String institutionName,
    required String degree,
    required String fieldOfStudy,
    required int startYear,
    int? endYear,
    double? cgpa,
    required bool currentlyStudying,
  }) async {
    await dio.put(
      "/education/$id",
      data: {
        "institution_name": institutionName,
        "degree": degree,
        "field_of_study": fieldOfStudy,
        "start_year": startYear,
        "end_year": endYear,
        "cgpa": cgpa,
        "currently_studying":
            currentlyStudying,
      },
    );
  }

  /// Delete education
  Future<void> deleteEducation(
    int id,
  ) async {
    await dio.delete(
      "/education/$id",
    );
  }
}