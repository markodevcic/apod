// ignore_for_file: constant_identifier_names, avoid_manual_providers_as_generated_provider_dependency

import 'dart:developer';
import 'dart:io';

import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:apod/constants/env_variable.dart';
import 'package:apod/models/api_response.dart';
import 'package:apod/services/network/method_enum.dart';

class DioClient {
  DioClient._internal();
  static final dioClient = DioClient._internal();
  factory DioClient() => dioClient;

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: dotenv.get(EnvVariable.baseUrl),
      connectTimeout: const Duration(seconds: 10),
      contentType: 'application/json; charset=utf-8',
    ),
  )
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },

        // 401 error handling
        onError: (error, handler) {
          if (error.response?.statusCode == 401) {
            log('401 error', error: error);

            // ref.read(authProvider.notifier).logout();

            error.requestOptions.headers.remove('X-API-KEY');
          }

          return handler.next(error);
        },
      ),
    )
    ..interceptors.addAll(
      {
        if (kDebugMode)
          CurlLoggerDioInterceptor(
            printOnSuccess: true,
          ),
      },
    );

  static Future<ApiResponse> apiCall({
    required String path,
    Method method = Method.GET,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    CancelToken? cancelToken,
    String contentType = 'application/json; charset=utf-8',
  }) async {
    final options = Options(
      method: method.name,
      headers: {
        'Content-Type': contentType,
      },
    );

    try {
      final response = await dioClient._dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return ApiResponse.success(response.data);
    } on DioException catch (e) {
      debugPrint('++++++++++ EXCEPTION ++++++++++');

      final err = e.response?.data is String
          ? e.response?.data
          : e.response?.data['errorMessage'];

      debugPrint(err);

      if (err != null) {
        log('Error: $err');
      }

      return ApiResponse.error(e.message ?? 'Something went wrong');
    } on SocketException {
      return ApiResponse.error(
        'No internet connection',
      );
    } on Exception catch (e) {
      return ApiResponse.error(
        e.toString(),
      );
    }
  }
}
