// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'professional_profile_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfessionalProfileResponseDto _$ProfessionalProfileResponseDtoFromJson(
  Map<String, dynamic> json,
) => ProfessionalProfileResponseDto(
  professionalBio: json['professionalBio'] as String?,
  isAcceptingNewPatients: json['isAcceptingNewPatients'] as bool?,
  maxPatientsCapacity: (json['maxPatientsCapacity'] as num?)?.toInt(),
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
  isProfileVisibleInDirectory: json['isProfileVisibleInDirectory'] as bool?,
  allowsDirectMessages: json['allowsDirectMessages'] as bool?,
);

Map<String, dynamic> _$ProfessionalProfileResponseDtoToJson(
  ProfessionalProfileResponseDto instance,
) => <String, dynamic>{
  'professionalBio': instance.professionalBio,
  'isAcceptingNewPatients': instance.isAcceptingNewPatients,
  'maxPatientsCapacity': instance.maxPatientsCapacity,
  'targetAudience': instance.targetAudience,
  'languages': instance.languages,
  'businessName': instance.businessName,
  'businessAddress': instance.businessAddress,
  'bankAccount': instance.bankAccount,
  'paymentMethods': instance.paymentMethods,
  'isProfileVisibleInDirectory': instance.isProfileVisibleInDirectory,
  'allowsDirectMessages': instance.allowsDirectMessages,
};
