import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

final imageCacheDirectoryProvider =
    ChangeNotifierProvider.autoDispose<ImageCacheDirectoryNotifier>(
  (ref) => ImageCacheDirectoryNotifier(),
);

class ImageCacheDirectoryNotifier extends ChangeNotifier {
  ImageCacheDirectoryNotifier() {
    init();
  }

  Directory? _cacheDir;
  double _totalSize = 0;
  final bool _isCacheEmpty = true;

  Directory? get cacheDir => _cacheDir;
  double get totalSize => _totalSize;
  bool get isCacheEmpty => _isCacheEmpty;

  Future<void> init() async {
    final Directory cacheDir = await getTemporaryDirectory();
    final List<FileSystemEntity> listOfFiles = cacheDir.listSync();

    _cacheDir = listOfFiles.firstWhereOrNull(
        (element) => element.path.contains('libCachedImageData')) as Directory?;

    calculateTotalSize();
    checkIsDirectoryEmpty();

    notifyListeners();
  }

  bool checkIsDirectoryEmpty() {
    return _cacheDir != null ? _cacheDir!.listSync().isEmpty : true;
  }

  void calculateTotalSize() {
    double size = 0;
    for (var file in _cacheDir!.listSync()) {
      size += file.statSync().size;
    }
    _totalSize = size;
  }

  Future<void> clearImageCache() async {
    for (var file in _cacheDir!.listSync()) {
      file.deleteSync();
    }

    calculateTotalSize();
    checkIsDirectoryEmpty();

    notifyListeners();
  }
}
