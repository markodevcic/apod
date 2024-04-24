import 'package:apod/shared/models/image_response.dart';
import 'package:apod/shared/widgets/notifications/toast.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

class ImagePreviewUtils {
  static Future<void> shareImage(WidgetRef ref, ImageResponse image) async {
    final BaseCacheManager baseCacheManager = DefaultCacheManager();

    FileInfo? cachedImage = await baseCacheManager.getFileFromCache(image.url!);

    if (cachedImage == null) {
      await baseCacheManager.downloadFile(image.url!);
      cachedImage = await baseCacheManager.getFileFromCache(image.url!);
    }

    final ShareResult result = await Share.shareXFiles(
      [XFile(cachedImage!.file.path)],
    );

    if (result.status == ShareResultStatus.success) {
      ref.read(toastProvider).success(message: 'Share successful');
    }
  }
}
