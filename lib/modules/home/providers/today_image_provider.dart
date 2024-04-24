import 'package:apod/services/network/dio_client.dart';
import 'package:apod/shared/models/image_response.dart';
import 'package:apod/shared/widgets/notifications/toast.dart';
import 'package:apod/utilities/extensions/string_extensions.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final todayImageProvider =
    StateNotifierProvider<TodayImageNotifier, ImageResponse?>((ref) {
  return TodayImageNotifier(ref);
});

final getTodayImageProvider =
    FutureProvider.autoDispose<ImageResponse?>((ref) async {
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

    try {
      final Response response = await dio.apiCall();

      state = ImageResponse.fromMap(response.data);
    } catch (e) {
      state = null;
      ref.read(toastProvider).error(message: 'Error getting today image');
      throw Exception('Error getting today image');
    }

    return state;
  }
}
