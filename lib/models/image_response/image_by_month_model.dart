import 'package:apod/models/image_response/image_response.dart';

class ImageByMonthModel {
  final ImagesDateRange dateRange;
  final List<ImageResponse> images;

  ImageByMonthModel({required this.dateRange, required this.images});

  factory ImageByMonthModel.fromMap(Map<String, dynamic> data) {
    return ImageByMonthModel(
      dateRange: ImagesDateRange.fromMap(data['dateRange']),
      images: data['images'].map((e) => ImageResponse.fromMap(e)).toList(),
    );
  }
}

class ImagesDateRange {
  final String startDate;
  final String endDate;

  ImagesDateRange({required this.startDate, required this.endDate});

  factory ImagesDateRange.fromMap(Map<String, dynamic> data) {
    return ImagesDateRange(
      startDate: data['startDate'] as String,
      endDate: data['endDate'] as String,
    );
  }
}
