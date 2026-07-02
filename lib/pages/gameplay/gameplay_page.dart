import 'package:example_template/common/app_router.dart';
import 'package:example_template/common/theme.dart';
import 'package:example_template/common/widgets/arcade_widgets.dart';
import 'package:example_template/data/game_scenarios.dart';
import 'package:example_template/gen/i18n/locale.dart';
import 'package:example_template/models/game_scenario.dart';
import 'package:example_template/pages/gameplay/gameplay_controller.dart';
import 'package:example_template/pages/gameplay/widgets/gameplay_board.dart';
import 'package:example_template/pages/gameplay/widgets/gameplay_controls.dart';
import 'package:example_template/pages/gameplay/widgets/gameplay_header.dart';
import 'package:example_template/pages/gameplay/widgets/gameplay_status.dart';
import 'package:example_template/pages/gameplay/widgets/winning_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

const _gameplayBackgroundAsset =
    'assets/images/backgrounds/game_list_background.png';

class GameplayPage extends ConsumerWidget {
  const GameplayPage({super.key, required this.puzzleNumber});

  final int puzzleNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scenarioValue = ref.watch(gameScenarioProvider(puzzleNumber));

    return scenarioValue.when(
      data: (scenario) => _GameplayContent(scenario: scenario),
      loading: () => const _GameplayLoading(),
      error: (error, _) => _GameplayError(
        message: error.toString(),
        onRetry: () => ref.invalidate(gameScenariosProvider),
      ),
    );
  }
}

class _GameplayContent extends ConsumerStatefulWidget {
  const _GameplayContent({required this.scenario});

  final GameScenario scenario;

  @override
  ConsumerState<_GameplayContent> createState() => _GameplayContentState();
}

class _GameplayContentState extends ConsumerState<_GameplayContent> {
  bool _showWinningLayer = false;

  @override
  Widget build(BuildContext context) {
    final scenario = widget.scenario;
    final controller = ref.watch(gameplayControllerProvider(scenario));
    final scenarios =
        ref.watch(gameScenariosProvider).asData?.value ?? const [];
    final nextPuzzleNumber = _nextPuzzleNumber(scenarios, scenario);
    final strings = context.t.gameplay;

    return Scaffold(
      body: ArcadeBackdrop(
        backgroundAsset: _gameplayBackgroundAsset,
        child: Stack(
          fit: StackFit.expand,
          children: [
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final contentWidth = constraints.maxWidth.clamp(300.0, 560.0);

                  return Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 22),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight - 36,
                          maxWidth: contentWidth,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GameplayHeader(
                              puzzleLabel: strings.puzzle.replaceAll(
                                '{number}',
                                scenario.puzzleNumber.toString(),
                              ),
                              timer: _formatTime(controller.elapsed),
                              movesLabel: strings.moves.replaceAll(
                                '{count}',
                                controller.moveCount.toString(),
                              ),
                              onPause: () => _openPause(context, controller),
                            ),
                            const SizedBox(height: 18),
                            if (controller.isLoadingProgress)
                              const SizedBox(
                                height: 360,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppTheme.white,
                                  ),
                                ),
                              )
                            else
                              GameplayBoard(
                                scenario: scenario,
                                controller: controller,
                                onSolved: _showWin,
                              ),
                            const SizedBox(height: 18),
                            GameplayStatus(controller: controller),
                            const SizedBox(height: 18),
                            GameplayControls(
                              onUndo: controller.canUndo
                                  ? controller.undo
                                  : null,
                              onReset: controller.canReset
                                  ? () {
                                      _hideWin();
                                      controller.reset();
                                    }
                                  : null,
                              onHowToPlay: () =>
                                  _openHowToPlay(context, controller),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_showWinningLayer)
              WinningOverlay(
                time: _formatTime(controller.elapsed),
                moves: controller.moveCount,
                nextPuzzleNumber: nextPuzzleNumber,
                onNextLevel: nextPuzzleNumber == null
                    ? null
                    : () => _goToPuzzle(nextPuzzleNumber),
                onChooseLevel: _goToLevelList,
                onReplay: () {
                  _hideWin();
                  controller.reset();
                },
              ),
          ],
        ),
      ),
    );
  }

  void _showWin() {
    if (!_showWinningLayer) {
      setState(() => _showWinningLayer = true);
    }
  }

  void _hideWin() {
    if (_showWinningLayer) {
      setState(() => _showWinningLayer = false);
    }
  }

  void _goToPuzzle(int puzzleNumber) {
    _navigateAfterWin(() {
      context.go(AppRoutePaths.gameplayPuzzle(puzzleNumber));
    });
  }

  void _goToLevelList() {
    _navigateAfterWin(() {
      context.go(AppRoutePaths.gameList);
    });
  }

  void _navigateAfterWin(VoidCallback navigate) {
    _hideWin();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        navigate();
      }
    });
  }

  int? _nextPuzzleNumber(List<GameScenario> scenarios, GameScenario scenario) {
    final laterScenarios =
        scenarios
            .where(
              (candidate) => candidate.puzzleNumber > scenario.puzzleNumber,
            )
            .toList()
          ..sort(
            (first, second) =>
                first.puzzleNumber.compareTo(second.puzzleNumber),
          );

    return laterScenarios.firstOrNull?.puzzleNumber;
  }

  Future<void> _openPause(
    BuildContext context,
    GameplayController controller,
  ) async {
    controller.pauseTimer();
    await context.push(AppRoutePaths.pause);
    if (context.mounted && !controller.isSolved) {
      controller.startTimer();
    }
  }

  Future<void> _openHowToPlay(
    BuildContext context,
    GameplayController controller,
  ) async {
    controller.pauseTimer();
    await context.push('${AppRoutePaths.howToPlay}?from=gameplay');
    if (context.mounted && !controller.isSolved) {
      controller.startTimer();
    }
  }

  String _formatTime(Duration duration) {
    final minutes = duration.inMinutes
        .remainder(100)
        .toString()
        .padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }
}

class _GameplayLoading extends StatelessWidget {
  const _GameplayLoading();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ArcadeBackdrop(
        backgroundAsset: _gameplayBackgroundAsset,
        child: Center(child: CircularProgressIndicator(color: AppTheme.white)),
      ),
    );
  }
}

class _GameplayError extends StatelessWidget {
  const _GameplayError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final strings = context.t.gameplay;

    return Scaffold(
      body: ArcadeBackdrop(
        backgroundAsset: _gameplayBackgroundAsset,
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ArcadeTitle(
                    text: strings.loadFailed.toUpperCase(),
                    fontSize: 36,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.white,
                      shadows: Theme.of(
                        context,
                      ).extension<ZigloomGameTheme>()?.textShadow,
                    ),
                  ),
                  const SizedBox(height: 22),
                  ArcadeGlossyButton(
                    label: strings.retry.toUpperCase(),
                    onPressed: onRetry,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
