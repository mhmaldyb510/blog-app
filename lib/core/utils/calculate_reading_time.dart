int calculateReadingTime(String content) {
  final words = content.split(RegExp(r'\s+'));
  final readingTime = words.length / 225;
  return readingTime.ceil();
}
