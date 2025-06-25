import 'package:flutter/material.dart';
import 'package:r_taaw_frontend/core/storage/shared_storage.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider._(this._storage);
  final SharedStorage _storage;

  static Future<AuthProvider> create() async {
    final storage = await SharedStorage.create(prefix: 'auth.');
    return AuthProvider._(storage);
  }

  // -------------------- Keys --------------------
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  // -------------------- Getters --------------------
  String? get accessToken => _storage.getString(_accessTokenKey);
  String? get refreshToken => _storage.getString(_refreshTokenKey);

  bool get isAuthenticated => accessToken?.isNotEmpty == true;

  // -------------------- Setters --------------------
  Future<void> setTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.setString(_accessTokenKey, accessToken);
    await _storage.setString(_refreshTokenKey, refreshToken);
    notifyListeners();
  }

  Future<void> clearTokens() async {
    await _storage.remove(_accessTokenKey);
    await _storage.remove(_refreshTokenKey);
    notifyListeners();
  }
}
