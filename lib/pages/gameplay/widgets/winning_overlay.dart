import 'dart:math' as math;

import 'package:example_template/common/theme.dart';
import 'package:example_template/common/widgets/arcade_widgets.dart';
import 'package:example_template/gen/i18n/locale.dart';
import 'package:flutter/material.dart';

class WinningOverlay extends StatefulWidget {
  const WinningOverlay({
    super.key,
    required this.time,
    required this.moves,
    required this.nextPuzzleNumber,
    required this.onChooseLevel,
    required this.onReplay,
    this.onNextLevel,
  });

  final String time;
  final int moves;
  final int? nextPuzzleNumber;
  final VoidCallback onChooseLevel;
  final VoidCallback onReplay;
  final VoidCallback? onNextLevel;

  @override
  State<WinningOverlay> createState() => _WinningOverlayState();
}

class _WinningOverlayState extends State<WinningOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _panelScale;
  late final Animation<double> _panelOpacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
    )..forward();
    _panelScale = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.12, 0.48, curve: Curves.elasticOut),
    );
    _panelOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.2, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.t.gameplay;
    final theme = Theme.of(context);

    return Positioned.fill(
      child: Semantics(
        scopesRoute: true,
        namesRoute: true,
        explicitChildNodes: true,
        label: strings.winTitle,
        child: Material(
          color: Colors.transparent,
          child: Stack(
            fit: StackFit.expand,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: AppTheme.inkBlue.withValues(alpha: 0.5),
                ),
              ),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  return CustomPaint(
                    painter: _WinConfettiPainter(progress: _controller.value),
                  );
                },
              ),
              SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(22),
                    child: FadeTransition(
                      opacity: _panelOpacity,
                      child: ScaleTransition(
                        scale: _panelScale,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 420),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFFFFEF5B),
                                  AppTheme.starYellow,
                                  AppTheme.starOrange,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(
                                AppTheme.panelRadius,
                              ),
                              border: Border.all(
                                color: AppTheme.white,
                                width: 3,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xFF8C2C00),
                                  offset: Offset(0, 7),
                                ),
                                BoxShadow(
                                  color: Color(0x66031B64),
                                  blurRadius: 22,
                                  offset: Offset(0, 12),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                20,
                                22,
                                20,
                                18,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const _WinMedal(),
                                  const SizedBox(height: 12),
                                  ArcadeTitle(
                                    text: strings.winTitle.toUpperCase(),
                                    fontSize: 38,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    strings.winMessage,
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(
                                          color: AppTheme.inkBlue,
                                          height: 1.18,
                                        ),
                                  ),
                                  const SizedBox(height: 18),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _WinStat(
                                          label: strings.winTime,
                                          value: widget.time,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: _WinStat(
                                          label: strings.winMoves,
                                          value: widget.moves.toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 18),
                                  if (widget.nextPuzzleNumber != null) ...[
                                    ArcadeGlossyButton(
                                      label: strings.nextLevel.toUpperCase(),
                                      icon: Icons.arrow_forward_rounded,
                                      onPressed: widget.onNextLevel,
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                  ArcadeGlossyButton(
                                    label: strings.chooseLevel.toUpperCase(),
                                    icon: Icons.grid_view_rounded,
                                    isSecondary:
                                        widget.nextPuzzleNumber != null,
                                    onPressed: widget.onChooseLevel,
                                  ),
                                  const SizedBox(height: 10),
                                  ArcadeGlossyButton(
                                    label: strings.playAgain.toUpperCase(),
                                    icon: Icons.replay_rounded,
                                    isSecondary: true,
                                    onPressed: widget.onReplay,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WinMedal extends StatelessWidget {
  const _WinMedal();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: Theme.of(context).extension<ZigloomGameTheme>()!.starGloss,
        border: Border.all(color: AppTheme.white, width: 3),
        boxShadow: const [
          BoxShadow(color: Color(0xFFB56B00), offset: Offset(0, 4)),
        ],
      ),
      child: const Icon(
        Icons.star_rounded,
        color: AppTheme.actionRed,
        size: 42,
      ),
    );
  }
}

class _WinStat extends StatelessWidget {
  const _WinStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppTheme.white.withValues(alpha: 0.86),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppTheme.inkBlue.withValues(alpha: 0.16),
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
        child: Column(
          children: [
            Text(
              label.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelMedium?.copyWith(
                color: AppTheme.blueDeep,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleLarge?.copyWith(
                color: AppTheme.inkBlue,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WinConfettiPainter extends CustomPainter {
  const _WinConfettiPainter({required this.progress});

  final double progress;

  static const _colors = [
    AppTheme.starYellow,
    AppTheme.actionOrange,
    AppTheme.actionRed,
    AppTheme.blueHighlight,
    AppTheme.white,
    AppTheme.successGreen,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final burst = Curves.easeOutCubic.transform(progress.clamp(0, 1));
    final fall = Curves.easeIn.transform(progress.clamp(0, 1));
    final center = Offset(size.width / 2, size.height * 0.38);
    final paint = Paint();

    for (var index = 0; index < 72; index += 1) {
      final angle = (index / 72) * math.pi * 2;
      final lane = 0.52 + (index % 7) * 0.095;
      final distance = size.shortestSide * lane * burst;
      final drift = math.sin(progress * math.pi * 2 + index) * 18;
      final position = Offset(
        center.dx + math.cos(angle) * distance + drift,
        center.dy +
            math.sin(angle) * distance * 0.68 +
            fall * fall * size.height * 0.46,
      );

      if (position.dy > size.height + 30) {
        continue;
      }

      paint.color = _colors[index % _colors.length].withValues(
        alpha: (1 - progress * 0.18).clamp(0.0, 1.0),
      );
      canvas.save();
      canvas.translate(position.dx, position.dy);
      canvas.rotate(angle + progress * math.pi * (2 + index % 3));

      if (index % 5 == 0) {
        canvas.drawCircle(Offset.zero, 4 + (index % 3), paint);
      } else {
        final width = 7.0 + (index % 4) * 2;
        final height = index % 3 == 0 ? width : width * 0.55;
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset.zero, width: width, height: height),
            const Radius.circular(2),
          ),
          paint,
        );
      }
      canvas.restore();
    }

    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..color = AppTheme.white.withValues(
        alpha: (1 - progress).clamp(0.0, 0.58),
      );
    canvas.drawCircle(center, size.shortestSide * 0.42 * burst, ringPaint);
  }

  @override
  bool shouldRepaint(covariant _WinConfettiPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
