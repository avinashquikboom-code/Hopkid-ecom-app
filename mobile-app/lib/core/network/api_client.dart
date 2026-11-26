import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/app_constants.dart';
import '../errors/failures.dart';

class ApiClient {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage;

  ApiClient({
    Dio? dio,
    FlutterSecureStorage? secureStorage,
  })  : _secureStorage = secureStorage ?? const FlutterSecureStorage(),
        _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: AppConstants.apiBaseUrl,
                connectTimeout: AppConstants.apiTimeout,
                receiveTimeout: AppConstants.apiTimeout,
                headers: {'Content-Type': 'application/json'},
              ),
            ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _secureStorage.read(key: AppConstants.tokenStorageKey);
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) {
          handler.next(error);
        },
      ),
    );
  }

  bool get isConfigured => AppConstants.apiBaseUrl.isNotEmpty;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get<T>(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
  }) async {
    try {
      return await _dio.post<T>(path, data: data);
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  Failure _mapDioError(DioException e) {
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout) {
      return const NetworkFailure();
    }
    final status = e.response?.statusCode;
    if (status == 401) {
      return const AuthFailure();
    }
    return ServerFailure(
      e.response?.statusMessage ?? 'Something went wrong. Please try again.',
      statusCode: status,
    );
  }
}
