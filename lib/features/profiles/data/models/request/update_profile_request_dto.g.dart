// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileRequestDto _$UpdateProfileRequestDtoFromJson(
  Map<String, dynamic> json,
) => UpdateProfileRequestDto(
  fullName: json['FullName'] as String,
  firstName: json['FirstName'] as String?,
  lastName: json['LastName'] as String?,
  dateOfBirth: json['DateOfBirth'] as String?,
  gender: json['Gender'] as String?,
  phone: json['Phone'] as String?,
  bio: json['Bio'] as String?,
  country: json['Country'] as String?,
  city: json['City'] as String?,
  interests: (json['Interests'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  mentalHealthGoals: (json['MentalHealthGoals'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  emailNotifications: json['EmailNotifications'] as bool?,
  pushNotifications: json['PushNotifications'] as bool?,
  isProfilePublic: json['IsProfilePublic'] as bool?,
  profileImageUrl: json['ProfileImageUrl'] as String?,
);

Map<String, dynamic> _$UpdateProfileRequestDtoToJson(
  UpdateProfileRequestDto instance,
) => <String, dynamic>{
  'FullName': instance.fullName,
  'FirstName': instance.firstName,
  'LastName': instance.lastName,
  'DateOfBirth': instance.dateOfBirth,
  'Gender': instance.gender,
  'Phone': instance.phone,
  'Bio': instance.bio,
  'Country': instance.country,
  'City': instance.city,
  'Interests': instance.interests,
  'MentalHealthGoals': instance.mentalHealthGoals,
  'EmailNotifications': instance.emailNotifications,
  'PushNotifications': instance.pushNotifications,
  'IsProfilePublic': instance.isProfilePublic,
  'ProfileImageUrl': instance.profileImageUrl,
};
