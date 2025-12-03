// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_item_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentItemResponseDto _$ContentItemResponseDtoFromJson(
  Map<String, dynamic> json,
) => ContentItemResponseDto(
  externalId: json['id'] as String,
  id: json['_id'] as String?,
  type: json['type'] as String,
  title: json['title'] as String,
  overview: json['overview'] as String?,
  posterUrl: json['posterUrl'] as String?,
  backdropUrl: json['backdropUrl'] as String?,
  rating: const _StringOrNumberConverter().fromJson(json['rating']),
  duration: const _StringOrNumberConverter().fromJson(json['duration']),
  releaseDate: json['releaseDate'] as String?,
  genres: (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList(),
  trailerUrl: json['trailerUrl'] as String?,
  emotionalTags: (json['emotionalTags'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  externalUrl: json['externalUrl'] as String?,
  artist: json['artist'] as String?,
  album: json['album'] as String?,
  previewUrl: json['previewUrl'] as String?,
  spotifyUrl: json['spotifyUrl'] as String?,
  channelName: json['channelName'] as String?,
  youtubeUrl: json['youtubeUrl'] as String?,
  thumbnailUrl: json['thumbnailUrl'] as String?,
  category: json['category'] as String?,
  address: json['address'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  distance: (json['distance'] as num?)?.toDouble(),
  photoUrl: json['photoUrl'] as String?,
);

Map<String, dynamic> _$ContentItemResponseDtoToJson(
  ContentItemResponseDto instance,
) => <String, dynamic>{
  'id': instance.externalId,
  '_id': instance.id,
  'type': instance.type,
  'title': instance.title,
  'overview': instance.overview,
  'posterUrl': instance.posterUrl,
  'backdropUrl': instance.backdropUrl,
  'rating': const _StringOrNumberConverter().toJson(instance.rating),
  'duration': const _StringOrNumberConverter().toJson(instance.duration),
  'releaseDate': instance.releaseDate,
  'genres': instance.genres,
  'trailerUrl': instance.trailerUrl,
  'emotionalTags': instance.emotionalTags,
  'externalUrl': instance.externalUrl,
  'artist': instance.artist,
  'album': instance.album,
  'previewUrl': instance.previewUrl,
  'spotifyUrl': instance.spotifyUrl,
  'channelName': instance.channelName,
  'youtubeUrl': instance.youtubeUrl,
  'thumbnailUrl': instance.thumbnailUrl,
  'category': instance.category,
  'address': instance.address,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'distance': instance.distance,
  'photoUrl': instance.photoUrl,
};
