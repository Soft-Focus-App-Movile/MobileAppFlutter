// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_search_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentSearchResponseDto _$ContentSearchResponseDtoFromJson(
  Map<String, dynamic> json,
) => ContentSearchResponseDto(
  results: (json['results'] as List<dynamic>)
      .map((e) => ContentItemResponseDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalResults: (json['totalResults'] as num).toInt(),
  page: (json['page'] as num).toInt(),
);

Map<String, dynamic> _$ContentSearchResponseDtoToJson(
  ContentSearchResponseDto instance,
) => <String, dynamic>{
  'results': instance.results,
  'totalResults': instance.totalResults,
  'page': instance.page,
};
