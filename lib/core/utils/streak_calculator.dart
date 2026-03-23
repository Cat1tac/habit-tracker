class StreakCalculator {
  /// Calculates how many consecutive days a habit was completed
  /// [completedDates] should be sorted ascending
  static int calculateStreak(List<DateTime> completedDates) {
    if (completedDates.isEmpty) return 0;

    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    
    // Sort descending so we start from most recent
    final sorted = [...completedDates]
      ..sort((a, b) => b.compareTo(a));

    int streak = 0;
    DateTime? expectedDate;

    for (final date in sorted) {
      final d = DateTime(date.year, date.month, date.day);
      
      if (expectedDate == null) {
        // First iteration — must be today or yesterday to count
        if (d == todayDate || d == todayDate.subtract(const Duration(days: 1))) {
          streak = 1;
          expectedDate = d.subtract(const Duration(days: 1));
        } else {
          break; // Too old, streak is 0
        }
      } else {
        if (d == expectedDate) {
          streak++;
          expectedDate = d.subtract(const Duration(days: 1));
        } else {
          break; // Gap found, streak ends
        }
      }
    }

    return streak;
  }

  /// Determines if a streak shield should activate
  /// Shields activate when a day is missed but shields remain
  static bool shouldActivateShield({
    required DateTime lastCompleted,
    required int shieldsRemaining,
  }) {
    final today = DateTime.now();
    final daysSinceLast = today.difference(lastCompleted).inDays;
    
    // If exactly 1 day was missed and shields are available
    return daysSinceLast == 2 && shieldsRemaining > 0;
  }

  /// Calculates the completion score for a habit on a given day
  /// Base score 100, modified by streak bonus and timing
  static int calculateDayScore({
    required int currentStreak,
    bool completedOnTime = true,
  }) {
    int score = 100;
    
    // Streak bonus: +5 per 7-day block, max +50
    final streakBonus = ((currentStreak / 7).floor() * 5).clamp(0, 50);
    score += streakBonus;
    
    // Late completion penalty
    if (!completedOnTime) score = (score * 0.8).round();
    
    return score;
  }
}