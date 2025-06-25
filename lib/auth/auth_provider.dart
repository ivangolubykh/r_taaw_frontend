import 'package:flutter/material.dart';
import 'package:r_taaw_frontend/core/storage/shared_storage.dart';

/// A provider for managing authentication tokens and notifying listeners.
///
/// Tokens are stored in a shared key-value storage with a dedicated prefix.
/// This provider exposes methods for reading, writing, and clearing tokens.
class AuthProvider extends ChangeNotifier {
  /// Private constructor. Use [AuthProvider.create] to instantiate.
  AuthProvider._(this._storage);

  final SharedStorage _storage;

  /// Initializes the [AuthProvider] with storage using the 'auth.' prefix.
  static Future<AuthProvider> create() async {
    final storage = await SharedStorage.create(prefix: 'auth.');
    return AuthProvider._(storage);
  }

  // -------------------- Keys --------------------
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  // -------------------- Getters --------------------

  /// Returns the currently stored access token, or `null` if not set.
  String? get accessToken => _storage.getString(_accessTokenKey);

  /// Returns the currently stored refresh token, or `null` if not set.
  String? get refreshToken => _storage.getString(_refreshTokenKey);

  /// Returns `true` if a non-empty access token is present.
  bool get isAuthenticated => accessToken?.isNotEmpty ?? false;

  // -------------------- Setters --------------------

  /// Stores the provided [accessToken] and [refreshToken], then notifies
  /// listeners.
  Future<void> setTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.setString(_accessTokenKey, accessToken);
    await _storage.setString(_refreshTokenKey, refreshToken);
    notifyListeners();
  }

  /// Clears both access and refresh tokens, then notifies listeners.
  Future<void> clearTokens() async {
    await _storage.remove(_accessTokenKey);
    await _storage.remove(_refreshTokenKey);
    notifyListeners();
  }
}
