// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessageItemDto _$ChatMessageItemDtoFromJson(Map<String, dynamic> json) =>
    ChatMessageItemDto(
      role: json['role'] as String,
      content: json['content'] as String,
      timestamp: json['timestamp'] as String,
      suggestedQuestions:
          (json['suggestedQuestions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ChatMessageItemDtoToJson(ChatMessageItemDto instance) =>
    <String, dynamic>{
      'role': instance.role,
      'content': instance.content,
      'timestamp': instance.timestamp,
      'suggestedQuestions': instance.suggestedQuestions,
    };
