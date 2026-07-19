import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../models/resume_model.dart';

class ResumeGeneratorRepository {
  final Dio dio = ApiClient().dio;

  /// Fetch resume data from backend
  Future<ResumeModel> generateResume() async {
    final response = await dio.get('/resume');

    return ResumeModel.fromJson(response.data);
  }

  /// Download generated PDF
  Future<Response<List<int>>> downloadResume() async {
    return await dio.get<List<int>>(
      '/resume/pdf',
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );
  }
}