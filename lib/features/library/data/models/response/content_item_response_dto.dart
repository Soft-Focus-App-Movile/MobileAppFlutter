import 'package:json_annotation/json_annotation.dart';

part 'content_item_response_dto.g.dart';

class _StringOrNumberConverter implements JsonConverter<String?, Object?> {
  const _StringOrNumberConverter();

  @override
  String? fromJson(Object? json) {
    if (json == null) return null;
    if (json is String) return json;
    if (json is num) return json.toString();
    return json.toString();
  }

  @override
  Object? toJson(String? object) => object;
}

@JsonSerializable()
class ContentItemResponseDto {
  @JsonKey(name: 'id')
  final String externalId;

  @JsonKey(name: '_id')
  final String? id;

  final String type;
  final String title;
  final String? overview;
  final String? posterUrl;
  final String? backdropUrl;

  @_StringOrNumberConverter()
  final String? rating;

  @_StringOrNumberConverter()
  final String? duration;

  final String? releaseDate;
  final List<String>? genres;
  final String? trailerUrl;
  final List<String>? emotionalTags;
  final String? externalUrl;

  // Music specific
  final String? artist;
  final String? album;
  final String? previewUrl;
  final String? spotifyUrl;

  // Video specific
  final String? channelName;
  final String? youtubeUrl;
  final String? thumbnailUrl;

  // Place specific
  final String? category;
  final String? address;
  final double? latitude;
  final double? longitude;
  final double? distance;
  final String? photoUrl;

  const ContentItemResponseDto({
    required this.externalId,
    this.id,
    required this.type,
    required this.title,
    this.overview,
    this.posterUrl,
    this.backdropUrl,
    this.rating,
    this.duration,
    this.releaseDate,
    this.genres,
    this.trailerUrl,
    this.emotionalTags,
    this.externalUrl,
    this.artist,
    this.album,
    this.previewUrl,
    this.spotifyUrl,
    this.channelName,
    this.youtubeUrl,
    this.thumbnailUrl,
    this.category,
    this.address,
    this.latitude,
    this.longitude,
    this.distance,
    this.photoUrl,
  });

  factory ContentItemResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ContentItemResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ContentItemResponseDtoToJson(this);
}
