import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String get baseUrl => dotenv.env['BASE_URL']!;

  static const login = '/login';
  static const register = '/register';
  static const logout = '/logout';
  static const profile = '/user';

  static const analyze = '/core/analyze';

  static const interview = '/interview/generate';

  static const learning = '/learning/recommendations';
}