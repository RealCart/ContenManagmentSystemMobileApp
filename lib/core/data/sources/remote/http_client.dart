import 'package:dio/dio.dart';
import 'package:instai/core/constants/app_api.dart';
import 'package:instai/core/data/sources/locale/token_storage.dart';
import 'package:instai/core/utils/failure.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HttpClient {
  final Dio _dio;
  final TokenStorage _tokenStorage;

  HttpClient({required TokenStorage tokentStorage})
    : _tokenStorage = tokentStorage,
      _dio = Dio(
        BaseOptions(
          baseUrl: AppApi.baseUrl,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      ) {
    _dio.interceptors.addAll([
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
      InterceptorsWrapper(
        onError: (error, handler) {
          handler.reject(error.copyWith(error: dioErrorWrapper(error)));
        },
      ),
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final String? token = await _tokenStorage.getToken();
          if (token != null) {
            options.headers['Authorization'] = "Bearer $token";
          }

          return handler.next(options);
        },
      ),
    ]);
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
