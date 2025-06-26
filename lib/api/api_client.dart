import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:r_taaw_frontend/core/constants/consts.dart';

/// A simple API client that wraps HTTP requests with a base URL.
///
/// This client encodes request bodies as JSON and automatically includes
/// a `Content-Type: application/json` header.
class ApiClient {
  /// Creates an [ApiClient] using the provided [http.Client],
  /// or a default client if none is given.
  ApiClient([http.Client? client]) : _client = client ?? http.Client();

  final http.Client _client;

  /// Sends a POST request to the given [endpoint].
  ///
  /// The [endpoint] is relative to [AppConsts.apiBaseUrl].
  ///
  /// Optional [headers] are merged with `Content-Type: application/json`.
  /// If [body] is provided, it is JSON-encoded automatically.
  ///
  /// Returns the [http.Response] from the server.
  Future<http.Response> post(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
  }) {
    final url = Uri.parse('${AppConsts.apiBaseUrl}$endpoint');
    return _client.post(
      url,
      headers: {'Content-Type': 'application/json', ...?headers},
      body: body != null ? jsonEncode(body) : null,
    );
  }
}
