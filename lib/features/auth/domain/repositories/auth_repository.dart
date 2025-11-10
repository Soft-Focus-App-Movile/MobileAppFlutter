import '../../../../core/common/result.dart';
import '../models/user.dart';

/// Repository interface for authentication operations.
///
/// This interface defines the contract for authentication-related operations
/// without any implementation details. The actual implementation will be
/// provided in the data layer.
///
/// All methods use Result<T> to handle success and failure cases in a functional way.
abstract class AuthRepository {
  /// Authenticates a user with email and password.
  ///
  /// - [email] User's email address
  /// - [password] User's password
  /// Returns Result containing the authenticated User on success, or an error message on failure
  Future<Result<User>> login(String email, String password);

  /// Registers a new general user in the platform.
  ///
  /// - [firstName] User's first name
  /// - [lastName] User's last name
  /// - [email] User's email address
  /// - [password] User's password
  /// - [acceptsPrivacyPolicy] Whether the user accepts the privacy policy
  /// Returns Result containing userId and email on success
  Future<Result<RegisterResult>> registerGeneralUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required bool acceptsPrivacyPolicy,
  });

  /// Registers a new psychologist in the platform.
  /// Requires document uploads.
  ///
  /// - [firstName] User's first name
  /// - [lastName] User's last name
  /// - [email] User's email address
  /// - [password] User's password
  /// - [professionalLicense] Professional license number
  /// - [yearsOfExperience] Years of professional experience
  /// - [collegiateRegion] College region
  /// - [university] University name
  /// - [graduationYear] Year of graduation
  /// - [acceptsPrivacyPolicy] Whether the user accepts the privacy policy
  /// - [licenseDocumentUri] URI of license document file
  /// - [diplomaDocumentUri] URI of diploma certificate file
  /// - [dniDocumentUri] URI of DNI/identity document file
  /// - [specialties] Comma-separated list of specialties (optional)
  /// - [certificationDocumentUris] List of URIs for additional certificates (optional)
  /// Returns Result containing userId and email on success (account pending verification)
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
  });

  /// Authenticates a user using a social provider (Google, Facebook, etc.).
  ///
  /// - [provider] Name of the social provider (e.g., "GOOGLE", "FACEBOOK")
  /// - [token] Authentication token from the social provider
  /// Returns Result containing the authenticated User on success, or an error on failure
  Future<Result<User>> socialLogin(String provider, String token);

  /// Verifies OAuth token and returns verification result.
  ///
  /// - [provider] OAuth provider ("Google" or "Facebook")
  /// - [accessToken] Access token from OAuth provider
  /// Returns Result containing OAuth verification data (email, fullName, needsRegistration, etc.)
  Future<Result<OAuthVerificationData>> verifyOAuth(
    String provider,
    String accessToken,
  );

  /// Logs in an existing user via OAuth.
  ///
  /// - [provider] OAuth provider ("Google" or "Facebook")
  /// - [token] Token from OAuth provider
  /// Returns Result containing the authenticated User on success
  Future<Result<User>> oauthLogin(String provider, String token);

  /// Completes registration for a new OAuth general user.
  /// Use this after verifyOAuth returns needsRegistration = true.
  ///
  /// - [tempToken] Temporary token received from verifyOAuth
  /// - [acceptsPrivacyPolicy] Whether the user accepts the privacy policy
  /// Returns Result containing authenticated User with JWT token (auto-login)
  Future<Result<User>> completeOAuthRegistrationGeneral({
    required String tempToken,
    required bool acceptsPrivacyPolicy,
  });

  /// Completes registration for a new OAuth psychologist user.
  /// Use this after verifyOAuth returns needsRegistration = true.
  /// Requires professional data and document uploads.
  ///
  /// - [tempToken] Temporary token received from verifyOAuth
  /// - [professionalLicense] Professional license number
  /// - [yearsOfExperience] Years of professional experience
  /// - [collegiateRegion] College region
  /// - [university] University name
  /// - [graduationYear] Year of graduation
  /// - [acceptsPrivacyPolicy] Whether the user accepts the privacy policy
  /// - [licenseDocumentUri] URI of license document file
  /// - [diplomaDocumentUri] URI of diploma certificate file
  /// - [dniDocumentUri] URI of DNI/identity document file
  /// - [specialties] Comma-separated list of specialties (optional)
  /// - [certificationDocumentUris] List of URIs for additional certificates (optional)
  /// Returns Result containing authenticated User with JWT token (auto-login, pending verification for psychologists)
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
  });
}

/// Data class representing OAuth verification result.
class OAuthVerificationData {
  final String email;
  final String fullName;
  final String provider;
  final String tempToken;
  final bool needsRegistration;
  final String? existingUserType;

  OAuthVerificationData({
    required this.email,
    required this.fullName,
    required this.provider,
    required this.tempToken,
    required this.needsRegistration,
    this.existingUserType,
  });
}

/// Data class representing registration result.
class RegisterResult {
  final String userId;
  final String email;

  RegisterResult({
    required this.userId,
    required this.email,
  });
}
