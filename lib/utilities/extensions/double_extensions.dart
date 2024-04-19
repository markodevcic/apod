extension DoubleExtension on double {
  double formatFileSize() {
    if (this < 1024) {
      return this;
    } else if (this < 1024 * 1024) {
      return this / 1024;
    } else if (this < 1024 * 1024 * 1024) {
      return this / (1024 * 1024);
    } else {
      return this / (1024 * 1024 * 1024);
    }
  }

  String formatFileSizeToString() {
    if (this < 1024) {
      return ' B';
    } else if (this < 1024 * 1024) {
      return ' KB';
    } else if (this < 1024 * 1024 * 1024) {
      return ' MB';
    } else {
      return ' GB';
    }
  }
}
