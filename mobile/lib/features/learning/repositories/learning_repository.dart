import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../models/learning_model.dart';

class LearningRepository {
  final Dio dio = ApiClient().dio;

  Future<LearningModel> generateRoadmap({
    required File resume,
    required String targetRole,
  }) async {
    FormData formData = FormData.fromMap({
      "resume": await MultipartFile.fromFile(
        resume.path,
        filename: resume.path.split("/").last,
      ),
      "target_role": targetRole,
    });

    final response = await dio.post(
      "/learning/recommendations",
      data: formData,
      options: Options(
        contentType: "multipart/form-data",
      ),
    );

    return LearningModel.fromJson(
      response.data["data"],
    );
  }
}