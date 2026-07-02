import 'dart:developer';

import 'package:example_template/pages/game_list/game_list_page.dart';
import 'package:example_template/pages/gameplay/gameplay_page.dart';
import 'package:example_template/pages/home/home_page.dart';
import 'package:example_template/pages/how_to_play/how_to_play_page.dart';
import 'package:example_template/pages/onboarding/onboarding_page.dart';
import 'package:example_template/pages/pause/pause_page.dart';
import 'package:example_template/pages/policy/policy_page.dart';
import 'package:example_template/pages/splash/splash_page.dart';
import 'package:example_template/pages/terms/terms_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutePaths {
  const AppRoutePaths._();

  static const splash = '/';
  static const onboarding = '/onboarding';
  static const home = '/home';
  static const gameList = '/game-list';
  static const gameplay = '/gameplay/:puzzleNumber';
  static const pause = '/pause';
  static const howToPlay = '/how-to-play';
  static const policy = '/policy';
  static const terms = '/terms';

  static String gameplayPuzzle(int puzzleNumber) => '/gameplay/$puzzleNumber';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutePaths.splash,
  observers: [AppNavigatorObserver()],
  routes: [
    GoRoute(
      path: AppRoutePaths.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoutePaths.onboarding,
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: AppRoutePaths.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoutePaths.gameList,
      builder: (context, state) => const GameListPage(),
    ),
    GoRoute(
      path: AppRoutePaths.gameplay,
      builder: (context, state) {
        final puzzleNumber =
            int.tryParse(state.pathParameters['puzzleNumber'] ?? '') ?? 13;

        return GameplayPage(puzzleNumber: puzzleNumber);
      },
    ),
    GoRoute(
      path: AppRoutePaths.pause,
      builder: (context, state) => const PausePage(),
    ),
    GoRoute(
      path: AppRoutePaths.howToPlay,
      builder: (context, state) {
        final fromGameplay = state.uri.queryParameters['from'] == 'gameplay';

        return HowToPlayPage(fromGameplay: fromGameplay);
      },
    ),
    GoRoute(
      path: AppRoutePaths.policy,
      builder: (context, state) => const PolicyPage(),
    ),
    GoRoute(
      path: AppRoutePaths.terms,
      builder: (context, state) => const TermsOfServicePage(),
    ),
  ],
);

class AppNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    log('Navigated to ${route.settings.name ?? route.settings.arguments}');
  }
}
