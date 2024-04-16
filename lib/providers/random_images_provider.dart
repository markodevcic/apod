import 'package:apod/models/image_response/base_image_response.dart';
import 'package:apod/models/image_response/image_response.dart';
import 'package:apod/services/network/dio_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getRandomImagesProvider = FutureProvider<List<ImageResponse>?>(
  (ref) async {
    return await ref.watch(randomImagesProvider.notifier).get();
  },
);

final randomImagesProvider =
    StateNotifierProvider<RandomImagesNotifier, List<ImageResponse>?>(
  (ref) => RandomImagesNotifier(),
);

class RandomImagesNotifier extends StateNotifier<List<ImageResponse>?> {
  RandomImagesNotifier() : super(null);

  Future<List<ImageResponse>?> get() async {
    final response = await DioClient.apiCall(
      queryParameters: {
        'count': 30,
      },
    );

    response.when(
      success: (data) {
        state = BaseImageResponse.fromMap(data).imageList;
      },
      error: (data) {
        state = null;
      },
    );

    return state;
  }
}
