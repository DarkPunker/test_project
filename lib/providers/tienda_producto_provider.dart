import 'package:flutter/material.dart';
import 'package:test_project/services/tienda_service.dart';

class TiendaProductoProvider extends ChangeNotifier{
  final TiendaService _tiendaService = TiendaService();

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

  Future<void> downloadStores () async {
    _isLoading = true;
    notifyListeners();
  try {
      var resp = await _tiendaService.getallProductStores();

      if (resp == null) {
      } else if (resp.statusCode == 200) {

        
      } else if (resp.statusCode == 401) {
        throw Exception(_messageError);
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print("Error login , $e");
    }
  }
}