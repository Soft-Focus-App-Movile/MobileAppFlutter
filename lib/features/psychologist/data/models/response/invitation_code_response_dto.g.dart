// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitation_code_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvitationCodeResponseDto _$InvitationCodeResponseDtoFromJson(
  Map<String, dynamic> json,
) => InvitationCodeResponseDto(
  code: json['invitationCode'] as String,
  generatedAt: json['generatedAt'] as String,
  expiresAt: json['expiresAt'] as String,
  isExpired: json['isExpired'] as bool,
  timeUntilExpiration: json['timeUntilExpiration'] as String,
);

Map<String, dynamic> _$InvitationCodeResponseDtoToJson(
  InvitationCodeResponseDto instance,
) => <String, dynamic>{
  'invitationCode': instance.code,
  'generatedAt': instance.generatedAt,
  'expiresAt': instance.expiresAt,
  'isExpired': instance.isExpired,
  'timeUntilExpiration': instance.timeUntilExpiration,
};
