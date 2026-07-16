import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../models/education_model.dart';

class EducationRepository {
  final Dio dio = ApiClient().dio;

  Future<List<EducationModel>> getEducations() async {
    final response = await dio.get('/education');

    final List data = response.data["data"] ?? [];

    return data
        .map(
          (e) => EducationModel.fromJson(e),
        )
        .toList();
  }

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

  Future<void> deleteEducation(
    int id,
  ) async {
    await dio.delete(
      "/education/$id",
    );
  }
}