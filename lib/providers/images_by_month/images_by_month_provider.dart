import 'package:apod/models/image_response/base_image_response.dart';
import 'package:apod/models/image_response/image_response.dart';
import 'package:apod/providers/images_by_month/images_by_month_provider_helper.dart';
import 'package:apod/providers/images_date_provider.dart';
import 'package:apod/services/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getImagesByMonthProvider =
    FutureProvider<List<ImageResponse>?>((ref) async {
  final imagesByMonth = ref.watch(imagesByMonthProvider.notifier);

  return await imagesByMonth.get();
});

final imagesByMonthProvider =
    StateNotifierProvider<ImagesByMonthNotifier, List<ImageResponse>?>((ref) {
  return ImagesByMonthNotifier(ref);
});

class ImagesByMonthNotifier extends StateNotifier<List<ImageResponse>?> {
  ImagesByMonthNotifier(this.ref) : super(null);

  Ref ref;

  CancelToken cancelToken = CancelToken();

  Future<List<ImageResponse>?> get() async {
    final (startDate, endDate) = ImagesByMonthProviderHelper.setStarAndEndDate(
        ref.read(imagesDateProvider));

    cancelToken.cancel();
    cancelToken = CancelToken();

    final response = await DioClient.apiCall(
      queryParameters: {
        'start_date': startDate,
        'end_date': endDate,
      },
      cancelToken: cancelToken,
    );

    response.when(
      success: (data) {
        state = BaseImageResponse.fromMap(data).imageList.reversed.toList();
      },
      error: (data) {
        state = null;
      },
    );

    return state;
  }
}
