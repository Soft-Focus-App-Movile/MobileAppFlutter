import '../../../domain/repositories/auth_repository.dart';

/// Response DTO for user registration.
/// Backend returns: { message: "Registration successful", userId: "xxx", email: "xxx" }
/// Note: No token is provided. User must login after registration to get authentication token.
class RegisterResponseDto {
  final String message;
  final String userId;
  final String email;

  RegisterResponseDto({
    required this.message,
    required this.userId,
    required this.email,
  });

  factory RegisterResponseDto.fromJson(Map<String, dynamic> json) {
    return RegisterResponseDto(
      message: json['message'],
      userId: json['userId'],
      email: json['email'],
    );
  }

  RegisterResult toDomain() {
    return RegisterResult(
      userId: userId,
      email: email,
    );
  }
}
