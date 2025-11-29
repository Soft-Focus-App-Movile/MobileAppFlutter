// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_preferences_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePreferencesRequestDto _$UpdatePreferencesRequestDtoFromJson(
  Map<String, dynamic> json,
) => UpdatePreferencesRequestDto(
  preferences: (json['preferences'] as List<dynamic>)
      .map((e) => NotificationPreferenceDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$UpdatePreferencesRequestDtoToJson(
  UpdatePreferencesRequestDto instance,
) => <String, dynamic>{'preferences': instance.preferences};
