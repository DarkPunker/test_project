import 'package:dio/dio.dart';
import 'package:test_project/services/api_client.dart';

class BaseService {
  late final ApiClient _apiClient;
  String _messageError = "";

  String get messageError => _messageError;
  set messageError(String value) => _messageError = value;

  BaseService({required String baseUrl}) {
    _apiClient = ApiClient(baseUrl: baseUrl);
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool requiresAuth = true,
    Duration? timeout,
  }) async {
    return _apiClient.get(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      requiresAuth: requiresAuth,
      timeout: timeout,
    );
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters, 
    Options? options,
    CancelToken? cancelToken,
    bool requiresAuth = true,
    Duration? timeout,
  }) async {
    return _apiClient.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      requiresAuth: requiresAuth,
      timeout: timeout,
    );
  }
}