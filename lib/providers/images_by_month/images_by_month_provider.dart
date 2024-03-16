import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apod/constants/env_variable.dart';
import 'package:apod/models/image_response/base_image_response.dart';
import 'package:apod/models/image_response/image_response.dart';
import 'package:apod/providers/images_by_month/images_by_month_provider_helper.dart';
import 'package:apod/providers/images_date_provider.dart';
import 'package:apod/services/network/dio_client.dart';

final getImagesByMonthProvider = FutureProvider.autoDispose<bool>((ref) async {
  final imagesByName = ref.watch(imagesByMonthProvider.notifier);

  ref.invalidateSelf();

  await imagesByName.get();

  return true;
});

final imagesByMonthProvider =
    StateNotifierProvider<ImagesByMonthNotifier, List<ImageResponse>?>((ref) {
  return ImagesByMonthNotifier(ref);
});

class ImagesByMonthNotifier extends StateNotifier<List<ImageResponse>?> {
  ImagesByMonthNotifier(this.ref) : super(null);

  Ref ref;

  CancelToken cancelToken = CancelToken();

  Future<void> get() async {
    final (startDate, endDate) = ImagesByMonthProviderHelper.setStarAndEndDate(
        ref.read(imagesDateProvider));

    final apiKey = dotenv.get(EnvVariable.apiKey);

    cancelToken.cancel();
    if (cancelToken.isCancelled) cancelToken = CancelToken();

    final response = await DioClient.apiCall(
      path:
          '?api_key=$apiKey&start_date=$startDate&end_date=$endDate&thumbs=true',
      cancelToken: cancelToken,
    );

    response.when(
      success: (data) {
        state = BaseImageResponse.fromJson(data).imageList.reversed.toList();
      },
      error: (data) {
        state = null;
      },
    );
  }
}
