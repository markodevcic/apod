import 'package:dio/dio.dart';

class ApiException {
  static String fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        return 'Request to the server was cancelled';

      case DioExceptionType.receiveTimeout:
        return 'Receiving timeout occurred';

      case DioExceptionType.sendTimeout:
        return 'Request send timeout';

      case DioExceptionType.badResponse:
        return _handleStatusCode(dioError.response?.statusCode);

      case DioExceptionType.badCertificate:
        if (dioError.message!.contains('SocketException')) {
          return 'No Internet';
        }
        return 'Unexpected error occurred';

      default:
        return 'Something went wrong';
    }
  }

  static String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Authentication failed';
      case 403:
        return 'The authenticated user is not allowed to access the specified API endpoint';
      case 404:
        return 'The requested resource does not exist';
      case 405:
        return 'Method not allowed. Please check the Allow header for the allowed HTTP methods';
      case 415:
        return 'Unsupported media type. The requested content type or version number is invalid';
      case 422:
        return 'Data validation failed';
      case 429:
        return 'Too many requests';
      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong!';
    }
  }

  static String fromSocketException() {
    return 'No internet connection';
  }
}
