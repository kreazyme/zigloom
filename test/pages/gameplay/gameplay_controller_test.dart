import 'package:example_template/models/game_scenario.dart';
import 'package:example_template/pages/gameplay/gameplay_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('GameplayController.extendPath', () {
    test('returns moved for a valid normal cell', () {
      final controller = GameplayController(
        _normalMoveScenario(),
        isLoadingProgress: false,
      );

      expect(
        controller.extendPath(const GridPoint(0, 1)),
        GameplayMoveResult.moved,
      );
      expect(controller.path, const [GridPoint(0, 0), GridPoint(0, 1)]);
    });

    test('returns reachedNumberedClue for a valid clue cell', () {
      final controller = GameplayController(
        _numberedClueScenario(),
        isLoadingProgress: false,
      );

      expect(
        controller.extendPath(const GridPoint(0, 1)),
        GameplayMoveResult.reachedNumberedClue,
      );
      expect(controller.path, const [GridPoint(0, 0), GridPoint(0, 1)]);
    });

    test('returns invalid without changing the path for invalid moves', () {
      final controller = GameplayController(
        _normalMoveScenario(),
        isLoadingProgress: false,
      );

      expect(
        controller.extendPath(const GridPoint(0, 2)),
        GameplayMoveResult.invalid,
      );
      expect(controller.path, const [GridPoint(0, 0)]);
    });

    test('returns solved when a valid move completes the puzzle', () {
      final controller = GameplayController(
        _solvableScenario(),
        isLoadingProgress: false,
      );

      expect(
        controller.extendPath(const GridPoint(0, 1)),
        GameplayMoveResult.solved,
      );
      expect(controller.isSolved, isTrue);
    });
  });
}

GameScenario _normalMoveScenario() {
  return GameScenario(
    id: 'normal-move',
    puzzleNumber: 1,
    rowCount: 1,
    columnCount: 3,
    numberPositions: {const GridPoint(0, 0): 1, const GridPoint(0, 2): 2},
    solutionPath: const [GridPoint(0, 0)],
    metadata: const GameScenarioMetadata(
      checkpointCount: 2,
      lastNumber: 2,
      lastNumberCell: GridPoint(0, 2),
      uniqueSolution: true,
      solutionCount: 1,
      solutionRule: '',
    ),
  );
}

GameScenario _numberedClueScenario() {
  return GameScenario(
    id: 'numbered-clue',
    puzzleNumber: 1,
    rowCount: 1,
    columnCount: 3,
    numberPositions: {const GridPoint(0, 0): 1, const GridPoint(0, 1): 2},
    solutionPath: const [GridPoint(0, 0)],
    metadata: const GameScenarioMetadata(
      checkpointCount: 2,
      lastNumber: 2,
      lastNumberCell: GridPoint(0, 1),
      uniqueSolution: true,
      solutionCount: 1,
      solutionRule: '',
    ),
  );
}

GameScenario _solvableScenario() {
  return GameScenario(
    id: 'solvable',
    puzzleNumber: 1,
    rowCount: 1,
    columnCount: 2,
    numberPositions: {const GridPoint(0, 0): 1, const GridPoint(0, 1): 2},
    solutionPath: const [GridPoint(0, 0)],
    metadata: const GameScenarioMetadata(
      checkpointCount: 2,
      lastNumber: 2,
      lastNumberCell: GridPoint(0, 1),
      uniqueSolution: true,
      solutionCount: 1,
      solutionRule: '',
    ),
  );
}
