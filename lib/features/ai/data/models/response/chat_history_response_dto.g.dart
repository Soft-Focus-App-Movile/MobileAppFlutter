// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_history_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatHistoryResponseDto _$ChatHistoryResponseDtoFromJson(
  Map<String, dynamic> json,
) => ChatHistoryResponseDto(
  sessions: (json['sessions'] as List<dynamic>)
      .map((e) => ChatSessionResponseDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalCount: (json['totalCount'] as num).toInt(),
);

Map<String, dynamic> _$ChatHistoryResponseDtoToJson(
  ChatHistoryResponseDto instance,
) => <String, dynamic>{
  'sessions': instance.sessions,
  'totalCount': instance.totalCount,
};
