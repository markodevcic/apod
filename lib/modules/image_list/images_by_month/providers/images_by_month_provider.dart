import 'package:apod/modules/image_list/images_by_month/providers/images_date_provider.dart';
import 'package:apod/modules/image_list/images_by_month/utils/images_by_month_provider_helper.dart';
import 'package:apod/services/network/dio_client.dart';
import 'package:apod/shared/models/image_response.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'images_by_month_provider.g.dart';

@riverpod
class ImagesByMonth extends _$ImagesByMonth {
  @override
  Future<List<ImageResponse>?> build() async => await get();

  CancelToken cancelToken = CancelToken();

  Future<List<ImageResponse>?> get() async {
    state = const AsyncValue.loading();

    final (startDate, endDate) = ImagesByMonthProviderHelper.setStarAndEndDate(
        ref.read(imagesDateProvider));

    cancelToken.cancel();
    cancelToken = CancelToken();

    final dio = ref.read(dioClientProvider.notifier);

    try {
      final response = await dio.apiCall(
        queryParameters: {
          'start_date': startDate,
          'end_date': endDate,
        },
        cancelToken: cancelToken,
      );

      return response.data
          .map<ImageResponse>((image) => ImageResponse.fromJson(image))
          .toList()
          .reversed
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }
}
