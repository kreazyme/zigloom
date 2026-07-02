import 'package:example_template/common/app_router.dart';
import 'package:example_template/common/theme.dart';
import 'package:example_template/common/widgets/arcade_widgets.dart';
import 'package:example_template/gen/i18n/locale.dart';
import 'package:example_template/providers/local_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    final onboarding = ref.read(localDataProvider).onboarding;
    Future.delayed(const Duration(seconds: 2), () {
      onboarding.getData().then((isOnboarded) {
        if (!mounted) return;
        context.go(
          isOnboarded == true ? AppRoutePaths.home : AppRoutePaths.onboarding,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.t.splash;

    return Scaffold(
      body: ArcadeBackdrop(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const _SplashMark(),
                  const SizedBox(height: 30),
                  ArcadeTitle(text: strings.title, fontSize: 56),
                  const SizedBox(height: 10),
                  Text(
                    strings.subtitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.white,
                      shadows: Theme.of(
                        context,
                      ).extension<ZigloomGameTheme>()?.textShadow,
                    ),
                  ),
                  const SizedBox(height: 28),
                  const SizedBox(
                    width: 38,
                    height: 38,
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                      color: AppTheme.white,
                      backgroundColor: AppTheme.blueBase,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    strings.loading,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
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
        ),
      ),
    );
  }
}

class _SplashMark extends StatelessWidget {
  const _SplashMark();

  @override
  Widget build(BuildContext context) {
    final gameTheme = Theme.of(context).extension<ZigloomGameTheme>()!;

    return SizedBox(
      width: 172,
      height: 96,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 28,
            top: 24,
            right: 28,
            child: Container(
              height: 12,
              decoration: BoxDecoration(
                color: AppTheme.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(99),
                boxShadow: gameTheme.buttonShadow,
              ),
            ),
          ),
          Positioned(
            right: 45,
            top: 30,
            bottom: 20,
            child: Container(
              width: 12,
              decoration: BoxDecoration(
                color: AppTheme.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(99),
                boxShadow: gameTheme.buttonShadow,
              ),
            ),
          ),
          const Positioned(left: 0, top: 4, child: _MiniClueTile(number: 1)),
          const Positioned(
            right: 0,
            bottom: 0,
            child: _MiniClueTile(number: 2),
          ),
        ],
      ),
    );
  }
}

class _MiniClueTile extends StatelessWidget {
  const _MiniClueTile({required this.number});

  final int number;

  @override
  Widget build(BuildContext context) {
    final gameTheme = Theme.of(context).extension<ZigloomGameTheme>()!;

    return Container(
      width: 66,
      height: 66,
      decoration: BoxDecoration(
        gradient: gameTheme.blueGloss,
        borderRadius: BorderRadius.circular(AppTheme.tileRadius),
        border: Border.all(color: AppTheme.cyanPale, width: 2),
        boxShadow: gameTheme.tileShadow,
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontSize: 36,
            color: AppTheme.white,
            fontStyle: FontStyle.italic,
            shadows: gameTheme.textShadow,
          ),
        ),
      ),
    );
  }
}
