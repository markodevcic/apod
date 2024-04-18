import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

final isImageCacheEmptyProvider =
    StateNotifierProvider.autoDispose<IsImageCacheEmptyNotifier, bool>(
  (ref) => IsImageCacheEmptyNotifier(ref),
);

class IsImageCacheEmptyNotifier extends StateNotifier<bool> {
  IsImageCacheEmptyNotifier(this.ref) : super(true) {
    init();
  }

  final Ref ref;

  void init() async {
    state = await ref.read(imageCacheDirectoryProvider).init();
  }

  Future<void> clearImageCache() async {
    state = await ref.read(imageCacheDirectoryProvider).clearImageCache();
  }
}

final imageCacheDirectoryProvider = Provider<ImageCacheDirectoryNotifier>(
  (ref) => ImageCacheDirectoryNotifier(),
);

class ImageCacheDirectoryNotifier {
  Directory? imageCacheDir;

  Future<bool> init() async {
    final Directory cacheDir = await getTemporaryDirectory();
    final List<FileSystemEntity> listOfFiles = cacheDir.listSync();

    imageCacheDir = listOfFiles.firstWhereOrNull(
        (element) => element.path.contains('libCachedImageData')) as Directory?;

    return isDirectoryEmpty();
  }

  bool isDirectoryEmpty() {
    return imageCacheDir != null ? imageCacheDir!.listSync().isEmpty : true;
  }

  Future<bool> clearImageCache() async {
    for (var file in imageCacheDir!.listSync()) {
      file.deleteSync();
    }

    return isDirectoryEmpty();
  }
}
