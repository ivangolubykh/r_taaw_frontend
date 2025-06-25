// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get cancel => 'Cancel';

  @override
  String get languageOption => 'Change Language';

  @override
  String get loginOption => '🔐 Login';

  @override
  String get logoutConfirmMessage => 'Are you sure you want to log out?';

  @override
  String get logoutConfirmTitle => 'Confirm Logout';

  @override
  String get logoutOption => '🚪 Logout';

  @override
  String get settingsTitle => '⚙️ Settings';

  @override
  String get welcomeText => '👋 Welcome to R‑Taaw!';
}
