import 'package:json_annotation/json_annotation.dart';
import '../../../domain/models/patient_profile.dart';

part 'patient_profile_response_dto.g.dart';

@JsonSerializable()
class PatientProfileResponseDto {
  final String id;
  final String email;
  final String fullName;
  final String? firstName;
  final String? lastName;
  final String userType;
  final String? dateOfBirth;
  final String? gender;
  final String? phone;
  final String? profileImageUrl;
  final String? bio;
  final String? country;
  final String? city;
  final List<String>? interests;
  final List<String>? mentalHealthGoals;
  final bool emailNotifications;
  final bool pushNotifications;
  final bool isProfilePublic;
  final bool isActive;
  final String? lastLogin;
  final String createdAt;
  final String updatedAt;

  const PatientProfileResponseDto({
    required this.id,
    required this.email,
    required this.fullName,
    this.firstName,
    this.lastName,
    required this.userType,
    this.dateOfBirth,
    this.gender,
    this.phone,
    this.profileImageUrl,
    this.bio,
    this.country,
    this.city,
    this.interests,
    this.mentalHealthGoals,
    required this.emailNotifications,
    required this.pushNotifications,
    required this.isProfilePublic,
    required this.isActive,
    this.lastLogin,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PatientProfileResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PatientProfileResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PatientProfileResponseDtoToJson(this);

  /// Convierte el DTO al modelo de dominio limpio
  PatientProfile toDomain() {
    return PatientProfile(
      id: id,
      fullName: fullName,
      profilePhotoUrl: profileImageUrl ?? "",
      dateOfBirth: dateOfBirth,
      createdAt: createdAt
    );
  }
}