class PlayStreakStats {
  const PlayStreakStats({
    required this.currentStreak,
    required this.bestStreak,
    required this.lastPlayedDate,
  });

  const PlayStreakStats.empty()
    : currentStreak = 0,
      bestStreak = 0,
      lastPlayedDate = null;

  final int currentStreak;
  final int bestStreak;
  final DateTime? lastPlayedDate;

  bool hasPlayedOn(DateTime date) {
    final normalizedDate = normalizeDate(date);
    return lastPlayedDate == normalizedDate;
  }

  PlayStreakStats recordCompletion(DateTime now) {
    final today = normalizeDate(now);
    final lastDate = lastPlayedDate;

    if (lastDate == today) {
      return this;
    }

    final nextCurrentStreak =
        lastDate != null && today.difference(lastDate).inDays == 1
        ? currentStreak + 1
        : 1;

    return PlayStreakStats(
      currentStreak: nextCurrentStreak,
      bestStreak: nextCurrentStreak > bestStreak
          ? nextCurrentStreak
          : bestStreak,
      lastPlayedDate: today,
    );
  }

  static DateTime normalizeDate(DateTime date) {
    final localDate = date.toLocal();
    return DateTime(localDate.year, localDate.month, localDate.day);
  }
}
