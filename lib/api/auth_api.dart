import 'dart:convert';
import 'package:r_taaw_frontend/api/api_client.dart';
import 'package:r_taaw_frontend/api/models/auth_response.dart';

/// A wrapper around [ApiClient] for authentication-related API calls.
///
/// This class provides methods for logging in users
/// and parsing the resulting authentication tokens.
class AuthApi {
  /// Creates an [AuthApi] with the given [ApiClient].
  const AuthApi(this._client);

  final ApiClient _client;

  /// Sends login credentials and retrieves access/refresh tokens.
  ///
  /// Performs a `POST` request to the `auth/token/` endpoint with
  /// the provided [username] and [password].
  ///
  /// On success (HTTP 200), returns an [AuthResponse] with the tokens.
  /// On failure, throws an [Exception] containing the response body.
  Future<AuthResponse> login(
    String username,
    String password, {
    required String locale,
  }) async {
    final response = await _client.post(
      'auth/token/',
      body: {'username': username, 'password': password},
      headers: {'Accept-Language': locale},
    );

    if (response.statusCode == 200) {
      return AuthResponse.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw Exception(response.body);
    }
  }

  /// Registers a new user.
  ///
  /// Sends a `POST` request to `auth/register/` endpoint with the user info.
  /// Throws [Exception] on failure.
  Future<void> register({
    required String username,
    required String password,
    String? email,
    String? nickname,
  }) async {
    final body = <String, String>{
      'username': username,
      'password': password,
      if (email != null) 'email': email,
      if (nickname != null) 'nickname': nickname,
    };

    final response = await _client.post(
      'auth/register/',
      body: body,
      headers: {'Accept-Language': 'en'},
    );

    if (response.statusCode != 201) {
      throw Exception(response.body);
    }
  }
}
