import 'package:json_annotation/json_annotation.dart';

part 'favorite_request_dto.g.dart';

/// DTO para solicitud de favorito
@JsonSerializable()
class FavoriteRequestDto {
  /// ID del contenido
  final String contentId;

  /// Tipo de contenido (Movie, Music, Video, Place)
  final String contentType;

  const FavoriteRequestDto({
    required this.contentId,
    required this.contentType,
  });

  factory FavoriteRequestDto.fromJson(Map<String, dynamic> json) =>
      _$FavoriteRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteRequestDtoToJson(this);
}
