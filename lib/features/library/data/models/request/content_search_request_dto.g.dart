// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_search_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentSearchRequestDto _$ContentSearchRequestDtoFromJson(
  Map<String, dynamic> json,
) => ContentSearchRequestDto(
  query: json['query'] as String,
  contentType: json['contentType'] as String,
  emotionFilter: json['emotionFilter'] as String?,
  limit: (json['limit'] as num?)?.toInt() ?? 20,
);

Map<String, dynamic> _$ContentSearchRequestDtoToJson(
  ContentSearchRequestDto instance,
) => <String, dynamic>{
  'query': instance.query,
  'contentType': instance.contentType,
  'emotionFilter': instance.emotionFilter,
  'limit': instance.limit,
};
