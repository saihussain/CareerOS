import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

class AuthRepository {
  final ApiClient _api = ApiClient();

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _api.dio.post(
        "/login",
        data: request.toJson(),
      );

      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        final data = e.response!.data;

        if (data is Map<String, dynamic> &&
            data.containsKey("message")) {
          throw Exception(data["message"]);
        }

        throw Exception("Login failed.");
      }

      throw Exception("Unable to connect to server.");
    }
  }

  Future<void> logout() async {
    try {
      await _api.dio.post("/logout");
    } on DioException catch (_) {
      // Even if the backend logout fails,
      // we'll still clear the local session.
    }
  }
}