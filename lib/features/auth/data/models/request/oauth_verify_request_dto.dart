/// Request DTO for verifying OAuth token with backend.
/// This is the first step in OAuth authentication flow.
class OAuthVerifyRequestDto {
  final String provider; // "Google" or "Facebook"
  final String accessToken;
  final String? refreshToken;
  final String? expiresAt;

  OAuthVerifyRequestDto({
    required this.provider,
    required this.accessToken,
    this.refreshToken,
    this.expiresAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'provider': provider,
      'accessToken': accessToken,
      if (refreshToken != null) 'refreshToken': refreshToken,
      if (expiresAt != null) 'expiresAt': expiresAt,
    };
  }
}
