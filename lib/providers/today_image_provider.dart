import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apod/constants/env_variable.dart';
import 'package:apod/models/image_response/image_response.dart';
import 'package:apod/services/network/dio_client.dart';

final todayImageProvider =
    StateNotifierProvider<TodayImageNotifier, ImageResponse?>((ref) {
  return TodayImageNotifier();
});

class TodayImageNotifier extends StateNotifier<ImageResponse?> {
  TodayImageNotifier() : super(null);

  Future<void> get() async {
    final apiKey = dotenv.get(EnvVariable.apiKey);

    final response = await DioClient.apiCall(
      path: '?api_key=$apiKey',
    );

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
