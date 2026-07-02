import 'package:example_template/common/app_router.dart';
import 'package:example_template/common/theme.dart';
import 'package:example_template/gen/i18n/locale.dart';
import 'package:example_template/helper/shared_pref_helper.dart';
import 'package:example_template/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: TranslationProvider(child: const _AppBoot())));
}

class _AppBoot extends ConsumerStatefulWidget {
  const _AppBoot();

  @override
  ConsumerState<_AppBoot> createState() => _AppBootState();
}

class _AppBootState extends ConsumerState<_AppBoot> {
  var _isReady = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settings = await loadAppSettings(SharedPrefHelper());
    await LocaleSettings.setLocale(settings.locale);
    if (!mounted) return;

    ref.read(appSettingsProvider.notifier).state = settings;
    setState(() => _isReady = true);
  }

  @override
  Widget build(BuildContext context) {
    return _isReady ? const MyApp() : const SizedBox.shrink();
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);

    return MaterialApp.router(
      title: 'Example Template',
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: [...GlobalMaterialLocalizations.delegates],
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settings.themeMode,
      routerConfig: appRouter,
    );
  }
}
