import 'package:json_annotation/json_annotation.dart';

part 'content_search_request_dto.g.dart';

/// DTO para solicitud de búsqueda de contenido
@JsonSerializable()
class ContentSearchRequestDto {
  /// Término de búsqueda
  final String query;

  /// Tipo de contenido a buscar (Movie, Music, Video, Place)
  final String contentType;

  /// Filtro opcional por emoción
  final String? emotionFilter;

  /// Número máximo de resultados (1-100, default: 20)
  final int limit;

  const ContentSearchRequestDto({
    required this.query,
    required this.contentType,
    this.emotionFilter,
    this.limit = 20,
  });

  factory ContentSearchRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ContentSearchRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ContentSearchRequestDtoToJson(this);
}
