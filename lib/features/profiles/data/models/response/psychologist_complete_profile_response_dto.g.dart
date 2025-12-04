// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'psychologist_complete_profile_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsychologistCompleteProfileResponseDto
_$PsychologistCompleteProfileResponseDtoFromJson(Map<String, dynamic> json) =>
    PsychologistCompleteProfileResponseDto(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      userType: json['userType'] as String?,
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
      emailNotifications: json['emailNotifications'] as bool? ?? true,
      pushNotifications: json['pushNotifications'] as bool? ?? true,
      isProfilePublic: json['isProfilePublic'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      lastLogin: json['lastLogin'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      licenseNumber: json['licenseNumber'] as String?,
      professionalCollege: json['professionalCollege'] as String?,
      collegeRegion: json['collegeRegion'] as String?,
      specialties: (json['specialties'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      yearsOfExperience: (json['yearsOfExperience'] as num?)?.toInt(),
      university: json['university'] as String?,
      graduationYear: (json['graduationYear'] as num?)?.toInt(),
      degree: json['degree'] as String?,
      licenseDocumentUrl: json['licenseDocumentUrl'] as String?,
      diplomaCertificateUrl: json['diplomaCertificateUrl'] as String?,
      identityDocumentUrl: json['identityDocumentUrl'] as String?,
      additionalCertificatesUrls:
          (json['additionalCertificatesUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      isVerified: json['isVerified'] as bool? ?? false,
      verificationDate: json['verificationDate'] as String?,
      verifiedBy: json['verifiedBy'] as String?,
      verificationNotes: json['verificationNotes'] as String?,
      professionalBio: json['professionalBio'] as String?,
      isAcceptingNewPatients: json['isAcceptingNewPatients'] as bool? ?? true,
      maxPatientsCapacity: (json['maxPatientsCapacity'] as num?)?.toInt(),
      currentPatientsCount: (json['currentPatientsCount'] as num?)?.toInt(),
      targetAudience: (json['targetAudience'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      businessName: json['businessName'] as String?,
      businessAddress: json['businessAddress'] as String?,
      bankAccount: json['bankAccount'] as String?,
      paymentMethods: json['paymentMethods'] as String?,
      currency: json['currency'] as String?,
      isProfileVisibleInDirectory:
          json['isProfileVisibleInDirectory'] as bool? ?? true,
      allowsDirectMessages: json['allowsDirectMessages'] as bool? ?? true,
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      totalReviews: (json['totalReviews'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PsychologistCompleteProfileResponseDtoToJson(
  PsychologistCompleteProfileResponseDto instance,
) => <String, dynamic>{
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
  'licenseNumber': instance.licenseNumber,
  'professionalCollege': instance.professionalCollege,
  'collegeRegion': instance.collegeRegion,
  'specialties': instance.specialties,
  'yearsOfExperience': instance.yearsOfExperience,
  'university': instance.university,
  'graduationYear': instance.graduationYear,
  'degree': instance.degree,
  'licenseDocumentUrl': instance.licenseDocumentUrl,
  'diplomaCertificateUrl': instance.diplomaCertificateUrl,
  'identityDocumentUrl': instance.identityDocumentUrl,
  'additionalCertificatesUrls': instance.additionalCertificatesUrls,
  'isVerified': instance.isVerified,
  'verificationDate': instance.verificationDate,
  'verifiedBy': instance.verifiedBy,
  'verificationNotes': instance.verificationNotes,
  'professionalBio': instance.professionalBio,
  'isAcceptingNewPatients': instance.isAcceptingNewPatients,
  'maxPatientsCapacity': instance.maxPatientsCapacity,
  'currentPatientsCount': instance.currentPatientsCount,
  'targetAudience': instance.targetAudience,
  'languages': instance.languages,
  'businessName': instance.businessName,
  'businessAddress': instance.businessAddress,
  'bankAccount': instance.bankAccount,
  'paymentMethods': instance.paymentMethods,
  'currency': instance.currency,
  'isProfileVisibleInDirectory': instance.isProfileVisibleInDirectory,
  'allowsDirectMessages': instance.allowsDirectMessages,
  'averageRating': instance.averageRating,
  'totalReviews': instance.totalReviews,
};
