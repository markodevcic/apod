import 'package:apod/shared/models/image_response.dart';

class BaseImageResponse {
  List<ImageResponse> imageList;

  BaseImageResponse({required this.imageList});

  factory BaseImageResponse.fromMap(List data) {
    return BaseImageResponse(
      imageList: data.map((e) => ImageResponse.fromMap(e)).toList(),
    );
  }
}
