import 'package:example_template/common/theme.dart';
import 'package:example_template/gen/i18n/locale.dart';
import 'package:example_template/helper/shared_pref_helper.dart';
import 'package:example_template/models/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/legacy.dart';

final appSettingsProvider = StateProvider<AppSettings>(
  (ref) => AppSettings.defaults(),
);

final themeProvider = StateProvider<ThemeData>((ref) {
  final settings = ref.watch(appSettingsProvider);

  return settings.themePreference == AppThemePreference.dark
      ? AppTheme.darkTheme
      : AppTheme.lightTheme;
});

Future<AppSettings> loadAppSettings(SharedPrefHelper prefs) async {
  final defaults = AppSettings.defaults();
  final themePreferenceValue = await prefs.themePreference.getData();
  final localeValue = await prefs.locale.getData();

  return defaults.copyWith(
    themePreference: AppThemePreference.values.firstWhere(
      (preference) => preference.name == themePreferenceValue,
      orElse: () => defaults.themePreference,
    ),
    soundEnabled: await prefs.soundEnabled.getData() ?? defaults.soundEnabled,
    hapticsEnabled:
        await prefs.hapticsEnabled.getData() ?? defaults.hapticsEnabled,
    locale: AppLocale.values.firstWhere(
      (locale) => locale.languageCode == localeValue,
      orElse: () => defaults.locale,
    ),
  );
}
