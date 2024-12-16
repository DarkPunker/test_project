import 'package:test_project/share_preferences/preferences.dart';

class Environment {
  static var API_URL = Preferences.uri;
  static const API_PREFIX_AUTH = '/auth';
  static const API_PREFIX_STORE = '/tienda_producto';
  static const API_PREFIX_PRODUCT = '/productos';
  static const API_PREFIX_CATEGORIA = '/Categoria';
  static const API_PREFIX_STORES = '/tiendas';
  static const API_PREFIX_ODCOMPRA = '/orden_compra';
}