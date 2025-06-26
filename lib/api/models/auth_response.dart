/// A model representing authentication tokens received from the backend.
class AuthResponse {
  /// Creates an [AuthResponse] with the given access and refresh tokens.
  AuthResponse({required this.accessToken, required this.refreshToken});

  /// Parses an [AuthResponse] from a JSON object.
  ///
  /// Expects a map with `access` and `refresh` string keys.
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['access'] as String,
      refreshToken: json['refresh'] as String,
    );
  }

  /// The access token used for authenticated API requests.
  final String accessToken;

  /// The refresh token used to obtain new access tokens.
  final String refreshToken;
}
