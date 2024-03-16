import 'package:apod/models/image_response/image_response.dart';

class BaseImageResponse {
  List<ImageResponse> imageList;

  BaseImageResponse({required this.imageList});

  factory BaseImageResponse.fromJson(List data) {
    return BaseImageResponse(
      imageList: data.map((e) => ImageResponse.fromMap(e)).toList(),
    );
  }
}
