import 'package:flutter/material.dart';
import 'package:test_project/database/boxes.dart';
import 'package:test_project/database/cliente.dart';
import 'package:test_project/database/tienda.dart';
import 'package:test_project/database/usuario.dart';
import 'package:test_project/services/auth_service.dart';
import 'package:test_project/share_preferences/preferences.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  String email = Preferences.email;
  String password = "";

  bool _isLoading = false;
  bool _isSaving = false;
  String _messageError = "";

  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  String get messageError => _messageError;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set isSaving(bool value) {
    _isSaving = value;
    notifyListeners();
  }

  set messageError(String value) {
    _messageError = value;
    notifyListeners();
  }

  Future<bool> login(String email, String contrasena) async {
    _isLoading = true;
    notifyListeners();
    bool onlinelogin = false;
    try {
      var resp = await _authService.login(email, contrasena);

      if (resp == null) {
        onlinelogin = false;
      } else if (resp.statusCode == 200) {
        onlinelogin = true;
        Map<String, dynamic> jsonResponse = resp.data;
        Usuario user =
            Usuario(email: jsonResponse['email'], contrasena: contrasena);
        Preferences.token = jsonResponse['token'];
        final cliente = Cliente(
          cc: jsonResponse['cliente']['cc'],
          nombre: jsonResponse['cliente']['nombre'],
          apellido: jsonResponse['cliente']['apellido'],
          direccion: jsonResponse['cliente']['direccion'],
          lat: jsonResponse['cliente']['lat'],
          long: jsonResponse['cliente']['long'],
        );
        
        if (jsonResponse['tienda'] != null && jsonResponse['tienda'].isNotEmpty) {
          final tienda = Tienda(
            id: jsonResponse['tienda']['id'],
            nombre: jsonResponse['tienda']['nombre'],
            redes: jsonResponse['tienda']['redes'],
            celular: jsonResponse['tienda']['celular'],
            direccion: jsonResponse['tienda']['direccion'],
            lat: jsonResponse['tienda']['lat'],
            long: jsonResponse['tienda']['long'],
          );
          await boxUsuario.put(user.email, user);
          await boxcliente.put(cliente.cc, cliente);
          await boxTienda.put(tienda.id, tienda);
        }
      } else if (resp.statusCode == 401) {
        throw Exception(_messageError);
      }
      
      _isLoading = false;
      notifyListeners();
      return onlinelogin;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print("Error login , $e");
      return false;
    }
  }
}
