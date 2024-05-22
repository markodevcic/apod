import 'package:apod/services/network/dio_client.dart';
import 'package:apod/shared/models/image_response.dart';
import 'package:apod/shared/widgets/notifications/toast.dart';
import 'package:apod/utilities/extensions/string_extensions.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'today_image_provider.g.dart';

@riverpod
class TodayImage extends _$TodayImage {
  @override
  Future<ImageResponse?> build() async => await get();

  Future<ImageResponse?> get() async {
    if (state.hasValue && state.value!.date!.isToday()) {
      return state.value;
    }

    final dio = ref.read(dioClientProvider.notifier);

    try {
      final Response response = await dio.apiCall();

      return ImageResponse.fromJson(response.data);
    } catch (e) {
      ref.read(toastProvider).error(message: 'Error getting today image');
      throw 'Error getting today image';
    }
  }
}
