import 'package:flutter/material.dart';
import 'package:r_taaw_frontend/core/storage/shared_storage.dart';
import 'package:r_taaw_frontend/l10n/app_localizations.dart';

/// Service for persisting and retrieving user settings.
///
/// This includes theme mode and locale preferences, along with their
/// modification/sync timestamps.
class UserSettingsService {
  /// Constructs an instance with the provided [SharedStorage].
  UserSettingsService(this._storage);
  final SharedStorage _storage;

  /// Factory method to create a [UserSettingsService] using 'settings.' prefix.
  static Future<UserSettingsService> create() async {
    final storage = await SharedStorage.create(prefix: 'settings.');
    return UserSettingsService(storage);
  }

  // -------------------- Locale --------------------

  static const _localeKey = 'locale';
  static const _localeModifiedKey = 'locale_modified';
  static const _localeSyncedKey = 'locale_synced';

  /// Returns the currently selected locale or system fallback.
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

  /// Sets a new locale and updates the modification timestamp.
  Future<void> setLocale(Locale locale) async {
    final localeCode = _localeToString(locale);
    await _storage.setString(_localeKey, localeCode);
    await _storage.setDateTime(_localeModifiedKey, DateTime.now());
  }

  /// Resets the locale preference to system default.
  Future<void> resetLocaleToSystem() async {
    await _storage.setString(_localeKey, 'system');
    await _storage.setDateTime(_localeModifiedKey, DateTime.now());
  }

  /// Returns the last time the locale was modified.
  DateTime? get localeModified => _storage.getDateTime(_localeModifiedKey);

  /// Returns the last time the locale was synced externally.
  DateTime? get localeSynced => _storage.getDateTime(_localeSyncedKey);

  /// Updates the external sync timestamp for locale.
  Future<void> updateLocaleSynced() async {
    await _storage.setDateTime(_localeSyncedKey, DateTime.now());
  }

  // -------------------- ThemeMode --------------------

  static const _themeKey = 'theme_mode';
  static const _themeModifiedKey = 'theme_mode_modified';
  static const _themeSyncedKey = 'theme_mode_synced';

  /// Returns the stored theme mode or system default.
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

  /// Sets the theme mode and updates the modification timestamp.
  Future<void> setThemeMode(ThemeMode mode) async {
    await _storage.setString(_themeKey, mode.name);
    await _storage.setDateTime(_themeModifiedKey, DateTime.now());
  }

  /// Returns the last time the theme mode was modified.
  DateTime? get themeModified => _storage.getDateTime(_themeModifiedKey);

  /// Returns the last time the theme mode was synced externally.
  DateTime? get themeSynced => _storage.getDateTime(_themeSyncedKey);

  /// Updates the external sync timestamp for theme mode.
  Future<void> updateThemeSynced() async {
    await _storage.setDateTime(_themeSyncedKey, DateTime.now());
  }

  // -------------------- Helpers --------------------

  /// Converts a [Locale] to a string format for storage.
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
