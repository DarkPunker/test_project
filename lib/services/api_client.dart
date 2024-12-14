import 'package:dio/dio.dart';
import 'package:test_project/share_preferences/preferences.dart';

class ApiClient {
  static const int connectTimeout = 5;
  // static const int receiveTimeout = 5;
  static const int retryAttempts = 3;

  late final Dio _dio;
  final String baseUrl;

  ApiClient({required this.baseUrl}) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: connectTimeout),
      contentType: 'application/json',
    ))
      ..interceptors.addAll([
        _authInterceptor(),
        _errorInterceptor(),
        _loggingInterceptor(),
      ]);
  }

  // Auth Interceptor
  Interceptor _authInterceptor() => InterceptorsWrapper(
        onRequest: (options, handler) async {
          final requiresAuth = options.extra['requiresAuth'] ?? true;

          if (requiresAuth) {
            final token = _getToken();

            if (token.isEmpty) {
              return handler.reject(
                DioException(
                  requestOptions: options,
                  message: 'Token required but not provided',
                ),
              );
            }
            options.headers['Authorization'] = token;
          }

          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            await _handleLogout();
            return handler.next(error);
          }
          return handler.next(error);
        },
      );

  // Error Handling Interceptor
  Interceptor _errorInterceptor() =>
      InterceptorsWrapper(onError: (error, handler) {
        final statusCode = error.response?.statusCode;
        final responseData = error.response?.data;

        switch (statusCode) {
          case 400:
            throw Exception(responseData.toString());
          case 401:
            throw Exception(responseData.toString());
          case 403:
            throw Exception(responseData.toString());
          case 404:
            throw Exception(responseData.toString());
          case 500:
            throw Exception(responseData.toString());
          default:
            throw Exception('Error occurred: $responseData');
        }
      });

  // Logging Interceptor
  Interceptor _loggingInterceptor() =>
      InterceptorsWrapper(onRequest: (options, handler) {
        return handler.next(options);
      }, onResponse: (response, handler) {
        return handler.next(response);
      }, onError: (error, handler) {
        return handler.next(error);
      });

  // Retry failed request
  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  String _getToken() {
    return Preferences.token;
  }

  Future<void> _refreshToken() async {
    throw Exception('Token refresh not implemented');
  }

  Future<void> _handleLogout() async {
    throw Exception('Logout not implemented');
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool requiresAuth = true,
    Duration? timeout,
  }) async {
    try {
      final opts = options ?? Options();
      opts.extra ??= {};
      opts.extra!['requiresAuth'] = requiresAuth;

      if (timeout != null) _dio.options.connectTimeout = timeout;

      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: opts,
        cancelToken: cancelToken,
      );
    } catch (e) {
      rethrow;
    } finally {
      _dio.options.connectTimeout = const Duration(seconds: connectTimeout);
    }
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
    try {
      final opts = options ?? Options();
      opts.extra ??= {};
      opts.extra!['requiresAuth'] = requiresAuth;

      if (timeout != null) _dio.options.connectTimeout = timeout;

      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: opts,
        cancelToken: cancelToken,
      );
    } catch (e) {
      rethrow;
    } finally {
      _dio.options.connectTimeout = const Duration(seconds: connectTimeout);
    }
  }

  // Add other methods (put, delete, etc.) as needed
}
