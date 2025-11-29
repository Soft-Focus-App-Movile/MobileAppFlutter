// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference_list_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreferenceListResponseDto _$PreferenceListResponseDtoFromJson(
  Map<String, dynamic> json,
) => PreferenceListResponseDto(
  preferences: (json['preferences'] as List<dynamic>?)
      ?.map(
        (e) => NotificationPreferenceResponseDto.fromJson(
          e as Map<String, dynamic>,
        ),
      )
      .toList(),
);

Map<String, dynamic> _$PreferenceListResponseDtoToJson(
  PreferenceListResponseDto instance,
) => <String, dynamic>{'preferences': instance.preferences};
