// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_list_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentListResponseDto _$ContentListResponseDtoFromJson(
  Map<String, dynamic> json,
) => ContentListResponseDto(
  content: (json['content'] as List<dynamic>)
      .map((e) => ContentItemResponseDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ContentListResponseDtoToJson(
  ContentListResponseDto instance,
) => <String, dynamic>{'content': instance.content};
