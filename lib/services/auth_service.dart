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
        data: {"email": email, "contrasena": contrasena},
        requiresAuth: false,
      );
    } catch (e) {
      print('AuthService:login ${e}');
      return null;
      // rethrow;
    }
  }

  Future<Response?> register(
      int cc,
      String email,
      String contrasena,
      String nombre,
      String apellido,
      String direccion,
      String lat,
      String long) async {
    try {
      return await post(
        '${Environment.API_PREFIX_AUTH}/register',
        data: {
          "cc": cc,
          "email": email,
          "contrasena": contrasena,
          "nombre": nombre,
          "apellido": apellido,
          "direccion": direccion,
          "lat": lat,
          "long": long
        },
        requiresAuth: false,
      );
    } catch (e) {
      print('AuthService:login ${e}');
      return null;
      // rethrow;
    }
  }
}
