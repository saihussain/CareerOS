import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../models/resume_analysis_model.dart';

class ResumeRepository {
  final ApiClient api = ApiClient();

  Future<ResumeAnalysisModel> analyzeResume({
    required File resume,
    required String targetRole,
  }) async {
    FormData formData = FormData.fromMap({
      "resume": await MultipartFile.fromFile(
        resume.path,
        filename: resume.path.split('/').last,
      ),
      "target_role": targetRole,
    });

    final response = await api.dio.post(
      "/core/analyze",
      data: formData,
      options: Options(
        contentType: "multipart/form-data",
      ),
    );

    return ResumeAnalysisModel.fromJson(
      response.data,
    );
  }
}