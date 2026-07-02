import 'dart:async';
import 'dart:convert';

import 'package:example_template/models/game_scenario.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

final gameplayControllerProvider =
    ChangeNotifierProvider.family<GameplayController, GameScenario>(
      (ref, scenario) => GameplayController(scenario)..restoreProgress(),
      isAutoDispose: true,
    );

class GameplayController extends ChangeNotifier {
  GameplayController(this.scenario) : _path = [scenario.start];

  final GameScenario scenario;

  List<GridPoint> _path;
  Timer? _timer;
  Duration _elapsed = Duration.zero;
  int _moveCount = 0;
  int _undoCount = 0;
  int _invalidPulse = 0;
  GridPoint? _invalidPoint;
  bool _isSolved = false;
  bool _isLoadingProgress = true;
  bool _isDisposed = false;

  List<GridPoint> get path => List.unmodifiable(_path);
  Duration get elapsed => _elapsed;
  int get moveCount => _moveCount;
  int get undoCount => _undoCount;
  int get invalidPulse => _invalidPulse;
  GridPoint? get invalidPoint => _invalidPoint;
  bool get isSolved => _isSolved;
  bool get isLoadingProgress => _isLoadingProgress;
  bool get canUndo => _path.length > 1 && !_isSolved;
  bool get canReset => _path.length > 1 || _isSolved;

  int get nextRequiredNumber {
    final visitedNumbers = _path
        .map(scenario.numberAt)
        .whereType<int>()
        .toSet();

    for (var number = 1; number <= scenario.lastNumber; number += 1) {
      if (!visitedNumbers.contains(number)) {
        return number;
      }
    }

    return scenario.lastNumber;
  }

  String get progressKey => 'gameplay.${scenario.id}.path';
  String get elapsedKey => 'gameplay.${scenario.id}.elapsedSeconds';
  String get moveKey => 'gameplay.${scenario.id}.moves';
  String get undoKey => 'gameplay.${scenario.id}.undos';

  Future<void> restoreProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPath = prefs.getString(progressKey);
    final decodedPath = savedPath == null ? null : _decodePath(savedPath);

    if (_isDisposed) {
      return;
    }

    if (decodedPath != null && _isPathValid(decodedPath)) {
      _path = decodedPath;
    }
    _elapsed = Duration(seconds: prefs.getInt(elapsedKey) ?? 0);
    _moveCount = prefs.getInt(moveKey) ?? (_path.length - 1);
    _undoCount = prefs.getInt(undoKey) ?? 0;
    _isSolved = _isComplete;
    _isLoadingProgress = false;
    notifyListeners();

    if (!_isSolved) {
      startTimer();
    }
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _elapsed += const Duration(seconds: 1);
      notifyListeners();
      unawaited(_persistProgress());
    });
  }

  void pauseTimer() {
    _timer?.cancel();
  }

  bool extendPath(GridPoint point) {
    if (_isLoadingProgress || point == _path.last) {
      return false;
    }

    final selectedIndex = _path.indexOf(point);
    if (selectedIndex != -1) {
      _trimPathTo(selectedIndex);
      return false;
    }

    if (_isSolved) {
      return false;
    }

    final last = _path.last;
    final isValid =
        scenario.contains(point) &&
        point.isAdjacentTo(last) &&
        !scenario.hasWallBetween(last, point) &&
        !_path.contains(point) &&
        _isNumberMoveAllowed(point);

    if (!isValid) {
      _flashInvalid(point);
      return false;
    }

    _invalidPoint = null;
    _path = [..._path, point];
    _moveCount += 1;
    _isSolved = _isComplete;
    notifyListeners();
    unawaited(_persistProgress());

    if (_isSolved) {
      pauseTimer();
    }

    return _isSolved;
  }

  void _trimPathTo(int selectedIndex) {
    _path = _path.sublist(0, selectedIndex + 1);
    _undoCount += 1;
    _invalidPoint = null;

    if (_isSolved) {
      _isSolved = false;
      startTimer();
    }

    notifyListeners();
    unawaited(_persistProgress());
  }

  void undo() {
    if (!canUndo) {
      return;
    }

    _path = _path.sublist(0, _path.length - 1);
    _undoCount += 1;
    _invalidPoint = null;
    notifyListeners();
    unawaited(_persistProgress());
  }

  void reset() {
    _path = [scenario.start];
    _elapsed = Duration.zero;
    _moveCount = 0;
    _undoCount = 0;
    _invalidPoint = null;
    _isSolved = false;
    notifyListeners();
    startTimer();
    unawaited(_persistProgress());
  }

  bool _isNumberMoveAllowed(GridPoint point) {
    final number = scenario.numberAt(point);
    return number == null || number == nextRequiredNumber;
  }

  bool get _isComplete {
    final visitedNumbers = _path
        .map(scenario.numberAt)
        .whereType<int>()
        .toSet();

    return _path.length == scenario.cellCount &&
        visitedNumbers.length == scenario.numberPositions.length &&
        visitedNumbers.contains(scenario.lastNumber);
  }

  bool _isPathValid(List<GridPoint> restoredPath) {
    if (restoredPath.isEmpty || restoredPath.first != scenario.start) {
      return false;
    }

    final visited = <GridPoint>{};
    var expectedNumber = 1;

    for (var index = 0; index < restoredPath.length; index += 1) {
      final point = restoredPath[index];
      if (!scenario.contains(point) || !visited.add(point)) {
        return false;
      }

      if (index > 0) {
        final previous = restoredPath[index - 1];
        if (!point.isAdjacentTo(previous) ||
            scenario.hasWallBetween(previous, point)) {
          return false;
        }
      }

      final number = scenario.numberAt(point);
      if (number != null) {
        if (number != expectedNumber) {
          return false;
        }
        expectedNumber += 1;
      }
    }

    return true;
  }

  void _flashInvalid(GridPoint point) {
    _invalidPoint = point;
    _invalidPulse += 1;
    notifyListeners();
    Future<void>.delayed(const Duration(milliseconds: 520), () {
      if (!_isDisposed && _invalidPoint == point) {
        _invalidPoint = null;
        notifyListeners();
      }
    });
  }

  List<GridPoint>? _decodePath(String encoded) {
    final decoded = jsonDecode(encoded) as List<dynamic>;

    return decoded
        .map((value) {
          if (value is String) {
            return GridPoint.parse(value);
          }

          final map = value as Map<String, dynamic>;
          return GridPoint(map['row'] as int, map['column'] as int);
        })
        .toList(growable: false);
  }

  Future<void> _persistProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      progressKey,
      jsonEncode(_path.map((point) => point.key).toList()),
    );
    await prefs.setInt(elapsedKey, _elapsed.inSeconds);
    await prefs.setInt(moveKey, _moveCount);
    await prefs.setInt(undoKey, _undoCount);
  }

  @override
  void dispose() {
    _isDisposed = true;
    _timer?.cancel();
    super.dispose();
  }
}
