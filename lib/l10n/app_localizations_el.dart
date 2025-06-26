// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

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
  String get themeSwitchOption => 'Toggle Light/Dark Theme';

  @override
  String get welcomeText => '👋 Welcome to R‑Taaw!';

  @override
  String get usernameInvalid => 'Please enter your username.';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters.';

  @override
  String get usernameLabel => 'Username';

  @override
  String get passwordLabel => 'Password';

  @override
  String get breadcrumbHome => '🏠 Home';

  @override
  String get registerLinkText => 'Don\'t have an account? Register';
}
