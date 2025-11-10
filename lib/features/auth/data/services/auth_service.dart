import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import '../../../../core/networking/http_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/request/login_request_dto.dart';
import '../models/request/register_general_user_request_dto.dart';
import '../models/request/oauth_verify_request_dto.dart';
import '../models/response/login_response_dto.dart';
import '../models/response/register_response_dto.dart';
import '../models/response/oauth_verification_response_dto.dart';

/// Service for authentication-related API calls
class AuthService {
  final HttpClient _httpClient;

  AuthService({HttpClient? httpClient}) : _httpClient = httpClient ?? HttpClient();

  /// Login with email and password
  Future<LoginResponseDto> login(LoginRequestDto request) async {
    final response = await _httpClient.post(
      AuthEndpoints.login,
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      return LoginResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  /// Register a new general user
  Future<RegisterResponseDto> registerGeneralUser(
    RegisterGeneralUserRequestDto request,
  ) async {
    final response = await _httpClient.post(
      AuthEndpoints.registerGeneral,
      body: request.toJson(),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return RegisterResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Registration failed: ${response.body}');
    }
  }

  /// Register a new psychologist (with document uploads)
  Future<RegisterResponseDto> registerPsychologist({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String professionalLicense,
    required int yearsOfExperience,
    required String collegiateRegion,
    required String university,
    required int graduationYear,
    required bool acceptsPrivacyPolicy,
    required String licenseDocumentUri,
    required String diplomaDocumentUri,
    required String dniDocumentUri,
    String? specialties,
    List<String>? certificationDocumentUris,
  }) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}${AuthEndpoints.registerPsychologist}');
    final request = http.MultipartRequest('POST', uri);

    // Add text fields
    request.fields['firstName'] = firstName;
    request.fields['lastName'] = lastName;
    request.fields['email'] = email;
    request.fields['password'] = password;
    request.fields['professionalLicense'] = professionalLicense;
    request.fields['yearsOfExperience'] = yearsOfExperience.toString();
    request.fields['collegiateRegion'] = collegiateRegion;
    request.fields['university'] = university;
    request.fields['graduationYear'] = graduationYear.toString();
    request.fields['acceptsPrivacyPolicy'] = acceptsPrivacyPolicy.toString();

    if (specialties != null) {
      request.fields['specialties'] = specialties;
    }

    // Add file uploads
    request.files.add(await _createMultipartFile('licenseDocument', licenseDocumentUri));
    request.files.add(await _createMultipartFile('diplomaDocument', diplomaDocumentUri));
    request.files.add(await _createMultipartFile('dniDocument', dniDocumentUri));

    // Add certification documents if provided
    if (certificationDocumentUris != null) {
      for (var i = 0; i < certificationDocumentUris.length; i++) {
        request.files.add(await _createMultipartFile(
          'certificationDocuments',
          certificationDocumentUris[i],
        ));
      }
    }

    // Add auth headers if token exists
    if (_httpClient.token != null && _httpClient.token!.isNotEmpty) {
      request.headers['Authorization'] = 'Bearer ${_httpClient.token}';
    }
    request.headers['Content-Type'] = 'multipart/form-data';

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201 || response.statusCode == 200) {
      return RegisterResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Psychologist registration failed: ${response.body}');
    }
  }

  /// Verify OAuth token with backend
  Future<OAuthVerificationResponseDto> verifyOAuth(
    OAuthVerifyRequestDto request,
  ) async {
    final response = await _httpClient.post(
      AuthEndpoints.oauthVerify,
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      return OAuthVerificationResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('OAuth verification failed: ${response.body}');
    }
  }

  /// Login with OAuth (existing user)
  Future<LoginResponseDto> oauthLogin({
    required String provider,
    required String token,
  }) async {
    final response = await _httpClient.post(
      AuthEndpoints.oauth,
      body: {
        'provider': provider,
        'token': token,
      },
    );

    if (response.statusCode == 200) {
      return LoginResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('OAuth login failed: ${response.body}');
    }
  }

  /// Complete OAuth registration for general user
  Future<LoginResponseDto> completeOAuthRegistrationGeneral({
    required String tempToken,
    required bool acceptsPrivacyPolicy,
  }) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}${AuthEndpoints.oauthCompleteRegistration}');
    final request = http.MultipartRequest('POST', uri);

    request.fields['tempToken'] = tempToken;
    request.fields['userType'] = 'GENERAL';
    request.fields['acceptsPrivacyPolicy'] = acceptsPrivacyPolicy.toString();

    // Add auth headers if token exists
    if (_httpClient.token != null && _httpClient.token!.isNotEmpty) {
      request.headers['Authorization'] = 'Bearer ${_httpClient.token}';
    }
    request.headers['Content-Type'] = 'multipart/form-data';

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return LoginResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('OAuth general registration completion failed: ${response.body}');
    }
  }

  /// Complete OAuth registration for psychologist
  Future<LoginResponseDto> completeOAuthRegistrationPsychologist({
    required String tempToken,
    required String professionalLicense,
    required int yearsOfExperience,
    required String collegiateRegion,
    required String university,
    required int graduationYear,
    required bool acceptsPrivacyPolicy,
    required String licenseDocumentUri,
    required String diplomaDocumentUri,
    required String dniDocumentUri,
    String? specialties,
    List<String>? certificationDocumentUris,
  }) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}${AuthEndpoints.oauthCompleteRegistration}');
    final request = http.MultipartRequest('POST', uri);

    // Add text fields
    request.fields['tempToken'] = tempToken;
    request.fields['userType'] = 'PSYCHOLOGIST';
    request.fields['acceptsPrivacyPolicy'] = acceptsPrivacyPolicy.toString();
    request.fields['professionalLicense'] = professionalLicense;
    request.fields['yearsOfExperience'] = yearsOfExperience.toString();
    request.fields['collegiateRegion'] = collegiateRegion;
    request.fields['university'] = university;
    request.fields['graduationYear'] = graduationYear.toString();

    if (specialties != null) {
      request.fields['specialties'] = specialties;
    }

    // Add file uploads
    request.files.add(await _createMultipartFile('licenseDocument', licenseDocumentUri));
    request.files.add(await _createMultipartFile('diplomaDocument', diplomaDocumentUri));
    request.files.add(await _createMultipartFile('dniDocument', dniDocumentUri));

    // Add certification documents if provided
    if (certificationDocumentUris != null) {
      for (var i = 0; i < certificationDocumentUris.length; i++) {
        request.files.add(await _createMultipartFile(
          'certificationDocuments',
          certificationDocumentUris[i],
        ));
      }
    }

    // Add auth headers if token exists
    if (_httpClient.token != null && _httpClient.token!.isNotEmpty) {
      request.headers['Authorization'] = 'Bearer ${_httpClient.token}';
    }
    request.headers['Content-Type'] = 'multipart/form-data';

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return LoginResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('OAuth psychologist registration completion failed: ${response.body}');
    }
  }

  /// Helper method to create multipart file from URI
  Future<http.MultipartFile> _createMultipartFile(String fieldName, String fileUri) async {
    final file = File(fileUri);
    final mimeType = lookupMimeType(fileUri) ?? 'application/octet-stream';
    final mimeTypeParts = mimeType.split('/');

    return http.MultipartFile.fromBytes(
      fieldName,
      await file.readAsBytes(),
      filename: file.path.split('/').last,
      contentType: MediaType(mimeTypeParts[0], mimeTypeParts[1]),
    );
  }
}
