import 'package:example_template/common/widgets/arcade_widgets.dart';
import 'package:example_template/gen/i18n/locale.dart';
import 'package:flutter/material.dart';

class GameplayControls extends StatelessWidget {
  const GameplayControls({
    super.key,
    required this.onUndo,
    required this.onReset,
    required this.onHowToPlay,
  });

  final VoidCallback? onUndo;
  final VoidCallback? onReset;
  final VoidCallback onHowToPlay;

  @override
  Widget build(BuildContext context) {
    final strings = context.t.gameplay;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ArcadeCircleButton(
          tooltip: strings.undo,
          icon: Icons.undo_rounded,
          isYellow: true,
          onPressed: onUndo,
        ),
        const SizedBox(width: 18),
        ArcadeCircleButton(
          tooltip: strings.reset,
          icon: Icons.refresh_rounded,
          onPressed: onReset,
        ),
        const SizedBox(width: 18),
        ArcadeCircleButton(
          tooltip: strings.howToPlay,
          icon: Icons.help_rounded,
          onPressed: onHowToPlay,
        ),
      ],
    );
  }
}
