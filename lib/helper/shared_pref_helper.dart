import 'package:shared_preferences/shared_preferences.dart';
import 'package:example_template/models/play_streak_stats.dart';

abstract class _Action<T> {
  Future<void> saveData(T value);
  Future<T?> getData();
  Future<void> deleteData();
}

class _Onboarding implements _Action<bool> {
  final String key = 'onboarding';

  @override
  Future<void> deleteData() async {
    await SharedPreferences.getInstance().then((prefs) => prefs.remove(key));
  }

  @override
  Future<bool?> getData() {
    return SharedPreferences.getInstance().then((prefs) => prefs.getBool(key));
  }

  @override
  Future<void> saveData(bool value) {
    return SharedPreferences.getInstance().then(
      (prefs) => prefs.setBool(key, value),
    );
  }
}

class _BoolPreference implements _Action<bool> {
  const _BoolPreference(this.key);

  final String key;

  @override
  Future<void> deleteData() async {
    await SharedPreferences.getInstance().then((prefs) => prefs.remove(key));
  }

  @override
  Future<bool?> getData() {
    return SharedPreferences.getInstance().then((prefs) => prefs.getBool(key));
  }

  @override
  Future<void> saveData(bool value) {
    return SharedPreferences.getInstance().then(
      (prefs) => prefs.setBool(key, value),
    );
  }
}

class _StringPreference implements _Action<String> {
  const _StringPreference(this.key);

  final String key;

  @override
  Future<void> deleteData() async {
    await SharedPreferences.getInstance().then((prefs) => prefs.remove(key));
  }

  @override
  Future<String?> getData() {
    return SharedPreferences.getInstance().then(
      (prefs) => prefs.getString(key),
    );
  }

  @override
  Future<void> saveData(String value) {
    return SharedPreferences.getInstance().then(
      (prefs) => prefs.setString(key, value),
    );
  }
}

class _SolvedPuzzles {
  const _SolvedPuzzles();

  static const _key = 'solved_puzzle_numbers';

  Future<Set<int>> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final values = prefs.getStringList(_key) ?? const [];

    return values.map(int.tryParse).whereType<int>().toSet();
  }

  Future<void> add(int puzzleNumber) async {
    final prefs = await SharedPreferences.getInstance();
    final solvedNumbers = prefs.getStringList(_key) ?? <String>[];
    final solvedSet = solvedNumbers.toSet()..add(puzzleNumber.toString());
    final sortedNumbers = solvedSet.toList()
      ..sort((first, second) => int.parse(first).compareTo(int.parse(second)));

    await prefs.setStringList(_key, sortedNumbers);
  }

  Future<void> deleteData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}

class _PlayStreak {
  const _PlayStreak();

  static const _currentKey = 'play_streak.current';
  static const _bestKey = 'play_streak.best';
  static const _lastPlayedDateKey = 'play_streak.last_played_date';

  Future<PlayStreakStats> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final lastPlayedDateValue = prefs.getString(_lastPlayedDateKey);

    return PlayStreakStats(
      currentStreak: prefs.getInt(_currentKey) ?? 0,
      bestStreak: prefs.getInt(_bestKey) ?? 0,
      lastPlayedDate: lastPlayedDateValue == null
          ? null
          : DateTime.tryParse(lastPlayedDateValue),
    );
  }

  Future<PlayStreakStats> recordCompletion({DateTime? now}) async {
    final stats = await getData();
    final updatedStats = stats.recordCompletion(now ?? DateTime.now());
    await _saveData(updatedStats);

    return updatedStats;
  }

  Future<void> deleteData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentKey);
    await prefs.remove(_bestKey);
    await prefs.remove(_lastPlayedDateKey);
  }

  Future<void> _saveData(PlayStreakStats value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_currentKey, value.currentStreak);
    await prefs.setInt(_bestKey, value.bestStreak);

    final lastPlayedDate = value.lastPlayedDate;
    if (lastPlayedDate == null) {
      await prefs.remove(_lastPlayedDateKey);
    } else {
      await prefs.setString(
        _lastPlayedDateKey,
        lastPlayedDate.toIso8601String(),
      );
    }
  }
}

//TODO: In startup, it will create all [_Action] instance, we must handle it later
class SharedPrefHelper {
  final onboarding = _Onboarding();
  final themePreference = const _StringPreference('theme_preference');
  final soundEnabled = const _BoolPreference('sound_enabled');
  final hapticsEnabled = const _BoolPreference('haptics_enabled');
  final locale = const _StringPreference('locale');
  final solvedPuzzles = const _SolvedPuzzles();
  final playStreak = const _PlayStreak();
}
