import 'package:example_template/common/app_router.dart';
import 'package:example_template/common/theme.dart';
import 'package:example_template/gen/i18n/locale.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const _progress = _HomeProgress(
    solvedPuzzleCount: 12,
    totalPuzzleCount: 120,
    highestUnlockedPuzzleNumber: 13,
    inProgressPuzzleNumber: null,
    hasCompletedOnboarding: true,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.t.home;
    final progress = _progress;

    return Scaffold(
      body: _HomeBackdrop(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final contentWidth = constraints.maxWidth.clamp(280.0, 420.0);

              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 18, 24, 22),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 40,
                      maxWidth: contentWidth,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: _CircleActionButton(
                            tooltip: strings.settings,
                            icon: Icons.settings_rounded,
                            onPressed: () =>
                                _showComingSoon(context, strings.settings),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Column(
                          children: [
                            _OutlinedTitle(text: strings.title),
                            const SizedBox(height: 8),
                            Text(
                              strings.subtitle,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: AppTheme.white,
                                shadows: theme
                                    .extension<ZigloomGameTheme>()
                                    ?.textShadow,
                              ),
                            ),
                            const SizedBox(height: 26),
                            _ProgressPanel(progress: progress),
                            if (progress.inProgressPuzzleNumber != null) ...[
                              const SizedBox(height: 16),
                              Text(
                                _formatNumber(
                                  strings.inProgress,
                                  progress.inProgressPuzzleNumber!,
                                ),
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: AppTheme.white,
                                  shadows: theme
                                      .extension<ZigloomGameTheme>()
                                      ?.textShadow,
                                ),
                              ),
                            ],
                            const SizedBox(height: 34),
                            _GlossyButton(
                              label: strings.play.toUpperCase(),
                              onPressed: () =>
                                  context.push(AppRoutePaths.gameList),
                            ),
                            const SizedBox(height: 16),
                            _GlossyButton(
                              label: strings.howToPlay.toUpperCase(),
                              isSecondary: true,
                              onPressed: () =>
                                  _showComingSoon(context, strings.howToPlay),
                            ),
                          ],
                        ),
                        const SizedBox(height: 36),
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 18,
                          runSpacing: 8,
                          children: [
                            _FooterLink(
                              label: strings.privacyPolicy,
                              onPressed: () =>
                                  context.push(AppRoutePaths.policy),
                            ),
                            _FooterLink(
                              label: strings.terms,
                              onPressed: () =>
                                  context.push(AppRoutePaths.terms),
                            ),
                          ],
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

  void _showComingSoon(BuildContext context, String screenName) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            context.t.home.comingSoon.replaceAll('{screen}', screenName),
          ),
        ),
      );
  }

  static String _formatNumber(String template, int number) {
    return template.replaceAll('{number}', number.toString());
  }
}

class _HomeProgress {
  const _HomeProgress({
    required this.solvedPuzzleCount,
    required this.totalPuzzleCount,
    required this.highestUnlockedPuzzleNumber,
    this.inProgressPuzzleNumber,
    this.hasCompletedOnboarding = true,
  });

  final int solvedPuzzleCount;
  final int totalPuzzleCount;
  final int highestUnlockedPuzzleNumber;
  final int? inProgressPuzzleNumber;
  final bool hasCompletedOnboarding;

  bool get isFirstTime => !hasCompletedOnboarding && solvedPuzzleCount == 0;
  bool get isComplete => solvedPuzzleCount >= totalPuzzleCount;
}

class _HomeBackdrop extends StatelessWidget {
  const _HomeBackdrop({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1397D8), AppTheme.cyanPale],
        ),
      ),
      child: child,
    );
  }
}

class _OutlinedTitle extends StatelessWidget {
  const _OutlinedTitle({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final baseStyle =
        Theme.of(context).textTheme.displayLarge ??
        const TextStyle(fontSize: 52, fontWeight: FontWeight.w900);

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Stack(
        children: [
          Text(
            text,
            style: baseStyle.copyWith(
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 7
                ..color = AppTheme.inkBlue,
              shadows: const [
                Shadow(
                  color: AppTheme.blueDeep,
                  blurRadius: 0,
                  offset: Offset(4, 5),
                ),
              ],
            ),
          ),
          Text(
            text,
            style: baseStyle.copyWith(
              color: AppTheme.white,
              shadows: const [
                Shadow(
                  color: AppTheme.blueHighlight,
                  blurRadius: 0,
                  offset: Offset(0, -1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressPanel extends StatelessWidget {
  const _ProgressPanel({required this.progress});

  final _HomeProgress progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gameTheme = theme.extension<ZigloomGameTheme>()!;
    final strings = context.t.home;
    final title = progress.isFirstTime
        ? strings.readyToStart
        : strings.solvedProgress
              .replaceAll('{solved}', progress.solvedPuzzleCount.toString())
              .replaceAll('{total}', progress.totalPuzzleCount.toString());
    final subtitle = progress.isFirstTime
        ? _formatNumber(strings.puzzleNumber, 1)
        : progress.isComplete
        ? strings.allPuzzlesDone
        : progress.inProgressPuzzleNumber != null
        ? _formatNumber(strings.puzzleOpen, progress.inProgressPuzzleNumber!)
        : _formatNumber(
            strings.nextPuzzle,
            progress.highestUnlockedPuzzleNumber,
          );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
      decoration: BoxDecoration(
        gradient: gameTheme.blueGloss,
        borderRadius: BorderRadius.circular(AppTheme.panelRadius),
        border: Border.all(
          color: AppTheme.white.withValues(alpha: 0.72),
          width: 2,
        ),
        boxShadow: gameTheme.tileShadow,
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge?.copyWith(
              color: AppTheme.white,
              shadows: gameTheme.textShadow,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              color: AppTheme.white,
              shadows: gameTheme.textShadow,
            ),
          ),
        ],
      ),
    );
  }

  static String _formatNumber(String template, int number) {
    return template.replaceAll('{number}', number.toString());
  }
}

class _GlossyButton extends StatefulWidget {
  const _GlossyButton({
    required this.label,
    required this.onPressed,
    this.isSecondary = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isSecondary;

  @override
  State<_GlossyButton> createState() => _GlossyButtonState();
}

class _GlossyButtonState extends State<_GlossyButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gameTheme = theme.extension<ZigloomGameTheme>()!;
    final borderColor = widget.isSecondary
        ? AppTheme.cyanPale
        : AppTheme.white.withValues(alpha: 0.86);

    return Semantics(
      button: true,
      label: widget.label,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 90),
        scale: _isPressed ? 0.98 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 90),
          transform: Matrix4.translationValues(0, _isPressed ? 4 : 0, 0),
          decoration: BoxDecoration(
            gradient: gameTheme.blueGloss,
            borderRadius: BorderRadius.circular(AppTheme.buttonRadius),
            border: Border.all(color: borderColor, width: 2),
            boxShadow: _isPressed
                ? gameTheme.buttonShadow.take(1).toList()
                : gameTheme.buttonShadow,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(AppTheme.buttonRadius),
              onTap: widget.onPressed,
              onHighlightChanged: (value) {
                if (_isPressed != value) {
                  setState(() => _isPressed = value);
                }
              },
              child: SizedBox(
                width: double.infinity,
                height: widget.isSecondary ? 54 : 60,
                child: Center(
                  child: Text(
                    widget.label,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontSize: widget.isSecondary ? 15 : 18,
                      color: AppTheme.white,
                      shadows: gameTheme.textShadow,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CircleActionButton extends StatefulWidget {
  const _CircleActionButton({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  State<_CircleActionButton> createState() => _CircleActionButtonState();
}

class _CircleActionButtonState extends State<_CircleActionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final gameTheme = Theme.of(context).extension<ZigloomGameTheme>()!;

    return Tooltip(
      message: widget.tooltip,
      child: Semantics(
        button: true,
        label: widget.tooltip,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 90),
          transform: Matrix4.translationValues(0, _isPressed ? 3 : 0, 0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: gameTheme.redGloss,
            border: Border.all(color: AppTheme.white, width: 3),
            boxShadow: _isPressed
                ? gameTheme.redButtonShadow.take(1).toList()
                : gameTheme.redButtonShadow,
          ),
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: widget.onPressed,
              onHighlightChanged: (value) {
                if (_isPressed != value) {
                  setState(() => _isPressed = value);
                }
              },
              child: SizedBox.square(
                dimension: 54,
                child: Icon(widget.icon, color: AppTheme.white, size: 27),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: theme.textTheme.labelMedium?.copyWith(
          color: AppTheme.white,
          shadows: theme.extension<ZigloomGameTheme>()?.textShadow,
        ),
      ),
    );
  }
}
