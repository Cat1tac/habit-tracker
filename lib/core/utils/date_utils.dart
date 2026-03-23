/// Utility functions for date manipulation throughout the app.
class AppDateUtils {
  AppDateUtils._(); // Prevent instantiation

  // Formatting

  /// Returns "Mon, Jan 6" style display string
  static String formatDisplayDate(DateTime date) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final wd = weekdays[date.weekday - 1];
    final mo = months[date.month - 1];
    return '$wd, $mo ${date.day}';
  }

  /// Returns "January 2025" style month/year string
  static String formatMonthYear(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  /// Returns relative time: "Today", "Yesterday", "3 days ago", or full date
  static String formatRelative(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(date.year, date.month, date.day);
    final diff = today.difference(target).inDays;

    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    if (diff < 7) return '$diff days ago';
    return formatDisplayDate(date);
  }

  /// Returns "Week of Jan 6 – Jan 12" for a given week start date
  static String formatWeekRange(DateTime weekStart) {
    final weekEnd = weekStart.add(const Duration(days: 6));
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final startStr = '${months[weekStart.month - 1]} ${weekStart.day}';
    final endStr = '${months[weekEnd.month - 1]} ${weekEnd.day}';
    return 'Week of $startStr – $endStr';
  }

  // Week calculations

  /// Returns the Monday of the current week
  static DateTime startOfCurrentWeek() {
    final now = DateTime.now();
    final daysFromMonday = now.weekday - 1;
    return DateTime(now.year, now.month, now.day - daysFromMonday);
  }

  /// Returns a list of 7 DateTime objects for the current week (Mon–Sun)
  static List<DateTime> currentWeekDays() {
    final monday = startOfCurrentWeek();
    return List.generate(7, (i) => monday.add(Duration(days: i)));
  }

  /// Returns the start of the previous week's Monday
  static DateTime startOfPreviousWeek() {
    return startOfCurrentWeek().subtract(const Duration(days: 7));
  }

  // Day-level comparison helpers

  /// Returns true if two DateTimes are the same calendar day
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// Returns true if the date is today
  static bool isToday(DateTime date) => isSameDay(date, DateTime.now());

  /// Returns true if the date was yesterday
  static bool isYesterday(DateTime date) {
    return isSameDay(date, DateTime.now().subtract(const Duration(days: 1)));
  }

  /// Strips time from a DateTime, keeping only year/month/day
  static DateTime toDateOnly(DateTime dt) {
    return DateTime(dt.year, dt.month, dt.day);
  }

  // ISO string helpers

  /// Returns today's date as a YYYY-MM-DD string
  static String todayIso() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  /// Converts a DateTime to YYYY-MM-DD string
  static String toIsoDate(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }

  /// Parses a YYYY-MM-DD string to DateTime (date only, no time)
  static DateTime fromIsoDate(String isoDate) {
    final parts = isoDate.split('-');
    return DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
  }
}