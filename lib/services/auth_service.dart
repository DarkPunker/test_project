import 'package:dio/dio.dart';
import 'package:test_project/env.dart';
import 'package:test_project/services/base_service.dart';
import 'package:test_project/share_preferences/preferences.dart';

class AuthService extends BaseService {
    AuthService() : super(baseUrl: Preferences.uri);

    Future<Response?> login(String email, String contrasena) async {
    try {
      return await post(
        '${Environment.API_PREFIX_AUTH}/login',
        data: {"email": email,"contrasena": contrasena},
        requiresAuth: false,
      );
    } catch (e) {
      print('AuthService:login ${e}');
      return null;
      // rethrow;
    }
  }
}

