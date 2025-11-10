import 'dart:convert';
import '../../../../core/common/result.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../services/auth_service.dart';
import '../models/request/login_request_dto.dart';
import '../models/request/register_general_user_request_dto.dart';
import '../models/request/oauth_verify_request_dto.dart';

/// Implementation of AuthRepository interface.
///
/// This class provides the concrete implementation for authentication operations,
/// handling HTTP requests and mapping DTOs to domain models.
class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl({required AuthService service}) : _authService = service;

  @override
  Future<Result<User>> login(String email, String password) async {
    try {
      final request = LoginRequestDto(email: email, password: password);
      final response = await _authService.login(request);
      final user = response.toDomain();
      return Success(user);
    } catch (e) {
      // Try to extract error message from response
      final errorMessage = _extractErrorMessage(e);
      return Error(errorMessage);
    }
  }

  @override
  Future<Result<RegisterResult>> registerGeneralUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required bool acceptsPrivacyPolicy,
  }) async {
    try {
      final request = RegisterGeneralUserRequestDto(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        acceptsPrivacyPolicy: acceptsPrivacyPolicy,
      );
      final response = await _authService.registerGeneralUser(request);
      final result = response.toDomain();
      return Success(result);
    } catch (e) {
      final errorMessage = _extractErrorMessage(e);
      return Error(errorMessage);
    }
  }

  @override
  Future<Result<RegisterResult>> registerPsychologist({
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
    try {
      final response = await _authService.registerPsychologist(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        professionalLicense: professionalLicense,
        yearsOfExperience: yearsOfExperience,
        collegiateRegion: collegiateRegion,
        university: university,
        graduationYear: graduationYear,
        acceptsPrivacyPolicy: acceptsPrivacyPolicy,
        licenseDocumentUri: licenseDocumentUri,
        diplomaDocumentUri: diplomaDocumentUri,
        dniDocumentUri: dniDocumentUri,
        specialties: specialties,
        certificationDocumentUris: certificationDocumentUris,
      );
      final result = response.toDomain();
      return Success(result);
    } catch (e) {
      final errorMessage = _extractErrorMessage(e);
      return Error(errorMessage);
    }
  }

  @override
  Future<Result<User>> socialLogin(String provider, String token) async {
    try {
      // This method may be deprecated, check with backend
      throw UnimplementedError('Use oauthLogin instead');
    } catch (e) {
      final errorMessage = _extractErrorMessage(e);
      return Error(errorMessage);
    }
  }

  @override
  Future<Result<OAuthVerificationData>> verifyOAuth(
    String provider,
    String accessToken,
  ) async {
    try {
      final request = OAuthVerifyRequestDto(
        provider: provider,
        accessToken: accessToken,
      );
      final response = await _authService.verifyOAuth(request);
      final data = response.toDomain();
      return Success(data);
    } catch (e) {
      final errorMessage = _extractErrorMessage(e);
      return Error(errorMessage);
    }
  }

  @override
  Future<Result<User>> oauthLogin(String provider, String token) async {
    try {
      final response = await _authService.oauthLogin(
        provider: provider,
        token: token,
      );
      final user = response.toDomain();
      return Success(user);
    } catch (e) {
      final errorMessage = _extractErrorMessage(e);
      return Error(errorMessage);
    }
  }

  @override
  Future<Result<User>> completeOAuthRegistrationGeneral({
    required String tempToken,
    required bool acceptsPrivacyPolicy,
  }) async {
    try {
      final response = await _authService.completeOAuthRegistrationGeneral(
        tempToken: tempToken,
        acceptsPrivacyPolicy: acceptsPrivacyPolicy,
      );
      final user = response.toDomain();
      return Success(user);
    } catch (e) {
      final errorMessage = _extractErrorMessage(e);
      return Error(errorMessage);
    }
  }

  @override
  Future<Result<User>> completeOAuthRegistrationPsychologist({
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
    try {
      final response = await _authService.completeOAuthRegistrationPsychologist(
        tempToken: tempToken,
        professionalLicense: professionalLicense,
        yearsOfExperience: yearsOfExperience,
        collegiateRegion: collegiateRegion,
        university: university,
        graduationYear: graduationYear,
        acceptsPrivacyPolicy: acceptsPrivacyPolicy,
        licenseDocumentUri: licenseDocumentUri,
        diplomaDocumentUri: diplomaDocumentUri,
        dniDocumentUri: dniDocumentUri,
        specialties: specialties,
        certificationDocumentUris: certificationDocumentUris,
      );
      final user = response.toDomain();
      return Success(user);
    } catch (e) {
      final errorMessage = _extractErrorMessage(e);
      return Error(errorMessage);
    }
  }

  /// Extract error message from exception
  String _extractErrorMessage(dynamic error) {
    final errorString = error.toString();

    // Try to parse JSON error response
    try {
      if (errorString.contains('{') && errorString.contains('}')) {
        final jsonStart = errorString.indexOf('{');
        final jsonEnd = errorString.lastIndexOf('}') + 1;
        final jsonString = errorString.substring(jsonStart, jsonEnd);
        final jsonMap = jsonDecode(jsonString);

        if (jsonMap['message'] != null) {
          return jsonMap['message'];
        }
      }
    } catch (e) {
      // If JSON parsing fails, return the original error
    }

    // Extract message after "Exception: " or "failed: "
    if (errorString.contains('Exception: ')) {
      return errorString.split('Exception: ').last;
    } else if (errorString.contains('failed: ')) {
      return errorString.split('failed: ').last;
    }

    return 'An error occurred: $errorString';
  }
}
