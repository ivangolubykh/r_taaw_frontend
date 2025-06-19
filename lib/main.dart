import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'theme/theme_provider.dart';
import 'routing/router.dart';
import 'l10n/app_localizations.dart';
import 'services/user_settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final userSettings = await UserSettingsService.create();
  runApp(MyApp(userSettings: userSettings));
}

class MyApp extends StatefulWidget {
  final UserSettingsService userSettings;
  const MyApp({super.key, required this.userSettings});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeMode _themeMode;
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.userSettings.themeMode;
    _locale = widget.userSettings.locale;
  }

  void _toggleTheme() {
    final newMode = _themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    widget.userSettings.setThemeMode(newMode);
    setState(() {
      _themeMode = newMode;
    });
  }

  void _changeLocale(Locale? locale) {
    if (locale == null) {
      widget.userSettings.resetLocaleToSystem();
      setState(() {
        _locale = widget.userSettings.locale;
      });
    } else {
      widget.userSettings.setLocale(locale);
      setState(() {
        _locale = locale;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      themeMode: _themeMode,
      toggleTheme: _toggleTheme,
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(useMaterial3: true),
            darkTheme: ThemeData.dark(useMaterial3: true),
            themeMode: _themeMode,
            routerConfig: router,
            locale: _locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          );
        },
      ),
    );
  }
}
