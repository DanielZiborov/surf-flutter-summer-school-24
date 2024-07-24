import 'package:flutter/foundation.dart';

class PhotoController {
  final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

  void setCurrentIndex(int newIndex) {
    currentIndex.value = newIndex;
  }
}
