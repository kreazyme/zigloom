import 'package:example_template/common/app_router.dart';
import 'package:example_template/common/theme.dart';
import 'package:example_template/common/widgets/arcade_widgets.dart';
import 'package:example_template/data/game_scenarios.dart';
import 'package:example_template/gen/i18n/locale.dart';
import 'package:example_template/models/game_scenario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GameListPage extends ConsumerWidget {
  const GameListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scenariosValue = ref.watch(gameScenariosProvider);

    return scenariosValue.when(
      data: (scenarios) => _GameListContent(scenarios: scenarios),
      loading: () => const _GameListLoading(),
      error: (error, _) => _GameListError(
        message: error.toString(),
        onRetry: () => ref.invalidate(gameScenariosProvider),
      ),
    );
  }
}

class _GameListContent extends StatelessWidget {
  const _GameListContent({required this.scenarios});

  final List<GameScenario> scenarios;

  @override
  Widget build(BuildContext context) {
    final strings = context.t.gameList;
    final sortedScenarios = [...scenarios]
      ..sort(
        (first, second) => first.puzzleNumber.compareTo(second.puzzleNumber),
      );
    final currentPuzzleNumber = sortedScenarios.first.puzzleNumber;

    return Scaffold(
      body: ArcadeBackdrop(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth.clamp(300.0, 660.0);
              final crossAxisCount = constraints.maxWidth >= 560 ? 5 : 3;

              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: width),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ArcadeCircleButton(
                              tooltip: strings.back,
                              icon: Icons.arrow_back_rounded,
                              onPressed: () => context.go(AppRoutePaths.home),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ArcadeTitle(
                                text: strings.title.toUpperCase(),
                                fontSize: constraints.maxWidth >= 560 ? 50 : 42,
                              ),
                            ),
                            const SizedBox(width: 12),
                            ArcadeCircleButton(
                              tooltip: strings.pauseDemo,
                              icon: Icons.pause_rounded,
                              isYellow: true,
                              onPressed: () =>
                                  context.push(AppRoutePaths.pause),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        _ProgressStrip(
                          solvedCount: 0,
                          totalCount: sortedScenarios.length,
                          nextPuzzleNumber: currentPuzzleNumber,
                        ),
                        const SizedBox(height: 22),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: sortedScenarios.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                mainAxisExtent: 104,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 12,
                              ),
                          itemBuilder: (context, index) {
                            final scenario = sortedScenarios[index];

                            return Center(
                              child: ArcadeLevelTile(
                                number: scenario.puzzleNumber,
                                state: index == 0
                                    ? ArcadeLevelTileState.current
                                    : ArcadeLevelTileState.available,
                                onPressed: () => context.push(
                                  AppRoutePaths.gameplayPuzzle(
                                    scenario.puzzleNumber,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 18),
                        Text(
                          _formatNumber(strings.ready, currentPuzzleNumber),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: AppTheme.white,
                                shadows: Theme.of(
                                  context,
                                ).extension<ZigloomGameTheme>()?.textShadow,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  static String _formatNumber(String template, int number) {
    return template.replaceAll('{number}', number.toString());
  }
}

class _GameListLoading extends StatelessWidget {
  const _GameListLoading();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ArcadeBackdrop(
        child: Center(child: CircularProgressIndicator(color: AppTheme.white)),
      ),
    );
  }
}

class _GameListError extends StatelessWidget {
  const _GameListError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final strings = context.t.gameList;

    return Scaffold(
      body: ArcadeBackdrop(
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

class _ProgressStrip extends StatelessWidget {
  const _ProgressStrip({
    required this.solvedCount,
    required this.totalCount,
    required this.nextPuzzleNumber,
  });

  final int solvedCount;
  final int totalCount;
  final int nextPuzzleNumber;

  @override
  Widget build(BuildContext context) {
    final strings = context.t.gameList;

    return ArcadePanel(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Text(
              strings.solvedProgress
                  .replaceAll('{solved}', solvedCount.toString())
                  .replaceAll('{total}', totalCount.toString()),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppTheme.white,
                shadows: Theme.of(
                  context,
                ).extension<ZigloomGameTheme>()?.textShadow,
              ),
            ),
          ),
          Text(
            strings.nextPuzzle.replaceAll(
              '{number}',
              nextPuzzleNumber.toString(),
            ),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppTheme.starYellow,
              shadows: Theme.of(
                context,
              ).extension<ZigloomGameTheme>()?.textShadow,
            ),
          ),
        ],
      ),
    );
  }
}
