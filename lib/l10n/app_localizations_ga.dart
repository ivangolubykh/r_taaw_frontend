// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Irish (`ga`).
class AppLocalizationsGa extends AppLocalizations {
  AppLocalizationsGa([String locale = 'ga']) : super(locale);

  @override
  String get breadcrumbHome => '🏠 Home';

  @override
  String get cancel => 'Cancel';

  @override
  String get emailHelpTooltip =>
      'Email is optional, but needed for password recovery and future features. Without it, you won\'t be able to restore your password.';

  @override
  String get emailLabel => 'Email (optional)';

  @override
  String get languageOption => 'Change Language';

  @override
  String get loggingIn => 'Logging in...';

  @override
  String get loginFailed => 'Login failed. Please try again.';

  @override
  String get loginOption => '🔐 Login';

  @override
  String get loginSuccess => 'Logged in successfully.';

  @override
  String get logoutConfirmMessage => 'Are you sure you want to log out?';

  @override
  String get logoutConfirmTitle => 'Confirm Logout';

  @override
  String get logoutOption => '🚪 Logout';

  @override
  String get nicknameHelpTooltip =>
      'This is your public display name. It will be shown next to your username in public recipes as the author.';

  @override
  String get nicknameLabel => 'Nickname (optional)';

  @override
  String get okButton => 'OK';

  @override
  String get passwordHelpTooltip =>
      'Your password should be at least 8 characters long. Avoid using common or numeric-only passwords.';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordRequired => 'Please enter a password';

  @override
  String get passwordTooShort => 'Password must be at least 8 characters long';

  @override
  String get registerLinkText => 'Don\'t have an account? Register';

  @override
  String get registerOption => 'Register';

  @override
  String get registerSuccess => 'Registration successful';

  @override
  String get registering => 'Registering...';

  @override
  String get settingsTitle => '⚙️ Settings';

  @override
  String get themeSwitchOption => 'Toggle Light/Dark Theme';

  @override
  String get usernameHelpTooltip =>
      'Username must be unique and up to 150 characters long.';

  @override
  String get usernameInvalid => 'Please enter a username';

  @override
  String get usernameLabel => 'Username';

  @override
  String get welcomeText => '👋 Welcome to R‑Taaw!';
}
