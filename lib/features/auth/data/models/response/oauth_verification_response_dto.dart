import '../../../domain/repositories/auth_repository.dart';

/// Response DTO from OAuth verification endpoint.
/// Contains user info and whether registration is needed.
class OAuthVerificationResponseDto {
  final String email;
  final String fullName;
  final String provider;
  final String tempToken;
  final bool needsRegistration;
  final String? existingUserType;

  OAuthVerificationResponseDto({
    required this.email,
    required this.fullName,
    required this.provider,
    required this.tempToken,
    required this.needsRegistration,
    this.existingUserType,
  });

  factory OAuthVerificationResponseDto.fromJson(Map<String, dynamic> json) {
    return OAuthVerificationResponseDto(
      email: json['email'],
      fullName: json['fullName'],
      provider: json['provider'],
      tempToken: json['tempToken'],
      needsRegistration: json['needsRegistration'],
      existingUserType: json['existingUserType'],
    );
  }

  OAuthVerificationData toDomain() {
    return OAuthVerificationData(
      email: email,
      fullName: fullName,
      provider: provider,
      tempToken: tempToken,
      needsRegistration: needsRegistration,
      existingUserType: existingUserType,
    );
  }
}
