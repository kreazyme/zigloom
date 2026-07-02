import 'package:example_template/common/theme.dart';
import 'package:example_template/gen/i18n/locale.dart';
import 'package:example_template/pages/gameplay/gameplay_controller.dart';
import 'package:flutter/material.dart';

class GameplayStatus extends StatelessWidget {
  const GameplayStatus({super.key, required this.controller});

  final GameplayController controller;

  @override
  Widget build(BuildContext context) {
    final strings = context.t.gameplay;
    final text = controller.isSolved
        ? strings.solved
        : controller.invalidPoint != null
        ? strings.invalidMove
        : strings.nextClue.replaceAll(
            '{number}',
            controller.nextRequiredNumber.toString(),
          );
    final color = controller.isSolved ? AppTheme.starYellow : AppTheme.white;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 160),
      child: Text(
        text,
        key: ValueKey(text),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: color,
          shadows: Theme.of(context).extension<ZigloomGameTheme>()?.textShadow,
        ),
      ),
    );
  }
}
