import 'package:apod/modules/image_list/images_by_month/providers/images_date_provider.dart';
import 'package:apod/modules/image_list/images_by_month/utils/images_by_month_provider_helper.dart';
import 'package:apod/services/network/dio_client.dart';
import 'package:apod/shared/models/image_response.dart';
import 'package:apod/shared/widgets/notifications/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getImagesByMonthProvider =
    FutureProvider.autoDispose<List<ImageResponse>?>((ref) async {
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

    final dio = ref.read(dioClientProvider);

    try {
      final response = await dio.apiCall(
        queryParameters: {
          'start_date': startDate,
          'end_date': endDate,
        },
        cancelToken: cancelToken,
      );

      state = response.data
          .map<ImageResponse>((image) => ImageResponse.fromJson(image))
          .toList();
    } catch (e) {
      state = null;
      ref.read(toastProvider).error(message: 'Error getting images by month');
      throw Exception('Error getting images by month');
    }

    return state;
  }
}
