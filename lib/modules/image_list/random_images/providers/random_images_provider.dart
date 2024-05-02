import 'package:apod/services/network/dio_client.dart';
import 'package:apod/shared/models/image_response.dart';
import 'package:apod/shared/widgets/notifications/toast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getRandomImagesProvider =
    FutureProvider.autoDispose<List<ImageResponse>?>(
  (ref) async {
    return await ref.watch(randomImagesProvider.notifier).get();
  },
);

final randomImagesProvider = StateNotifierProvider.autoDispose<
    RandomImagesNotifier, List<ImageResponse>?>(
  (ref) => RandomImagesNotifier(ref),
);

class RandomImagesNotifier extends StateNotifier<List<ImageResponse>?> {
  RandomImagesNotifier(this.ref) : super(null);

  Ref ref;

  Future<List<ImageResponse>?> get() async {
    final dio = ref.read(dioClientProvider);

    try {
      final response = await dio.apiCall(
        queryParameters: {
          'count': 30,
        },
      );

      state = response.data
          .map<ImageResponse>((image) => ImageResponse.fromJson(image))
          .toList();
    } catch (e) {
      state = null;
      ref.read(toastProvider).error(message: 'Error getting random images');
      throw Exception('Error getting random images');
    }

    return state;
  }
}
