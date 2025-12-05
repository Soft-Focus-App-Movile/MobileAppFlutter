import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../../features/auth/data/local/user_session.dart';

/// HTTP client wrapper that handles common HTTP operations with authentication
/// and automatic 401 handling
class HttpClient {
  final http.Client _client;
  String? _token;
  final Function()? _onUnauthorized;
  final UserSession _userSession = UserSession();

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
  Future<Map<String, String>> _buildHeaders({Map<String, String>? additionalHeaders}) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    // ✅ NUEVO: Obtener token de la sesión si no está configurado
    String? authToken = _token;
    if (authToken == null || authToken.isEmpty) {
      try {
        final user = await _userSession.getUser();
        final isExpired = await _userSession.isTokenExpired();
        if (user != null && !isExpired) {
          authToken = user.token;
          print('🔑 Token obtenido de la sesión para HTTP request');
        }
      } catch (e) {
        print('⚠️ Error obteniendo token de sesión: $e');
      }
    }

    if (authToken != null && authToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $authToken';
      print('🔑 Authorization header agregado');
    } else {
      print('⚠️ No hay token disponible para el request');
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
          _onUnauthorized();
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

    print('📤 GET Request: $uri');
    
    final builtHeaders = await _buildHeaders(additionalHeaders: headers);

    final response = await _client.get(
      uri,
      headers: builtHeaders,
    );

    print('📥 Response: ${response.statusCode}');
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

    print('📤 POST Request: $uri');
    
    final builtHeaders = await _buildHeaders(additionalHeaders: headers);

    final response = await _client.post(
      uri,
      headers: builtHeaders,
      body: body != null ? jsonEncode(body) : null,
    );

    print('📥 Response: ${response.statusCode}');
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

    print('📤 PUT Request: $uri');
    
    final builtHeaders = await _buildHeaders(additionalHeaders: headers);

    final response = await _client.put(
      uri,
      headers: builtHeaders,
      body: body != null ? jsonEncode(body) : null,
    );

    print('📥 Response: ${response.statusCode}');
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

    print('📤 PATCH Request: $uri');
    
    final builtHeaders = await _buildHeaders(additionalHeaders: headers);

    final response = await _client.patch(
      uri,
      headers: builtHeaders,
      body: body != null ? jsonEncode(body) : null,
    );

    print('📥 Response: ${response.statusCode}');
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

    print('📤 DELETE Request: $uri');
    
    final builtHeaders = await _buildHeaders(additionalHeaders: headers);

    final response = await _client.delete(
      uri,
      headers: builtHeaders,
      body: body != null ? jsonEncode(body) : null,
    );

    print('📥 Response: ${response.statusCode}');
    _handleUnauthorized(response);
    return response;
  }

  /// Close the client
  void close() {
    _client.close();
  }
}