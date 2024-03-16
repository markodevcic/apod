import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apod/constants/env_variable.dart';
import 'package:apod/models/image_response/base_image_response.dart';
import 'package:apod/models/image_response/image_response.dart';
import 'package:apod/services/network/dio_client.dart';

final randomImagesProvider =
    StateNotifierProvider<RandomImagesNotifier, List<ImageResponse>?>(
  (ref) => RandomImagesNotifier(),
);

class RandomImagesNotifier extends StateNotifier<List<ImageResponse>?> {
  RandomImagesNotifier() : super(null);

  Future<void> get() async {
    final apiKey = dotenv.get(EnvVariable.apiKey);

    final response = await DioClient.apiCall(
      path: '?api_key=$apiKey&count=30&thumbs=true',
    );

    response.when(
      success: (data) {
        state = BaseImageResponse.fromJson(data).imageList;
      },
      error: (data) {
        state = null;
      },
    );
  }
}
