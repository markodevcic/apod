// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_by_month_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ImageByMonthModel _$ImageByMonthModelFromJson(Map<String, dynamic> json) {
  return _ImageByMonthModel.fromJson(json);
}

/// @nodoc
mixin _$ImageByMonthModel {
  ImagesDateRange get dateRange => throw _privateConstructorUsedError;
  List<ImageResponse> get images => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ImageByMonthModelCopyWith<ImageByMonthModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageByMonthModelCopyWith<$Res> {
  factory $ImageByMonthModelCopyWith(
          ImageByMonthModel value, $Res Function(ImageByMonthModel) then) =
      _$ImageByMonthModelCopyWithImpl<$Res, ImageByMonthModel>;
  @useResult
  $Res call({ImagesDateRange dateRange, List<ImageResponse> images});

  $ImagesDateRangeCopyWith<$Res> get dateRange;
}

/// @nodoc
class _$ImageByMonthModelCopyWithImpl<$Res, $Val extends ImageByMonthModel>
    implements $ImageByMonthModelCopyWith<$Res> {
  _$ImageByMonthModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateRange = null,
    Object? images = null,
  }) {
    return _then(_value.copyWith(
      dateRange: null == dateRange
          ? _value.dateRange
          : dateRange // ignore: cast_nullable_to_non_nullable
              as ImagesDateRange,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<ImageResponse>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ImagesDateRangeCopyWith<$Res> get dateRange {
    return $ImagesDateRangeCopyWith<$Res>(_value.dateRange, (value) {
      return _then(_value.copyWith(dateRange: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ImageByMonthModelImplCopyWith<$Res>
    implements $ImageByMonthModelCopyWith<$Res> {
  factory _$$ImageByMonthModelImplCopyWith(_$ImageByMonthModelImpl value,
          $Res Function(_$ImageByMonthModelImpl) then) =
      __$$ImageByMonthModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ImagesDateRange dateRange, List<ImageResponse> images});

  @override
  $ImagesDateRangeCopyWith<$Res> get dateRange;
}

/// @nodoc
class __$$ImageByMonthModelImplCopyWithImpl<$Res>
    extends _$ImageByMonthModelCopyWithImpl<$Res, _$ImageByMonthModelImpl>
    implements _$$ImageByMonthModelImplCopyWith<$Res> {
  __$$ImageByMonthModelImplCopyWithImpl(_$ImageByMonthModelImpl _value,
      $Res Function(_$ImageByMonthModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateRange = null,
    Object? images = null,
  }) {
    return _then(_$ImageByMonthModelImpl(
      dateRange: null == dateRange
          ? _value.dateRange
          : dateRange // ignore: cast_nullable_to_non_nullable
              as ImagesDateRange,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<ImageResponse>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageByMonthModelImpl
    with DiagnosticableTreeMixin
    implements _ImageByMonthModel {
  const _$ImageByMonthModelImpl(
      {required this.dateRange, required final List<ImageResponse> images})
      : _images = images;

  factory _$ImageByMonthModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageByMonthModelImplFromJson(json);

  @override
  final ImagesDateRange dateRange;
  final List<ImageResponse> _images;
  @override
  List<ImageResponse> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ImageByMonthModel(dateRange: $dateRange, images: $images)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ImageByMonthModel'))
      ..add(DiagnosticsProperty('dateRange', dateRange))
      ..add(DiagnosticsProperty('images', images));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageByMonthModelImpl &&
            (identical(other.dateRange, dateRange) ||
                other.dateRange == dateRange) &&
            const DeepCollectionEquality().equals(other._images, _images));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, dateRange, const DeepCollectionEquality().hash(_images));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageByMonthModelImplCopyWith<_$ImageByMonthModelImpl> get copyWith =>
      __$$ImageByMonthModelImplCopyWithImpl<_$ImageByMonthModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageByMonthModelImplToJson(
      this,
    );
  }
}

abstract class _ImageByMonthModel implements ImageByMonthModel {
  const factory _ImageByMonthModel(
      {required final ImagesDateRange dateRange,
      required final List<ImageResponse> images}) = _$ImageByMonthModelImpl;

  factory _ImageByMonthModel.fromJson(Map<String, dynamic> json) =
      _$ImageByMonthModelImpl.fromJson;

  @override
  ImagesDateRange get dateRange;
  @override
  List<ImageResponse> get images;
  @override
  @JsonKey(ignore: true)
  _$$ImageByMonthModelImplCopyWith<_$ImageByMonthModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ImagesDateRange _$ImagesDateRangeFromJson(Map<String, dynamic> json) {
  return _ImagesDateRange.fromJson(json);
}

/// @nodoc
mixin _$ImagesDateRange {
  String get startDate => throw _privateConstructorUsedError;
  String get endDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ImagesDateRangeCopyWith<ImagesDateRange> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImagesDateRangeCopyWith<$Res> {
  factory $ImagesDateRangeCopyWith(
          ImagesDateRange value, $Res Function(ImagesDateRange) then) =
      _$ImagesDateRangeCopyWithImpl<$Res, ImagesDateRange>;
  @useResult
  $Res call({String startDate, String endDate});
}

/// @nodoc
class _$ImagesDateRangeCopyWithImpl<$Res, $Val extends ImagesDateRange>
    implements $ImagesDateRangeCopyWith<$Res> {
  _$ImagesDateRangeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(_value.copyWith(
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImagesDateRangeImplCopyWith<$Res>
    implements $ImagesDateRangeCopyWith<$Res> {
  factory _$$ImagesDateRangeImplCopyWith(_$ImagesDateRangeImpl value,
          $Res Function(_$ImagesDateRangeImpl) then) =
      __$$ImagesDateRangeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String startDate, String endDate});
}

/// @nodoc
class __$$ImagesDateRangeImplCopyWithImpl<$Res>
    extends _$ImagesDateRangeCopyWithImpl<$Res, _$ImagesDateRangeImpl>
    implements _$$ImagesDateRangeImplCopyWith<$Res> {
  __$$ImagesDateRangeImplCopyWithImpl(
      _$ImagesDateRangeImpl _value, $Res Function(_$ImagesDateRangeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(_$ImagesDateRangeImpl(
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImagesDateRangeImpl
    with DiagnosticableTreeMixin
    implements _ImagesDateRange {
  const _$ImagesDateRangeImpl({required this.startDate, required this.endDate});

  factory _$ImagesDateRangeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImagesDateRangeImplFromJson(json);

  @override
  final String startDate;
  @override
  final String endDate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ImagesDateRange(startDate: $startDate, endDate: $endDate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ImagesDateRange'))
      ..add(DiagnosticsProperty('startDate', startDate))
      ..add(DiagnosticsProperty('endDate', endDate));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImagesDateRangeImpl &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, startDate, endDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImagesDateRangeImplCopyWith<_$ImagesDateRangeImpl> get copyWith =>
      __$$ImagesDateRangeImplCopyWithImpl<_$ImagesDateRangeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImagesDateRangeImplToJson(
      this,
    );
  }
}

abstract class _ImagesDateRange implements ImagesDateRange {
  const factory _ImagesDateRange(
      {required final String startDate,
      required final String endDate}) = _$ImagesDateRangeImpl;

  factory _ImagesDateRange.fromJson(Map<String, dynamic> json) =
      _$ImagesDateRangeImpl.fromJson;

  @override
  String get startDate;
  @override
  String get endDate;
  @override
  @JsonKey(ignore: true)
  _$$ImagesDateRangeImplCopyWith<_$ImagesDateRangeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
