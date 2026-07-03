import 'package:example_template/common/app_router.dart';
import 'package:example_template/common/theme.dart';
import 'package:example_template/common/widgets/arcade_widgets.dart';
import 'package:example_template/gen/i18n/locale.dart';
import 'package:example_template/providers/local_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends ConsumerWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = context.t.onboarding;
    final theme = Theme.of(context);

    return Scaffold(
      body: ArcadeBackdrop(
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
                        const SizedBox(height: 8),
                        Column(
                          children: [
                            ArcadeTitle(text: strings.title, fontSize: 52),
                            const SizedBox(height: 28),
                            Text(
                              strings.headline,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headlineMedium?.copyWith(
                                color: AppTheme.white,
                                shadows: theme
                                    .extension<ZigloomGameTheme>()
                                    ?.textShadow,
                              ),
                            ),
                            const SizedBox(height: 22),
                            const _ExampleBoard(),
                            const SizedBox(height: 24),
                            Text(
                              strings.description,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: AppTheme.white,
                                height: 1.25,
                                shadows: theme
                                    .extension<ZigloomGameTheme>()
                                    ?.textShadow,
                              ),
                            ),
                            const SizedBox(height: 30),
                            ArcadeGlossyButton(
                              label: strings.startPuzzle.toUpperCase(),
                              icon: Icons.play_arrow_rounded,
                              onPressed: () => _startPuzzle(context, ref),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Wrap(
                          alignment: WrapAlignment.center,
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

  Future<void> _startPuzzle(BuildContext context, WidgetRef ref) async {
    await ref.read(localDataProvider).onboarding.saveData(true);

    if (context.mounted) {
      context.go(AppRoutePaths.gameplayPuzzle(1));
    }
  }
}

class _ExampleBoard extends StatelessWidget {
  const _ExampleBoard();

  static const _cells = ['1', '', '', '', '', '', '3', '', '2'];
  static const _path = [
    Offset(0.5, 0.5),
    Offset(1.5, 0.5),
    Offset(2.5, 0.5),
    Offset(2.5, 1.5),
    Offset(2.5, 2.5),
    Offset(1.5, 2.5),
    Offset(0.5, 2.5),
  ];

  @override
  Widget build(BuildContext context) {
    final gameTheme = Theme.of(context).extension<ZigloomGameTheme>()!;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.panelRadius),
        boxShadow: gameTheme.tileShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppTheme.panelRadius),
        child: SizedBox.square(
          dimension: 210,
          child: Stack(
            children: [
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                ),
                itemCount: _cells.length,
                itemBuilder: (context, index) {
                  final value = _cells[index];

                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppTheme.white.withValues(alpha: 0.9),
                    ),
                    child: Center(
                      child: value.isEmpty
                          ? null
                          : Text(
                              value,
                              style: Theme.of(context).textTheme.displayMedium
                                  ?.copyWith(
                                    color: AppTheme.inkBlue,
                                    fontSize: 34,
                                    shadows: const [],
                                  ),
                            ),
                    ),
                  );
                },
              ),
              CustomPaint(
                size: const Size.square(210),
                painter: _ExamplePathPainter(points: _path),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExamplePathPainter extends CustomPainter {
  const _ExamplePathPainter({required this.points});

  final List<Offset> points;

  @override
  void paint(Canvas canvas, Size size) {
    final cellSize = size.width / 3;
    final path = Path();

    for (var index = 0; index < points.length; index += 1) {
      final point = points[index];
      final offset = Offset(point.dx * cellSize, point.dy * cellSize);

      if (index == 0) {
        path.moveTo(offset.dx, offset.dy);
      } else {
        path.lineTo(offset.dx, offset.dy);
      }
    }

    final shadowPaint = Paint()
      ..color = AppTheme.inkBlue.withValues(alpha: 0.28)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 20;
    final pathPaint = Paint()
      ..color = AppTheme.blueBase.withValues(alpha: 0.82)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 14;

    canvas.drawPath(path, shadowPaint);
    canvas.drawPath(path, pathPaint);
  }

  @override
  bool shouldRepaint(covariant _ExamplePathPainter oldDelegate) {
    return oldDelegate.points != points;
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: AppTheme.white,
          shadows: Theme.of(context).extension<ZigloomGameTheme>()?.textShadow,
        ),
      ),
    );
  }
}
