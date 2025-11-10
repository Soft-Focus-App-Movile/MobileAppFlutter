import '../../../domain/models/user.dart';
import '../../../domain/models/user_type.dart';

/// Response DTO for login matching backend's actual response structure.
/// Backend returns: { user: {...}, token: "...", expiresAt: "...", tokenType: "..." }
class LoginResponseDto {
  final UserDataDto user;
  final String token;
  final String expiresAt;
  final String tokenType;

  LoginResponseDto({
    required this.user,
    required this.token,
    required this.expiresAt,
    this.tokenType = "Bearer",
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    return LoginResponseDto(
      user: UserDataDto.fromJson(json['user']),
      token: json['token'],
      expiresAt: json['expiresAt'],
      tokenType: json['tokenType'] ?? "Bearer",
    );
  }

  User toDomain() {
    final userType = _mapRoleToUserType(user.role);
    return User(
      id: user.id,
      email: user.email,
      userType: userType,
      // Use backend's isVerified if available, otherwise default to true for general users
      // and false for psychologists (pending verification)
      isVerified: user.isVerified ?? (userType != UserType.PSYCHOLOGIST),
      token: token,
      fullName: user.fullName,
    );
  }

  UserType _mapRoleToUserType(String role) {
    switch (role.toUpperCase()) {
      case 'GENERAL':
        return UserType.GENERAL;
      case 'PSYCHOLOGIST':
        return UserType.PSYCHOLOGIST;
      case 'PATIENT':
        return UserType.PATIENT;
      case 'ADMIN':
        return UserType.ADMIN;
      default:
        return UserType.GENERAL;
    }
  }
}

class UserDataDto {
  final String id;
  final String fullName;
  final String email;
  final String role;
  final String? profileImageUrl;
  final String? lastLogin;
  final String? roleDisplay;
  final UserCapabilitiesDto? capabilities;
  final bool? isVerified; // For psychologists, indicates if account is verified

  UserDataDto({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    this.profileImageUrl,
    this.lastLogin,
    this.roleDisplay,
    this.capabilities,
    this.isVerified,
  });

  factory UserDataDto.fromJson(Map<String, dynamic> json) {
    return UserDataDto(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      role: json['role'],
      profileImageUrl: json['profileImageUrl'],
      lastLogin: json['lastLogin'],
      roleDisplay: json['roleDisplay'],
      capabilities: json['capabilities'] != null
          ? UserCapabilitiesDto.fromJson(json['capabilities'])
          : null,
      isVerified: json['isVerified'],
    );
  }
}

class UserCapabilitiesDto {
  final bool canManageUsers;
  final bool canProvideTherapy;
  final bool canAccessPremiumFeatures;
  final bool isAdmin;
  final bool isPsychologist;
  final bool isGeneral;

  UserCapabilitiesDto({
    this.canManageUsers = false,
    this.canProvideTherapy = false,
    this.canAccessPremiumFeatures = false,
    this.isAdmin = false,
    this.isPsychologist = false,
    this.isGeneral = false,
  });

  factory UserCapabilitiesDto.fromJson(Map<String, dynamic> json) {
    return UserCapabilitiesDto(
      canManageUsers: json['canManageUsers'] ?? false,
      canProvideTherapy: json['canProvideTherapy'] ?? false,
      canAccessPremiumFeatures: json['canAccessPremiumFeatures'] ?? false,
      isAdmin: json['isAdmin'] ?? false,
      isPsychologist: json['isPsychologist'] ?? false,
      isGeneral: json['isGeneral'] ?? false,
    );
  }
}
