import 'package:apod/services/storage/shared_prefs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ImageListLayoutDirection { vertical, horizontal }

final imageListViewDirectionProvider = StateNotifierProvider<
    ImageListLayoutDirectionNotifier,
    ImageListLayoutDirection>((ref) => ImageListLayoutDirectionNotifier());

class ImageListLayoutDirectionNotifier
    extends StateNotifier<ImageListLayoutDirection> {
  ImageListLayoutDirectionNotifier()
      : super(ImageListLayoutDirection.values
            .byName(SharedPrefs.loadListViewDirection()));

  void setVertical() {
    SharedPrefs.saveListViewDirection(ImageListLayoutDirection.vertical.name);
    state = ImageListLayoutDirection.vertical;
  }

  void setHorizontal() {
    SharedPrefs.saveListViewDirection(ImageListLayoutDirection.horizontal.name);
    state = ImageListLayoutDirection.horizontal;
  }
}
