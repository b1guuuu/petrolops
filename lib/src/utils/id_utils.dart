class IdUtils {
  String generateId() {
    final now = DateTime.now();
    return '${now.year}${now.month}${now.day}${now.hour}${now.minute}${now.second}${now.millisecond}${now.microsecond}';
  }
}
