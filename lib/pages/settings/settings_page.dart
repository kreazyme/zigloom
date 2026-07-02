import 'dart:async';

import 'package:example_template/common/app_router.dart';
import 'package:example_template/common/theme.dart';
import 'package:example_template/common/widgets/arcade_widgets.dart';
import 'package:example_template/gen/i18n/locale.dart';
import 'package:example_template/helper/shared_pref_helper.dart';
import 'package:example_template/models/app_settings.dart';
import 'package:example_template/providers/local_data_provider.dart';
import 'package:example_template/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = context.t.settings;
    final settings = ref.watch(appSettingsProvider);

    return Scaffold(
      body: ArcadeBackdrop(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final contentWidth = constraints.maxWidth.clamp(300.0, 460.0);

              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: contentWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            ArcadeCircleButton(
                              tooltip: strings.back,
                              icon: Icons.arrow_back_rounded,
                              onPressed: () => context.pop(),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: ArcadeTitle(
                                text: strings.title.toUpperCase(),
                                fontSize: 40,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        _SectionLabel(label: strings.appearance),
                        const SizedBox(height: 8),
                        ArcadePanel(
                          child: _ThemeRow(
                            selected: settings.themePreference,
                            onChanged: (preference) => _saveSettings(
                              ref,
                              settings.copyWith(themePreference: preference),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _SectionLabel(label: strings.play),
                        const SizedBox(height: 8),
                        ArcadePanel(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                          child: Column(
                            children: [
                              _SwitchRow(
                                icon: Icons.volume_up_rounded,
                                inactiveIcon: Icons.volume_off_rounded,
                                label: strings.sound,
                                value: settings.soundEnabled,
                                onChanged: (value) => _saveSettings(
                                  ref,
                                  settings.copyWith(soundEnabled: value),
                                ),
                              ),
                              const _PanelDivider(),
                              _SwitchRow(
                                icon: Icons.vibration_rounded,
                                inactiveIcon: Icons.mobile_off_rounded,
                                label: strings.haptics,
                                value: settings.hapticsEnabled,
                                onChanged: (value) => _saveSettings(
                                  ref,
                                  settings.copyWith(hapticsEnabled: value),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        _SectionLabel(label: strings.language),
                        const SizedBox(height: 8),
                        ArcadePanel(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 8,
                          ),
                          child: _LocaleRow(
                            selected: settings.locale,
                            onChanged: (locale) {
                              unawaited(LocaleSettings.setLocale(locale));
                              _saveSettings(
                                ref,
                                settings.copyWith(locale: locale),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        ArcadePanel(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Column(
                            children: [
                              _NavigationRow(
                                label: strings.howToPlay,
                                icon: Icons.help_rounded,
                                onPressed: () =>
                                    context.push(AppRoutePaths.howToPlay),
                              ),
                              const _PanelDivider(horizontalPadding: 18),
                              _NavigationRow(
                                label: strings.privacyPolicy,
                                icon: Icons.privacy_tip_rounded,
                                onPressed: () =>
                                    context.push(AppRoutePaths.policy),
                              ),
                              const _PanelDivider(horizontalPadding: 18),
                              _NavigationRow(
                                label: strings.terms,
                                icon: Icons.description_rounded,
                                onPressed: () =>
                                    context.push(AppRoutePaths.terms),
                              ),
                            ],
                          ),
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

  void _saveSettings(WidgetRef ref, AppSettings settings) {
    ref.read(appSettingsProvider.notifier).state = settings;
    final prefs = ref.read(localDataProvider);

    unawaited(_persistSettings(prefs, settings));
  }

  Future<void> _persistSettings(
    SharedPrefHelper prefs,
    AppSettings settings,
  ) async {
    await Future.wait([
      prefs.themePreference.saveData(settings.themePreference.name),
      prefs.soundEnabled.saveData(settings.soundEnabled),
      prefs.hapticsEnabled.saveData(settings.hapticsEnabled),
      prefs.locale.saveData(settings.locale.languageCode),
    ]);
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: AppTheme.white,
        shadows: Theme.of(context).extension<ZigloomGameTheme>()?.textShadow,
      ),
    );
  }
}

class _ThemeRow extends StatelessWidget {
  const _ThemeRow({required this.selected, required this.onChanged});

  final AppThemePreference selected;
  final ValueChanged<AppThemePreference> onChanged;

  @override
  Widget build(BuildContext context) {
    final strings = context.t.settings;

    return Row(
      children: [
        Expanded(
          child: _SettingName(
            icon: Icons.palette_rounded,
            label: strings.theme,
            isActive: selected != AppThemePreference.system,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: _SegmentedThemeControl(
            selected: selected,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class _SegmentedThemeControl extends StatelessWidget {
  const _SegmentedThemeControl({
    required this.selected,
    required this.onChanged,
  });

  final AppThemePreference selected;
  final ValueChanged<AppThemePreference> onChanged;

  @override
  Widget build(BuildContext context) {
    final strings = context.t.settings;

    return Container(
      height: 42,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.inkBlue.withValues(alpha: 0.38),
        borderRadius: BorderRadius.circular(AppTheme.buttonRadius),
        border: Border.all(color: AppTheme.cyanPale, width: 1.5),
      ),
      child: Row(
        children: [
          _ThemeSegment(
            label: strings.system,
            isSelected: selected == AppThemePreference.system,
            onPressed: () => onChanged(AppThemePreference.system),
          ),
          _ThemeSegment(
            label: strings.light,
            isSelected: selected == AppThemePreference.light,
            onPressed: () => onChanged(AppThemePreference.light),
          ),
          _ThemeSegment(
            label: strings.dark,
            isSelected: selected == AppThemePreference.dark,
            onPressed: () => onChanged(AppThemePreference.dark),
          ),
        ],
      ),
    );
  }
}

class _ThemeSegment extends StatelessWidget {
  const _ThemeSegment({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppTheme.buttonRadius - 4),
          onTap: onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? AppTheme.starYellow : Colors.transparent,
              borderRadius: BorderRadius.circular(AppTheme.buttonRadius - 4),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label.toUpperCase(),
                maxLines: 1,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: isSelected ? AppTheme.inkBlue : AppTheme.white,
                  shadows: isSelected
                      ? null
                      : Theme.of(
                          context,
                        ).extension<ZigloomGameTheme>()?.textShadow,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SwitchRow extends StatelessWidget {
  const _SwitchRow({
    required this.icon,
    required this.inactiveIcon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final IconData inactiveIcon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final strings = context.t.settings;

    return SizedBox(
      height: 58,
      child: Row(
        children: [
          Expanded(
            child: _SettingName(
              icon: value ? icon : inactiveIcon,
              label: label,
              isActive: value,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            value ? strings.on : strings.off,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppTheme.white,
              shadows: Theme.of(
                context,
              ).extension<ZigloomGameTheme>()?.textShadow,
            ),
          ),
          const SizedBox(width: 8),
          Switch(
            value: value,
            activeThumbColor: AppTheme.starYellow,
            activeTrackColor: AppTheme.actionOrange,
            inactiveThumbColor: AppTheme.white,
            inactiveTrackColor: AppTheme.inkBlue.withValues(alpha: 0.45),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _LocaleRow extends StatelessWidget {
  const _LocaleRow({required this.selected, required this.onChanged});

  final AppLocale selected;
  final ValueChanged<AppLocale> onChanged;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<AppLocale>(
      initialValue: selected,
      color: AppTheme.blueDeep,
      iconColor: AppTheme.white,
      onSelected: onChanged,
      itemBuilder: (context) => [
        _localeItem(context, AppLocale.en),
        _localeItem(context, AppLocale.vi),
      ],
      child: SizedBox(
        height: 58,
        child: Row(
          children: [
            Expanded(
              child: _SettingName(
                icon: Icons.language_rounded,
                label: _localeLabel(context, selected),
                isActive: true,
              ),
            ),
            const SizedBox(width: 12),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppTheme.white,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<AppLocale> _localeItem(BuildContext context, AppLocale locale) {
    final isSelected = selected == locale;

    return PopupMenuItem<AppLocale>(
      value: locale,
      child: Row(
        children: [
          Expanded(
            child: Text(
              _localeLabel(context, locale),
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppTheme.white),
            ),
          ),
          if (isSelected)
            const Icon(Icons.check_rounded, color: AppTheme.starYellow),
        ],
      ),
    );
  }

  String _localeLabel(BuildContext context, AppLocale locale) {
    final strings = context.t.settings;

    return switch (locale) {
      AppLocale.en => strings.english,
      AppLocale.vi => strings.vietnamese,
    };
  }
}

class _NavigationRow extends StatelessWidget {
  const _NavigationRow({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          height: 58,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                _StatusDot(icon: icon, isActive: true),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.white,
                      shadows: Theme.of(
                        context,
                      ).extension<ZigloomGameTheme>()?.textShadow,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppTheme.white,
                  size: 28,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingName extends StatelessWidget {
  const _SettingName({
    required this.icon,
    required this.label,
    required this.isActive,
  });

  final IconData icon;
  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatusDot(icon: icon, isActive: isActive),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppTheme.white,
              shadows: Theme.of(
                context,
              ).extension<ZigloomGameTheme>()?.textShadow,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot({required this.icon, required this.isActive});

  final IconData icon;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: isActive ? AppTheme.starYellow : AppTheme.blueBase,
        shape: BoxShape.circle,
        border: Border.all(color: AppTheme.white, width: 2),
      ),
      child: Icon(
        icon,
        color: isActive ? AppTheme.inkBlue : AppTheme.white,
        size: 21,
      ),
    );
  }
}

class _PanelDivider extends StatelessWidget {
  const _PanelDivider({this.horizontalPadding = 0});

  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Divider(height: 1, color: AppTheme.white.withValues(alpha: 0.22)),
    );
  }
}
