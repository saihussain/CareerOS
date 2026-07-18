import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../models/project_model.dart';

class ProjectRepository {
  final Dio dio = ApiClient().dio;

  /// Get all projects
  Future<List<ProjectModel>> getProjects() async {
    final response = await dio.get(
      "/projects",
    );

    final List data =
        response.data["projects"] ?? [];

    return data
        .map(
          (e) => ProjectModel.fromJson(e),
        )
        .toList();
  }

  /// Add project
  Future<void> addProject({
    required String title,
    required String description,
    required String techStack,
    String? githubUrl,
    String? liveUrl,
    required String startDate,
    required String status,
  }) async {
    await dio.post(
      "/projects",
      data: {
        "title": title,
        "description": description,
        "tech_stack": techStack,
        "github_url": githubUrl,
        "live_url": liveUrl,
        "start_date": startDate,
        "status": status,
      },
    );
  }

  /// Update project
  Future<void> updateProject({
    required int id,
    required String title,
    required String description,
    required String techStack,
    String? githubUrl,
    String? liveUrl,
    required String startDate,
    required String status,
  }) async {
    await dio.put(
      "/projects/$id",
      data: {
        "title": title,
        "description": description,
        "tech_stack": techStack,
        "github_url": githubUrl,
        "live_url": liveUrl,
        "start_date": startDate,
        "status": status,
      },
    );
  }

  /// Delete project
  Future<void> deleteProject(
    int id,
  ) async {
    await dio.delete(
      "/projects/$id",
    );
  }
}