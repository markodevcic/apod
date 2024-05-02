// ignore_for_file: invalid_annotation_target

import 'package:apod/shared/models/image_response.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_by_month_model.freezed.dart';
part 'image_by_month_model.g.dart';

@freezed
class ImageByMonthModel with _$ImageByMonthModel {
  const factory ImageByMonthModel({
    required ImagesDateRange dateRange,
    required List<ImageResponse> images,
  }) = _ImageByMonthModel;

  factory ImageByMonthModel.fromJson(Map<String, dynamic> json) =>
      _$ImageByMonthModelFromJson(json);
}

@freezed
class ImagesDateRange with _$ImagesDateRange {
  const factory ImagesDateRange({
    required String startDate,
    required String endDate,
  }) = _ImagesDateRange;

  factory ImagesDateRange.fromJson(Map<String, dynamic> json) =>
      _$ImagesDateRangeFromJson(json);
}
