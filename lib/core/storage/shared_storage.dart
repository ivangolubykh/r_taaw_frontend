import 'package:shared_preferences/shared_preferences.dart';

/// Wrapper for accessing SharedPreferences with typed getters/setters.
///
/// Allows namespaced keys using a prefix and includes support for DateTime.
class SharedStorage {
  SharedStorage._internal(this._prefix);

  late final SharedPreferences _prefs;
  final String _prefix;

  /// Factory method to create a [SharedStorage] instance with a given [prefix].
  ///
  /// Prefixes help isolate keys per feature (e.g., 'auth.', 'user.', etc).
  static Future<SharedStorage> create({required String prefix}) async {
    return SharedStorage._internal(prefix)
      .._prefs = await SharedPreferences.getInstance();
  }

  /// Computes the full key by adding the prefix.
  String _key(String key) => '$_prefix$key';

  // ---------- Getters ----------

  /// Gets a string value by key, or `null` if not found.
  String? getString(String key) => _prefs.getString(_key(key));

  /// Gets a boolean value by key, or `null` if not found.
  bool? getBool(String key) => _prefs.getBool(_key(key));

  /// Gets an integer value by key, or `null` if not found.
  int? getInt(String key) => _prefs.getInt(_key(key));

  /// Gets a double value by key, or `null` if not found.
  double? getDouble(String key) => _prefs.getDouble(_key(key));

  /// Gets a DateTime value by key, or `null` if parsing fails or not found.
  DateTime? getDateTime(String key) {
    final value = _prefs.getString(_key(key));
    return value != null ? DateTime.tryParse(value) : null;
  }

  // ---------- Setters ----------

  /// Stores a string value for the given [key].
  Future<void> setString(String key, String value) =>
      _prefs.setString(_key(key), value);

  /// Stores a boolean value for the given [key].
  Future<void> setBool({required String key, required bool value}) =>
      _prefs.setBool(_key(key), value);

  /// Stores an integer value for the given [key].
  Future<void> setInt(String key, int value) => _prefs.setInt(_key(key), value);

  /// Stores a double value for the given [key].
  Future<void> setDouble(String key, double value) =>
      _prefs.setDouble(_key(key), value);

  /// Stores a DateTime value as an ISO 8601 string.
  Future<void> setDateTime(String key, DateTime value) =>
      _prefs.setString(_key(key), value.toIso8601String());

  // ---------- Removal ----------

  /// Removes the entry for the given [key].
  Future<void> remove(String key) => _prefs.remove(_key(key));

  // ---------- Utility ----------

  /// Returns `true` if a value exists for the given [key].
  bool containsKey(String key) => _prefs.containsKey(_key(key));

  /// Clears all keys that start with the current prefix.
  Future<void> clear() async {
    final keysToRemove = _prefs.getKeys().where((k) => k.startsWith(_prefix));
    for (final key in keysToRemove) {
      await _prefs.remove(key);
    }
  }
}
