import 'package:example_template/common/app_router.dart';
import 'package:example_template/common/theme.dart';
import 'package:example_template/common/widgets/arcade_widgets.dart';
import 'package:example_template/gen/i18n/locale.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PausePage extends StatefulWidget {
  const PausePage({super.key});

  @override
  State<PausePage> createState() => _PausePageState();
}

class _PausePageState extends State<PausePage> {
  static const _puzzleNumber = 13;

  bool _isConfirmingReset = false;

  @override
  Widget build(BuildContext context) {
    final strings = context.t.pause;

    return Scaffold(
      body: ArcadeBackdrop(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(28, 22, 28, 28),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 180),
                  child: _isConfirmingReset
                      ? _ResetConfirm(
                          key: const ValueKey('reset'),
                          puzzleNumber: _puzzleNumber,
                          onCancel: () =>
                              setState(() => _isConfirmingReset = false),
                          onConfirm: () {
                            setState(() => _isConfirmingReset = false);
                            _showComingSoon(context, strings.replayPuzzle);
                          },
                        )
                      : _PauseMenu(
                          key: const ValueKey('menu'),
                          puzzleNumber: _puzzleNumber,
                          onResume: () => context.canPop()
                              ? context.pop()
                              : _showComingSoon(context, strings.resume),
                          onReset: () =>
                              setState(() => _isConfirmingReset = true),
                          onSettings: () =>
                              _showComingSoon(context, strings.settings),
                          onHome: () => context.go(AppRoutePaths.home),
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context, String action) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            context.t.pause.comingSoon.replaceAll('{action}', action),
          ),
        ),
      );
  }
}

class _PauseMenu extends StatelessWidget {
  const _PauseMenu({
    super.key,
    required this.puzzleNumber,
    required this.onResume,
    required this.onReset,
    required this.onSettings,
    required this.onHome,
  });

  final int puzzleNumber;
  final VoidCallback onResume;
  final VoidCallback onReset;
  final VoidCallback onSettings;
  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    final strings = context.t.pause;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ArcadeTitle(text: _formatNumber(strings.puzzle, puzzleNumber)),
        const SizedBox(height: 10),
        Text(
          strings.paused,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppTheme.white,
            shadows: Theme.of(
              context,
            ).extension<ZigloomGameTheme>()?.textShadow,
          ),
        ),
        const SizedBox(height: 34),
        ArcadeGlossyButton(
          label: strings.resume.toUpperCase(),
          icon: Icons.play_arrow_rounded,
          onPressed: onResume,
        ),
        const SizedBox(height: 16),
        ArcadeGlossyButton(
          label: strings.replay.toUpperCase(),
          icon: Icons.replay_rounded,
          isSecondary: true,
          onPressed: onReset,
        ),
        const SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ArcadeCircleButton(
              tooltip: strings.settings,
              icon: Icons.settings_rounded,
              onPressed: onSettings,
            ),
            const SizedBox(width: 18),
            ArcadeCircleButton(
              tooltip: strings.returnHome,
              icon: Icons.home_rounded,
              onPressed: onHome,
            ),
          ],
        ),
      ],
    );
  }

  static String _formatNumber(String template, int number) {
    return template.replaceAll('{number}', number.toString());
  }
}

class _ResetConfirm extends StatelessWidget {
  const _ResetConfirm({
    super.key,
    required this.puzzleNumber,
    required this.onCancel,
    required this.onConfirm,
  });

  final int puzzleNumber;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final strings = context.t.pause;

    return ArcadePanel(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ArcadeTitle(text: strings.replayQuestion, fontSize: 38),
          const SizedBox(height: 18),
          Text(
            strings.replayDescription.replaceAll(
              '{number}',
              puzzleNumber.toString(),
            ),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppTheme.white,
              shadows: Theme.of(
                context,
              ).extension<ZigloomGameTheme>()?.textShadow,
            ),
          ),
          const SizedBox(height: 28),
          ArcadeGlossyButton(
            label: strings.replayPuzzle.toUpperCase(),
            icon: Icons.replay_rounded,
            onPressed: onConfirm,
          ),
          const SizedBox(height: 14),
          ArcadeGlossyButton(
            label: strings.cancel.toUpperCase(),
            icon: Icons.close_rounded,
            isSecondary: true,
            onPressed: onCancel,
          ),
        ],
      ),
    );
  }
}
