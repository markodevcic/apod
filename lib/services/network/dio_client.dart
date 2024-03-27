// ignore_for_file: constant_identifier_names, avoid_manual_providers_as_generated_provider_dependency

import 'dart:developer';
import 'dart:io';

import 'package:apod/constants/env_variable.dart';
import 'package:apod/models/api_response.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  DioClient._internal();
  static final dioClient = DioClient._internal();
  factory DioClient() => dioClient;

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.nasa.gov/planetary/apod',
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
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await dioClient._dio.request(
        '',
        queryParameters: {
          'api_key': EnvVariable.apiKey,
          'thumbs': true,
          if (queryParameters != null) ...queryParameters,
        },
        options: Options(
          method: 'GET',
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
          },
        ),
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
