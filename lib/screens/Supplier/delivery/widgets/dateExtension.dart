// extension for check date
extension DateHelpers on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return now.day == this.day &&
        now.month == this.month &&
        now.year == this.year;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(Duration(days: 1));
    return yesterday.day == this.day &&
        yesterday.month == this.month &&
        yesterday.year == this.year;
  }

  String prtToday() {
    final now = DateTime.now();
    String prtDate = '${now.day}/${now.month}/${now.year}';
    return prtDate;
  }

  String prtTomorrow() {
    final tomorrow = DateTime.now().subtract(Duration(days: 1));
    String prtDate = '${tomorrow.day + 2}/${tomorrow.month}/${tomorrow.year}';
    return prtDate;
  }

  String prtYesterday() {
    final yesterday = DateTime.now().subtract(Duration(days: 1));
    String prtDate =
        '${yesterday.day - 0}/${yesterday.month}/${yesterday.year}';
    return prtDate;
  }
}
