import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../models/interview_result.dart';
import '../models/interview_session_model.dart';

class InterviewRepository {
  final Dio dio = ApiClient().dio;

  Future<InterviewSessionModel> startInterview({
    required String role,
    required String type,
    required String difficulty,
  }) async {
    final response = await dio.post(
      "/interview/start",
      data: {
        "target_role": role,
        "interview_type": type,
        "difficulty": difficulty,
      },
    );

    return InterviewSessionModel.fromJson(
      response.data["data"],
    );
  }

  Future<InterviewResultModel> submitAnswer({
    required int sessionId,
    required int questionNumber,
    required String answer,
  }) async {
    final response = await dio.post(
      "/interview/answer",
      data: {
        "session_id": sessionId,
        "question_number": questionNumber,
        "answer": answer,
      },
    );

    return InterviewResultModel.fromJson(
      response.data,
    );
  }
}