import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static bool _isDarkmode = false;

  static String _email = '';

  static String _token = '';

  static String _uri = 'http://192.168.0.101:8000';

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get uri {
    return _prefs.getString('uri') ?? _uri;
  }

  static set uri(String? uri) {
    _uri = uri ?? '';
    _prefs.setString('uri', uri ?? '');
  }

  static bool get isDarkmode {
    return _prefs.getBool('isDarkmode') ?? _isDarkmode;
  }

  static set isDarkmode(bool value) {
    _isDarkmode = value;
    _prefs.setBool('isDarkmode', value);
  }

  static String get token {
    return _prefs.getString('token') ?? _token;
  }

  static set token(String token) {
    _token = token;
    _prefs.setString('token', token);
  }

  static String get email {
    return _prefs.getString('email') ?? _email;
  }

  static set email(String email) {
    _email = email;
    _prefs.setString('email', email);
  }
}