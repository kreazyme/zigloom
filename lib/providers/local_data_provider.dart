import 'package:example_template/helper/shared_pref_helper.dart';
import 'package:example_template/models/play_streak_stats.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localDataProvider = Provider<SharedPrefHelper>(
  (ref) => SharedPrefHelper(),
);

final solvedPuzzleNumbersProvider = FutureProvider<Set<int>>((ref) {
  return ref.read(localDataProvider).solvedPuzzles.getData();
});

final playStreakProvider = FutureProvider<PlayStreakStats>((ref) {
  return ref.read(localDataProvider).playStreak.getData();
});
