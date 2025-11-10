/// Request DTO for general user registration.
/// Endpoint: POST /api/v1/auth/register/general
class RegisterGeneralUserRequestDto {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final bool acceptsPrivacyPolicy;

  RegisterGeneralUserRequestDto({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.acceptsPrivacyPolicy,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'acceptsPrivacyPolicy': acceptsPrivacyPolicy,
    };
  }
}
