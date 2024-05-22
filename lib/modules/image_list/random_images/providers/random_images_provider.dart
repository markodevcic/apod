import 'package:apod/services/network/dio_client.dart';
import 'package:apod/shared/models/image_response.dart';
import 'package:apod/shared/widgets/notifications/toast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'random_images_provider.g.dart';

@riverpod
class RandomImages extends _$RandomImages {
  @override
  Future<List<ImageResponse>?> build() async => await get();

  Future<List<ImageResponse>?> get() async {
    state = const AsyncValue.loading();

    final dio = ref.read(dioClientProvider.notifier);

    try {
      final response = await dio.apiCall(
        queryParameters: {'count': 30},
      );

      return response.data
          .map<ImageResponse>((image) => ImageResponse.fromJson(image))
          .toList();
    } catch (e) {
      state = const AsyncValue.data(null);
      ref.read(toastProvider).error(message: 'Error getting random images');
      throw 'Error getting random images';
    }
  }
}
