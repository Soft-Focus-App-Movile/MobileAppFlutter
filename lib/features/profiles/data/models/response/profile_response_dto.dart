import 'package:json_annotation/json_annotation.dart';
import '../../../../auth/domain/models/user.dart';
import '../../../../auth/domain/models/user_type.dart';

part 'profile_response_dto.g.dart';

@JsonSerializable()
class ProfileResponseDto {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'fullName')
  final String fullName;

  @JsonKey(name: 'firstName')
  final String? firstName;

  @JsonKey(name: 'lastName')
  final String? lastName;

  @JsonKey(name: 'userType')
  final String userType;

  @JsonKey(name: 'dateOfBirth')
  final String? dateOfBirth;

  @JsonKey(name: 'gender')
  final String? gender;

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'profileImageUrl')
  final String? profileImageUrl;

  @JsonKey(name: 'bio')
  final String? bio;

  @JsonKey(name: 'country')
  final String? country;

  @JsonKey(name: 'city')
  final String? city;

  @JsonKey(name: 'interests')
  final List<String>? interests;

  @JsonKey(name: 'mentalHealthGoals')
  final List<String>? mentalHealthGoals;

  @JsonKey(name: 'emailNotifications')
  final bool emailNotifications;

  @JsonKey(name: 'pushNotifications')
  final bool pushNotifications;

  @JsonKey(name: 'isProfilePublic')
  final bool isProfilePublic;

  @JsonKey(name: 'isActive')
  final bool isActive;

  @JsonKey(name: 'isVerified')
  final bool isVerified;

  @JsonKey(name: 'lastLogin')
  final String? lastLogin;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  ProfileResponseDto({
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
    this.emailNotifications = true,
    this.pushNotifications = true,
    this.isProfilePublic = false,
    this.isActive = true,
    this.isVerified = false,
    this.lastLogin,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfileResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseDtoToJson(this);

  User toDomain(String? token) {
    UserType parsedUserType;
    try {
      parsedUserType = UserType.values.firstWhere(
        (e) => e.toString().split('.').last.toUpperCase() == userType.toUpperCase(),
        orElse: () => UserType.GENERAL,
      );
    } catch (e) {
      parsedUserType = UserType.GENERAL;
    }

    return User(
      id: id,
      email: email,
      userType: parsedUserType,
      isVerified: isVerified,
      token: token,
      fullName: fullName,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      gender: gender,
      phone: phone,
      profileImageUrl: profileImageUrl,
      bio: bio,
      country: country,
      city: city,
      interests: interests,
      mentalHealthGoals: mentalHealthGoals,
      emailNotifications: emailNotifications,
      pushNotifications: pushNotifications,
      isProfilePublic: isProfilePublic,
    );
  }
}
