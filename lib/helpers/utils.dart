class Utils {
  static String duration(DateTime createAt) {
    final duration = DateTime.now().difference(createAt).inMinutes;

    if (duration < 60) {
      return 'há ${DateTime.now().difference(createAt).inMinutes} min';
    } else if (duration >= 60) {
      return 'há ${DateTime.now().difference(createAt).inHours} horas';
    } else {
      return '';
    }
  }
}
