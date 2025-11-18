extension DateTimeEx on DateTime {
  String formatToText() {
    final DateTime now = DateTime.now().subtract(const Duration(hours: 5));
    final diff = now.difference(this);

    if (diff.inSeconds >= 1 && diff.inSeconds <= 59) {
      return "${diff.inSeconds} seconds ago";
    } else if (diff.inMinutes >= 1 && diff.inMinutes <= 59) {
      return "${diff.inMinutes} minutes ago";
    } else if (diff.inHours >= 1 && diff.inHours <= 23) {
      return "${diff.inHours} hours ago";
    } else {
      return "${diff.inDays} days ago";
    }
  }
}
