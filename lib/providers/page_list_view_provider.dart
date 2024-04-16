import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PageListViewDirection { vertical, horizontal }

final pageListViewDirectionProvider =
    StateNotifierProvider<PageListViewDirectionNotifier, PageListViewDirection>(
        (ref) => PageListViewDirectionNotifier());

class PageListViewDirectionNotifier
    extends StateNotifier<PageListViewDirection> {
  PageListViewDirectionNotifier() : super(PageListViewDirection.vertical);

  void setVertical() {
    state = PageListViewDirection.vertical;
  }

  void setHorizontal() {
    state = PageListViewDirection.horizontal;
  }
}
