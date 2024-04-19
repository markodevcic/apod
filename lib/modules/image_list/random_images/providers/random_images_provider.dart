import 'package:apod/services/network/dio_client.dart';
import 'package:apod/shared/models/base_image_response.dart';
import 'package:apod/shared/models/image_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getRandomImagesProvider = FutureProvider<List<ImageResponse>?>(
  (ref) async {
    return await ref.watch(randomImagesProvider.notifier).get();
  },
);

final randomImagesProvider =
    StateNotifierProvider<RandomImagesNotifier, List<ImageResponse>?>(
  (ref) => RandomImagesNotifier(ref),
);

class RandomImagesNotifier extends StateNotifier<List<ImageResponse>?> {
  RandomImagesNotifier(this.ref) : super(null);

  Ref ref;

  Future<List<ImageResponse>?> get() async {
    final dio = ref.read(dioClientProvider);
    final response = await dio.apiCall(
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
