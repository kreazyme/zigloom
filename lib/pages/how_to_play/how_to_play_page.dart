import 'package:example_template/common/theme.dart';
import 'package:example_template/common/widgets/arcade_widgets.dart';
import 'package:example_template/gen/i18n/locale.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HowToPlayPage extends StatelessWidget {
  const HowToPlayPage({super.key, this.fromGameplay = false});

  final bool fromGameplay;

  @override
  Widget build(BuildContext context) {
    final strings = context.t.howToPlay;

    return Scaffold(
      body: ArcadeBackdrop(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final contentWidth = constraints.maxWidth.clamp(300.0, 460.0);

              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: contentWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            ArcadeCircleButton(
                              tooltip: strings.back,
                              icon: Icons.arrow_back_rounded,
                              onPressed: () => context.pop(),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: ArcadeTitle(
                                text: strings.title.toUpperCase(),
                                fontSize: 38,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        ArcadePanel(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                strings.intro,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      color: AppTheme.white,
                                      shadows: Theme.of(context)
                                          .extension<ZigloomGameTheme>()
                                          ?.textShadow,
                                    ),
                              ),
                              const SizedBox(height: 20),
                              const Center(child: _ExampleBoard()),
                              const SizedBox(height: 22),
                              _RuleSection(
                                title: strings.rulesTitle,
                                items: [
                                  strings.ruleStart,
                                  strings.ruleOrder,
                                  strings.ruleMove,
                                  strings.ruleCover,
                                ],
                              ),
                              const SizedBox(height: 18),
                              _RuleSection(
                                title: strings.avoidTitle,
                                items: [
                                  strings.avoidGaps,
                                  strings.avoidRepeats,
                                  strings.avoidDiagonal,
                                  strings.avoidEarlyNumber,
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (fromGameplay) ...[
                          const SizedBox(height: 18),
                          ArcadeGlossyButton(
                            label: strings.backToPuzzle.toUpperCase(),
                            icon: Icons.play_arrow_rounded,
                            onPressed: () => context.pop(),
                          ),
                        ],
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
}

class _ExampleBoard extends StatelessWidget {
  const _ExampleBoard();

  static const _cells = ['1', '', '', '', '', '', '3', '', '2'];
  static const _pathIndexes = {0, 1, 2, 3, 4, 5, 6, 7, 8};

  @override
  Widget build(BuildContext context) {
    final gameTheme = Theme.of(context).extension<ZigloomGameTheme>()!;

    return Container(
      width: 174,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppTheme.inkBlue.withValues(alpha: 0.42),
        borderRadius: BorderRadius.circular(AppTheme.panelRadius),
        border: Border.all(color: AppTheme.white, width: 2),
        boxShadow: gameTheme.tileShadow.take(1).toList(),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _cells.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        itemBuilder: (context, index) {
          final label = _cells[index];
          final isPath = _pathIndexes.contains(index);

          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isPath
                  ? AppTheme.starYellow
                  : AppTheme.white.withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(AppTheme.boardCellRadius),
              border: Border.all(color: AppTheme.blueDeep, width: 2),
            ),
            child: label.isEmpty
                ? Icon(
                    Icons.circle_rounded,
                    color: isPath ? AppTheme.actionRed : AppTheme.blueBase,
                    size: 12,
                  )
                : Text(
                    label,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.inkBlue,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
          );
        },
      ),
    );
  }
}

class _RuleSection extends StatelessWidget {
  const _RuleSection({required this.title, required this.items});

  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gameTheme = theme.extension<ZigloomGameTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: theme.textTheme.titleMedium?.copyWith(
            color: AppTheme.starYellow,
            shadows: gameTheme.textShadow,
          ),
        ),
        const SizedBox(height: 10),
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: AppTheme.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppTheme.white,
                      shadows: gameTheme.textShadow,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
