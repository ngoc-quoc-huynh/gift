extension DurationExtension on Duration {
  String toDDHHMMSS() {
    final hours = inHours.remainder(24);
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);

    return '${inDays.toString().padLeft(2, '0')}:'
        '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }
}
