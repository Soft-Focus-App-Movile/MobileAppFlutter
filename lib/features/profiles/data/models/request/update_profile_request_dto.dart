import 'package:json_annotation/json_annotation.dart';

part 'update_profile_request_dto.g.dart';

@JsonSerializable()
class UpdateProfileRequestDto {
  @JsonKey(name: 'FullName')
  final String fullName;

  @JsonKey(name: 'FirstName')
  final String? firstName;

  @JsonKey(name: 'LastName')
  final String? lastName;

  @JsonKey(name: 'DateOfBirth')
  final String? dateOfBirth;

  @JsonKey(name: 'Gender')
  final String? gender;

  @JsonKey(name: 'Phone')
  final String? phone;

  @JsonKey(name: 'Bio')
  final String? bio;

  @JsonKey(name: 'Country')
  final String? country;

  @JsonKey(name: 'City')
  final String? city;

  @JsonKey(name: 'Interests')
  final List<String>? interests;

  @JsonKey(name: 'MentalHealthGoals')
  final List<String>? mentalHealthGoals;

  @JsonKey(name: 'EmailNotifications')
  final bool? emailNotifications;

  @JsonKey(name: 'PushNotifications')
  final bool? pushNotifications;

  @JsonKey(name: 'IsProfilePublic')
  final bool? isProfilePublic;

  @JsonKey(name: 'ProfileImageUrl')
  final String? profileImageUrl;

  UpdateProfileRequestDto({
    required this.fullName,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.gender,
    this.phone,
    this.bio,
    this.country,
    this.city,
    this.interests,
    this.mentalHealthGoals,
    this.emailNotifications,
    this.pushNotifications,
    this.isProfilePublic,
    this.profileImageUrl,
  });

  factory UpdateProfileRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileRequestDtoToJson(this);
}
