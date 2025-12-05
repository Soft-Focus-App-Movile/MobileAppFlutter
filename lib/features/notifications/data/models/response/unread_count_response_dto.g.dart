// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unread_count_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnreadCountResponseDto _$UnreadCountResponseDtoFromJson(
  Map<String, dynamic> json,
) => UnreadCountResponseDto(
  unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$UnreadCountResponseDtoToJson(
  UnreadCountResponseDto instance,
) => <String, dynamic>{'unread_count': instance.unreadCount};
