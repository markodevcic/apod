import 'package:apod/services/storage/shared_prefs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PageListViewDirection { vertical, horizontal }

final pageListViewDirectionProvider =
    StateNotifierProvider<PageListViewDirectionNotifier, PageListViewDirection>(
        (ref) => PageListViewDirectionNotifier());

class PageListViewDirectionNotifier
    extends StateNotifier<PageListViewDirection> {
  PageListViewDirectionNotifier()
      : super(PageListViewDirection.values
            .byName(SharedPrefs.loadListViewDirection()));

  void saveDirection(PageListViewDirection direction) {
    SharedPrefs.saveListViewDirection(direction.name);
    state = direction;
  }

  void setVertical() {
    state = PageListViewDirection.vertical;
  }

  void setHorizontal() {
    state = PageListViewDirection.horizontal;
  }
}
