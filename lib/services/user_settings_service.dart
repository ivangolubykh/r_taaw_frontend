import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';

class UserSettingsService {
  final SharedPreferences _prefs;

  UserSettingsService._(this._prefs);

  static Future<UserSettingsService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return UserSettingsService._(prefs);
  }

  // -------------------- Locale --------------------
  static const _localeKey = 'user_locale';
  static const _localeModifiedKey = 'user_locale_modified';
  static const _localeSyncedKey = 'user_locale_synced';

  Locale get locale {
    final localeCode = _prefs.getString(_localeKey);
    if (localeCode == null || localeCode == 'system') {
      final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
      return AppLocalizations.supportedLocales.contains(systemLocale)
          ? systemLocale
          : const Locale('en');
    }

    final parts = localeCode.split('-');
    if (parts.length == 2 && parts[1].length == 4) {
      // e.g. zh-Hans (scriptCode)
      return Locale.fromSubtags(languageCode: parts[0], scriptCode: parts[1]);
    } else if (parts.length == 2) {
      // e.g. pt-BR (countryCode)
      return Locale(parts[0], parts[1]);
    } else {
      return Locale(parts[0]);
    }
  }

  Future<void> setLocale(Locale locale) async {
    final localeCode = _localeToString(locale);
    await _prefs.setString(_localeKey, localeCode);
    await _prefs.setString(
      _localeModifiedKey,
      DateTime.now().toIso8601String(),
    );
  }

  Future<void> resetLocaleToSystem() async {
    await _prefs.setString(_localeKey, 'system');
    await _prefs.setString(
      _localeModifiedKey,
      DateTime.now().toIso8601String(),
    );
  }

  DateTime? get localeModified => _getDateTime(_localeModifiedKey);
  DateTime? get localeSynced => _getDateTime(_localeSyncedKey);

  Future<void> updateLocaleSynced() async {
    await _prefs.setString(_localeSyncedKey, DateTime.now().toIso8601String());
  }

  // -------------------- ThemeMode --------------------
  static const _themeKey = 'theme_mode';
  static const _themeModifiedKey = 'theme_mode_modified';
  static const _themeSyncedKey = 'theme_mode_synced';

  ThemeMode get themeMode {
    final value = _prefs.getString(_themeKey) ?? 'system';
    switch (value) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _prefs.setString(_themeKey, mode.name);
    await _prefs.setString(_themeModifiedKey, DateTime.now().toIso8601String());
  }

  DateTime? get themeModified => _getDateTime(_themeModifiedKey);
  DateTime? get themeSynced => _getDateTime(_themeSyncedKey);

  Future<void> updateThemeSynced() async {
    await _prefs.setString(_themeSyncedKey, DateTime.now().toIso8601String());
  }

  // -------------------- Helpers --------------------
  String _localeToString(Locale locale) {
    if (locale.scriptCode != null && locale.scriptCode!.isNotEmpty) {
      return '${locale.languageCode}-${locale.scriptCode}';
    } else if (locale.countryCode != null && locale.countryCode!.isNotEmpty) {
      return '${locale.languageCode}-${locale.countryCode}';
    } else {
      return locale.languageCode;
    }
  }

  DateTime? _getDateTime(String key) {
    final value = _prefs.getString(key);
    return value != null ? DateTime.tryParse(value) : null;
  }
}
