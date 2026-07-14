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
        throw Exception(
          e.response!.data["message"],
        );
      }

      throw Exception(
        "Unable to connect to server.",
      );
    }
  }
}