import 'package:example_template/common/app_router.dart';
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
    onboarding.saveData(true);
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
    return Scaffold(body: Center(child: Text('Splash Page')));
  }
}
