// ignore_for_file: invalid_annotation_target

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_response.freezed.dart';
part 'image_response.g.dart';

@freezed
class ImageResponse with _$ImageResponse {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ImageResponse({
    required String? copyright,
    required String? date,
    required String? explanation,
    required String? hdurl,
    required String? mediaType,
    required String? serviceVersion,
    required String? title,
    required String? url,
    required String? thumbnailUrl,
  }) = _ImageResponse;

  factory ImageResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageResponseFromJson(json);
}
