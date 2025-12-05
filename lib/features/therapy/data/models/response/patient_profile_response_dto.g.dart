// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_profile_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientProfileResponseDto _$PatientProfileResponseDtoFromJson(
        Map<String, dynamic> json) =>
    PatientProfileResponseDto(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      userType: json['userType'] as String,
      dateOfBirth: json['dateOfBirth'] as String?,
      gender: json['gender'] as String?,
      phone: json['phone'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      bio: json['bio'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      interests: (json['interests'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      mentalHealthGoals: (json['mentalHealthGoals'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      emailNotifications: json['emailNotifications'] as bool,
      pushNotifications: json['pushNotifications'] as bool,
      isProfilePublic: json['isProfilePublic'] as bool,
      isActive: json['isActive'] as bool,
      lastLogin: json['lastLogin'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$PatientProfileResponseDtoToJson(
        PatientProfileResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'fullName': instance.fullName,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'userType': instance.userType,
      'dateOfBirth': instance.dateOfBirth,
      'gender': instance.gender,
      'phone': instance.phone,
      'profileImageUrl': instance.profileImageUrl,
      'bio': instance.bio,
      'country': instance.country,
      'city': instance.city,
      'interests': instance.interests,
      'mentalHealthGoals': instance.mentalHealthGoals,
      'emailNotifications': instance.emailNotifications,
      'pushNotifications': instance.pushNotifications,
      'isProfilePublic': instance.isProfilePublic,
      'isActive': instance.isActive,
      'lastLogin': instance.lastLogin,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };