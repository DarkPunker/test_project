import 'package:dio/dio.dart';
import 'package:test_project/env.dart';
import 'package:test_project/services/base_service.dart';
import 'package:test_project/share_preferences/preferences.dart';

class TiendaService extends BaseService{
  TiendaService() : super(baseUrl: Preferences.uri);

  Future<Response?> getallProductStores() async {
    try {
      return await get(
        '${Environment.API_PREFIX_STORE}/get_all_store_product', 
        timeout: const Duration(seconds: 10)
      );
    } catch (e) {
      print(e);
    }
    return null;
  }
}