class Streak {
  final String id;
  final String habitId;
  int currentStreak;
  int longestStreak;
  String? lastCompleted;
  int shieldsUsed;

  Streak({
    required this.id,
    required this.habitId,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.lastCompleted,
    this.shieldsUsed = 0,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'habit_id': habitId,
        'current_streak': currentStreak,
        'longest_streak': longestStreak,
        'last_completed': lastCompleted,
        'shields_used': shieldsUsed,
      };

  factory Streak.fromMap(Map<String, dynamic> map) => Streak(
        id: map['id'],
        habitId: map['habit_id'],
        currentStreak: map['current_streak'] ?? 0,
        longestStreak: map['longest_streak'] ?? 0,
        lastCompleted: map['last_completed'],
        shieldsUsed: map['shields_used'] ?? 0,
      );
}