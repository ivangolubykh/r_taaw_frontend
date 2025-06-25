import 'package:flutter/material.dart';
import 'package:r_taaw_frontend/core/storage/shared_storage.dart';
import 'package:r_taaw_frontend/l10n/app_localizations.dart';

class UserSettingsService {
  UserSettingsService(this._storage);
  final SharedStorage _storage;

  static Future<UserSettingsService> create() async {
    final storage = await SharedStorage.create(prefix: 'settings.');
    return UserSettingsService(storage);
  }

  // -------------------- Locale --------------------
  static const _localeKey = 'locale';
  static const _localeModifiedKey = 'locale_modified';
  static const _localeSyncedKey = 'locale_synced';

  Locale get locale {
    final localeCode = _storage.getString(_localeKey);
    if (localeCode == null || localeCode == 'system') {
      final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
      return AppLocalizations.supportedLocales.contains(systemLocale)
          ? systemLocale
          : const Locale('en');
    }

    final parts = localeCode.split('-');
    if (parts.length == 2 && parts[1].length == 4) {
      return Locale.fromSubtags(languageCode: parts[0], scriptCode: parts[1]);
    } else if (parts.length == 2) {
      return Locale(parts[0], parts[1]);
    } else {
      return Locale(parts[0]);
    }
  }

  Future<void> setLocale(Locale locale) async {
    final localeCode = _localeToString(locale);
    await _storage.setString(_localeKey, localeCode);
    await _storage.setDateTime(_localeModifiedKey, DateTime.now());
  }

  Future<void> resetLocaleToSystem() async {
    await _storage.setString(_localeKey, 'system');
    await _storage.setDateTime(_localeModifiedKey, DateTime.now());
  }

  DateTime? get localeModified => _storage.getDateTime(_localeModifiedKey);
  DateTime? get localeSynced => _storage.getDateTime(_localeSyncedKey);

  Future<void> updateLocaleSynced() async {
    await _storage.setDateTime(_localeSyncedKey, DateTime.now());
  }

  // -------------------- ThemeMode --------------------
  static const _themeKey = 'theme_mode';
  static const _themeModifiedKey = 'theme_mode_modified';
  static const _themeSyncedKey = 'theme_mode_synced';

  ThemeMode get themeMode {
    final value = _storage.getString(_themeKey) ?? 'system';
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
    await _storage.setString(_themeKey, mode.name);
    await _storage.setDateTime(_themeModifiedKey, DateTime.now());
  }

  DateTime? get themeModified => _storage.getDateTime(_themeModifiedKey);
  DateTime? get themeSynced => _storage.getDateTime(_themeSyncedKey);

  Future<void> updateThemeSynced() async {
    await _storage.setDateTime(_themeSyncedKey, DateTime.now());
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
}
