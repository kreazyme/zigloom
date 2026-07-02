import 'package:example_template/gen/i18n/locale.dart';
import 'package:flutter/material.dart';

enum AppThemePreference { system, light, dark }

class AppSettings {
  const AppSettings({
    required this.themePreference,
    required this.soundEnabled,
    required this.hapticsEnabled,
    required this.locale,
  });

  factory AppSettings.defaults() {
    return const AppSettings(
      themePreference: AppThemePreference.system,
      soundEnabled: true,
      hapticsEnabled: true,
      locale: AppLocale.en,
    );
  }

  final AppThemePreference themePreference;
  final bool soundEnabled;
  final bool hapticsEnabled;
  final AppLocale locale;

  ThemeMode get themeMode {
    return switch (themePreference) {
      AppThemePreference.system => ThemeMode.system,
      AppThemePreference.light => ThemeMode.light,
      AppThemePreference.dark => ThemeMode.dark,
    };
  }

  AppSettings copyWith({
    AppThemePreference? themePreference,
    bool? soundEnabled,
    bool? hapticsEnabled,
    AppLocale? locale,
  }) {
    return AppSettings(
      themePreference: themePreference ?? this.themePreference,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      hapticsEnabled: hapticsEnabled ?? this.hapticsEnabled,
      locale: locale ?? this.locale,
    );
  }
}
