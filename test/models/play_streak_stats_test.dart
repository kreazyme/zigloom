import 'package:example_template/models/play_streak_stats.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlayStreakStats', () {
    test('starts a streak on first completion', () {
      final stats = const PlayStreakStats.empty().recordCompletion(
        DateTime(2026, 7, 3, 20, 30),
      );

      expect(stats.currentStreak, 1);
      expect(stats.bestStreak, 1);
      expect(stats.lastPlayedDate, DateTime(2026, 7, 3));
    });

    test('does not increment twice on the same local day', () {
      final stats = const PlayStreakStats.empty()
          .recordCompletion(DateTime(2026, 7, 3, 8))
          .recordCompletion(DateTime(2026, 7, 3, 22));

      expect(stats.currentStreak, 1);
      expect(stats.bestStreak, 1);
    });

    test('increments on the next calendar day', () {
      final stats = const PlayStreakStats.empty()
          .recordCompletion(DateTime(2026, 7, 3))
          .recordCompletion(DateTime(2026, 7, 4));

      expect(stats.currentStreak, 2);
      expect(stats.bestStreak, 2);
    });

    test('resets current streak after a missed day and preserves best', () {
      final stats = const PlayStreakStats.empty()
          .recordCompletion(DateTime(2026, 7, 3))
          .recordCompletion(DateTime(2026, 7, 4))
          .recordCompletion(DateTime(2026, 7, 6));

      expect(stats.currentStreak, 1);
      expect(stats.bestStreak, 2);
    });
  });
}
