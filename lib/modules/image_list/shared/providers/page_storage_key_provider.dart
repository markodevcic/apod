import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pageStorageKeyProvider = Provider<PageStorageKeyProvider>((ref) {
  return PageStorageKeyProvider(
    verticalList: PageStorageKey(Random().nextInt(1000).toString()),
    horizontalList: PageStorageKey(Random().nextInt(1000).toString()),
  );
});

class PageStorageKeyProvider {
  PageStorageKeyProvider({
    required this.verticalList,
    required this.horizontalList,
  });

  PageStorageKey verticalList;
  PageStorageKey horizontalList;

  void updateKeys() {
    verticalList = PageStorageKey(Random().nextInt(1000).toString());
    horizontalList = PageStorageKey(Random().nextInt(1000).toString());
  }
}
