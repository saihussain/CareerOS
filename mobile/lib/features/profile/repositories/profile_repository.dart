import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../models/profile_model.dart';

class ProfileRepository {
  final Dio dio = ApiClient().dio;

  Future<ProfileModel> getProfile() async {
    final response = await dio.get('/profile');

    return ProfileModel.fromJson(
      response.data['profile'],
    );
  }

  Future<void> updateProfile({
    required String fullName,
    required String mobileNumber,
    required String dateOfBirth,
    required String gender,
    required String aboutMe,
    required String linkedinUrl,
    required String githubUrl,
  }) async {
    await dio.put(
      '/profile',
      data: {
        "full_name": fullName,
        "mobile_number": mobileNumber,
        "date_of_birth": dateOfBirth,
        "gender": gender,
        "about_me": aboutMe,
        "linkedin_url": linkedinUrl,
        "github_url": githubUrl,
      },
    );
  }
}