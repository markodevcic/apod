import 'package:apod/services/network/dio_client.dart';
import 'package:apod/shared/models/image_response.dart';
import 'package:apod/utilities/extensions/string_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final todayImageProvider =
    StateNotifierProvider<TodayImageNotifier, ImageResponse?>((ref) {
  return TodayImageNotifier(ref);
});

final getTodayImageProvider = FutureProvider<ImageResponse?>((ref) async {
  return await ref.watch(todayImageProvider.notifier).get();
});

class TodayImageNotifier extends StateNotifier<ImageResponse?> {
  TodayImageNotifier(this.ref) : super(null);

  Ref ref;

  Future<ImageResponse?> get() async {
    if (state != null && state!.date!.isToday()) {
      return state;
    }

    final dio = ref.read(dioClientProvider);
    final response = await dio.apiCall();

    response.when(
      success: (data) {
        state = ImageResponse.fromMap(data);
      },
      error: (data) {
        state = null;
      },
    );

    return state;
  }
}
