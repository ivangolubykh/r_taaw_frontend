import 'package:shared_preferences/shared_preferences.dart';

/// Wrapper for accessing SharedPreferences with typed getters/setters.
class SharedStorage {
  SharedStorage._internal(this._prefix);
  late final SharedPreferences _prefs;
  final String _prefix;

  /// Preferred factory method — avoids implicit shared state.
  static Future<SharedStorage> create({required String prefix}) async {
    final instance = SharedStorage._internal(prefix);
    instance._prefs = await SharedPreferences.getInstance();
    return instance;
  }

  String _key(String key) => '$_prefix$key';

  // ---------- Getters ----------

  String? getString(String key) => _prefs.getString(_key(key));
  bool? getBool(String key) => _prefs.getBool(_key(key));
  int? getInt(String key) => _prefs.getInt(_key(key));
  double? getDouble(String key) => _prefs.getDouble(_key(key));

  DateTime? getDateTime(String key) {
    final value = _prefs.getString(_key(key));
    return value != null ? DateTime.tryParse(value) : null;
  }

  // ---------- Setters ----------

  Future<void> setString(String key, String value) =>
      _prefs.setString(_key(key), value);
  Future<void> setBool(String key, bool value) =>
      _prefs.setBool(_key(key), value);
  Future<void> setInt(String key, int value) => _prefs.setInt(_key(key), value);
  Future<void> setDouble(String key, double value) =>
      _prefs.setDouble(_key(key), value);

  Future<void> setDateTime(String key, DateTime value) =>
      _prefs.setString(_key(key), value.toIso8601String());

  // ---------- Removal ----------

  Future<void> remove(String key) => _prefs.remove(_key(key));

  // ---------- Utility ----------

  bool containsKey(String key) => _prefs.containsKey(_key(key));
  Future<void> clear() async {
    final keysToRemove = _prefs.getKeys().where((k) => k.startsWith(_prefix));
    for (final key in keysToRemove) {
      await _prefs.remove(key);
    }
  }
}
