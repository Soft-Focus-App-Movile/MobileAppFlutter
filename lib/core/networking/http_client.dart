import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';

/// HTTP client wrapper that handles common HTTP operations with authentication
/// and automatic 401 handling
class HttpClient {
  final http.Client _client;
  String? _token;
  final Function()? _onUnauthorized;

  HttpClient({
    http.Client? client,
    String? token,
    Function()? onUnauthorized,
  })  : _client = client ?? http.Client(),
        _token = token,
        _onUnauthorized = onUnauthorized;

  /// Update the authentication token
  void setToken(String? token) {
    _token = token;
  }

  /// Get current token
  String? get token => _token;

  /// Build headers with authentication and content type
  Map<String, String> _buildHeaders({Map<String, String>? additionalHeaders}) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    if (_token != null && _token!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $_token';
    }

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    return headers;
  }

  /// Handle 401 Unauthorized responses
  void _handleUnauthorized(http.Response response) {
    if (response.statusCode == 401) {
      print('⚠️ 401 Unauthorized detected - Token expired or invalid');
      print('⚠️ Clearing all session data and logging out user');

      // Call the logout callback if provided
      if (_onUnauthorized != null) {
        try {
          _onUnauthorized!();
          print('✓ Session data cleared successfully');
        } catch (e) {
          print('✗ Error clearing session data: $e');
        }
      }
    }
  }

  /// GET request
  Future<http.Response> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint')
        .replace(queryParameters: queryParameters);

    final response = await _client.get(
      uri,
      headers: _buildHeaders(additionalHeaders: headers),
    );

    _handleUnauthorized(response);
    return response;
  }

  /// POST request
  Future<http.Response> post(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');

    final response = await _client.post(
      uri,
      headers: _buildHeaders(additionalHeaders: headers),
      body: body != null ? jsonEncode(body) : null,
    );

    _handleUnauthorized(response);
    return response;
  }

  /// PUT request
  Future<http.Response> put(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');

    final response = await _client.put(
      uri,
      headers: _buildHeaders(additionalHeaders: headers),
      body: body != null ? jsonEncode(body) : null,
    );

    _handleUnauthorized(response);
    return response;
  }

  /// PATCH request
  Future<http.Response> patch(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');

    final response = await _client.patch(
      uri,
      headers: _buildHeaders(additionalHeaders: headers),
      body: body != null ? jsonEncode(body) : null,
    );

    _handleUnauthorized(response);
    return response;
  }

  /// DELETE request
  Future<http.Response> delete(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');

    final response = await _client.delete(
      uri,
      headers: _buildHeaders(additionalHeaders: headers),
      body: body != null ? jsonEncode(body) : null,
    );

    _handleUnauthorized(response);
    return response;
  }

  /// Close the client
  void close() {
    _client.close();
  }
}
