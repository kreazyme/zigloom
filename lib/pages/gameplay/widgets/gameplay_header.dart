import 'package:example_template/common/theme.dart';
import 'package:example_template/common/widgets/arcade_widgets.dart';
import 'package:example_template/gen/i18n/locale.dart';
import 'package:flutter/material.dart';

class GameplayHeader extends StatelessWidget {
  const GameplayHeader({
    super.key,
    required this.puzzleLabel,
    required this.timer,
    required this.movesLabel,
    required this.onPause,
  });

  final String puzzleLabel;
  final String timer;
  final String movesLabel;
  final VoidCallback onPause;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
      color: AppTheme.white,
      shadows: Theme.of(context).extension<ZigloomGameTheme>()?.textShadow,
    );

    return Row(
      children: [
        _TimerBadge(label: timer),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            children: [
              ArcadeTitle(text: puzzleLabel.toUpperCase(), fontSize: 34),
              const SizedBox(height: 4),
              Text(movesLabel, style: textStyle),
            ],
          ),
        ),
        const SizedBox(width: 12),
        ArcadeCircleButton(
          tooltip: context.t.gameplay.pause,
          icon: Icons.pause_rounded,
          onPressed: onPause,
        ),
      ],
    );
  }
}

class _TimerBadge extends StatelessWidget {
  const _TimerBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final gameTheme = Theme.of(context).extension<ZigloomGameTheme>()!;

    return Container(
      height: 48,
      constraints: const BoxConstraints(minWidth: 78),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        gradient: gameTheme.blueGloss,
        borderRadius: BorderRadius.circular(AppTheme.buttonRadius),
        border: Border.all(color: AppTheme.white, width: 2),
        boxShadow: gameTheme.buttonShadow,
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppTheme.white,
          shadows: gameTheme.textShadow,
        ),
      ),
    );
  }
}
