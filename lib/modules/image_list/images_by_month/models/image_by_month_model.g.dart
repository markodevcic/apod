// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_by_month_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ImageByMonthModelImpl _$$ImageByMonthModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ImageByMonthModelImpl(
      dateRange:
          ImagesDateRange.fromJson(json['dateRange'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>)
          .map((e) => ImageResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ImageByMonthModelImplToJson(
        _$ImageByMonthModelImpl instance) =>
    <String, dynamic>{
      'dateRange': instance.dateRange,
      'images': instance.images,
    };

_$ImagesDateRangeImpl _$$ImagesDateRangeImplFromJson(
        Map<String, dynamic> json) =>
    _$ImagesDateRangeImpl(
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
    );

Map<String, dynamic> _$$ImagesDateRangeImplToJson(
        _$ImagesDateRangeImpl instance) =>
    <String, dynamic>{
      'startDate': instance.startDate,
      'endDate': instance.endDate,
    };
