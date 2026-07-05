import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameplayHapticsProvider = Provider<GameplayHaptics>(
  (ref) => const GameplayHaptics(),
);

class GameplayHaptics {
  const GameplayHaptics({
    this.lightImpact = HapticFeedback.lightImpact,
    this.mediumImpact = HapticFeedback.mediumImpact,
    this.heavyImpact = HapticFeedback.heavyImpact,
  });

  final Future<void> Function() lightImpact;
  final Future<void> Function() mediumImpact;
  final Future<void> Function() heavyImpact;

  void numberedClueReached({required bool enabled}) {
    if (!enabled) {
      return;
    }

    unawaited(lightImpact());
  }

  void invalidMove({required bool enabled}) {
    if (!enabled) {
      return;
    }

    unawaited(heavyImpact());
  }

  void puzzleSolved({required bool enabled}) {
    if (!enabled) {
      return;
    }

    unawaited(mediumImpact());
  }

  void puzzleReset({required bool enabled}) {
    if (!enabled) {
      return;
    }

    unawaited(mediumImpact());
  }
}
