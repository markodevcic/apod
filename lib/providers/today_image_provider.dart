import 'package:apod/models/image_response/image_response.dart';
import 'package:apod/services/network/dio_client.dart';
import 'package:apod/utilities/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final todayImageProvider =
    StateNotifierProvider<TodayImageNotifier, ImageResponse?>((ref) {
  return TodayImageNotifier();
});

class TodayImageNotifier extends StateNotifier<ImageResponse?> {
  TodayImageNotifier() : super(null);

  Future<void> get() async {
    if (state != null && state!.date!.isToday()) {
      return;
    }

    final response = await DioClient.apiCall();

    response.when(
      success: (data) {
        state = ImageResponse.fromMap(data);
      },
      error: (data) {
        state = null;
      },
    );
  }
}
