class BaseResponse {
  int? statusCode;
  String? error;

  BaseResponse({this.statusCode, this.error});

  factory BaseResponse.fromMap(Map<String, dynamic> data) => BaseResponse(
        statusCode: data['statusCode'] as int?,
        error: data['error'] as String?,
      );
}
