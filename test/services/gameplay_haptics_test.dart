import 'package:example_template/services/gameplay_haptics.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GameplayHaptics', () {
    test('no-ops when disabled', () {
      var lightCalls = 0;
      var mediumCalls = 0;
      var heavyCalls = 0;
      final haptics = GameplayHaptics(
        lightImpact: () {
          lightCalls += 1;
          return Future<void>.value();
        },
        mediumImpact: () {
          mediumCalls += 1;
          return Future<void>.value();
        },
        heavyImpact: () {
          heavyCalls += 1;
          return Future<void>.value();
        },
      );

      haptics.numberedClueReached(enabled: false);
      haptics.invalidMove(enabled: false);
      haptics.puzzleSolved(enabled: false);
      haptics.puzzleReset(enabled: false);

      expect(lightCalls, 0);
      expect(mediumCalls, 0);
      expect(heavyCalls, 0);
    });

    test('maps enabled gameplay moments to sparse haptics', () {
      var lightCalls = 0;
      var mediumCalls = 0;
      var heavyCalls = 0;
      final haptics = GameplayHaptics(
        lightImpact: () {
          lightCalls += 1;
          return Future<void>.value();
        },
        mediumImpact: () {
          mediumCalls += 1;
          return Future<void>.value();
        },
        heavyImpact: () {
          heavyCalls += 1;
          return Future<void>.value();
        },
      );

      haptics.numberedClueReached(enabled: true);
      haptics.invalidMove(enabled: true);
      haptics.puzzleSolved(enabled: true);
      haptics.puzzleReset(enabled: true);

      expect(lightCalls, 1);
      expect(mediumCalls, 2);
      expect(heavyCalls, 1);
    });
  });
}
