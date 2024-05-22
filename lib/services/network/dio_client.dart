// ignore_for_file: constant_identifier_names, avoid_manual_providers_as_generated_provider_dependency

import 'dart:developer';
import 'dart:io';

import 'package:apod/services/network/utils/api_exception.dart';
import 'package:apod/services/network/utils/endpoints.dart';
import 'package:apod/utilities/constants/env_variable.dart';
import 'package:dio/dio.dart';
import 'package:log_tools/log_tools.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_client.g.dart';

@riverpod
class DioClient extends _$DioClient {
  @override
  Dio build() => _dio;

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Endpoint.baseUrl,
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

            error.requestOptions.headers.remove('X-API-KEY');
          }

          return handler.next(error);
        },
      ),
    )
    ..interceptors.addAll(
      {
        LogToolsDioInterceptor(),
      },
    );

  Future<Response> apiCall(
      {Map<String, dynamic>? queryParameters, CancelToken? cancelToken}) async {
    try {
      final response = await _dio.request(
        '',
        queryParameters: {
          'api_key': EnvVariable.apiKey,
          'thumbs': true,
          if (queryParameters != null) ...queryParameters,
        },
        options: Options(
          method: 'GET',
        ),
        cancelToken: cancelToken,
      );

      return response;
    } on DioException catch (e) {
      log('++++++++++ DIO EXCEPTION ++++++++++');

      final String err = ApiException.fromDioError(e);

      log(err);

      throw err;
    } on SocketException {
      throw ApiException.fromSocketException();
    } on Exception catch (e) {
      throw e.toString();
    }
  }
}
