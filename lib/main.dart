import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:r_taaw_frontend/api/api_client.dart';
import 'package:r_taaw_frontend/api/auth_api.dart';
import 'package:r_taaw_frontend/auth/auth_provider.dart';
import 'package:r_taaw_frontend/l10n/app_localizations.dart';
import 'package:r_taaw_frontend/routing/router.dart';
import 'package:r_taaw_frontend/services/user_settings_service.dart';
import 'package:r_taaw_frontend/theme/theme_provider.dart';

/// Entry point of the application.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final userSettings = await UserSettingsService.create();
  final authProvider = await AuthProvider.create();
  runApp(MyApp(userSettings: userSettings, authProvider: authProvider));
}

/// Root widget of the R‑Taaw application.
class MyApp extends StatefulWidget {
  /// Creates the app with [userSettings] and [authProvider].
  const MyApp({
    required this.userSettings,
    required this.authProvider,
    super.key,
  });

  /// Provides persisted user preferences (theme, locale).
  final UserSettingsService userSettings;

  /// Provides authentication and tokens.
  final AuthProvider authProvider;

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

  /// Toggles the app theme between light and dark modes.
  void _toggleTheme() {
    final newMode = _themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    widget.userSettings.setThemeMode(newMode);
    setState(() {
      _themeMode = newMode;
    });
  }

  /// Changes the app's locale or resets to the system default.
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>.value(value: widget.authProvider),
        Provider<ApiClient>(create: (_) => ApiClient()),
        ProxyProvider<ApiClient, AuthApi>(
          update: (_, client, __) => AuthApi(client),
        ),
      ],
      child: ThemeProvider(
        themeMode: _themeMode,
        toggleTheme: _toggleTheme,
        child: ScreenUtilInit(
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
      ),
    );
  }
}
