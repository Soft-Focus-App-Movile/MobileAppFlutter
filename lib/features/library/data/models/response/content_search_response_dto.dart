import 'package:json_annotation/json_annotation.dart';
import 'content_item_response_dto.dart';

part 'content_search_response_dto.g.dart';

/// DTO para respuesta paginada de búsqueda de contenido
@JsonSerializable()
class ContentSearchResponseDto {
  /// Lista de contenidos encontrados
  final List<ContentItemResponseDto> results;

  /// Número total de resultados
  final int totalResults;

  /// Página actual
  final int page;

  const ContentSearchResponseDto({
    required this.results,
    required this.totalResults,
    required this.page,
  });

  factory ContentSearchResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ContentSearchResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ContentSearchResponseDtoToJson(this);
}
