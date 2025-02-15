extension DurationExtension on Duration {
  String toHHMMSS() {
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);

    return '${inHours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }
}
