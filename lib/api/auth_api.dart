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
  Future<AuthResponse> login(String username, String password) async {
    final response = await _client.post(
      'auth/token/',
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return AuthResponse.fromJson(data);
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }
}
