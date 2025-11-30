import 'package:json_annotation/json_annotation.dart';
import 'content_item_response_dto.dart';

part 'content_list_response_dto.g.dart';

/// DTO para respuesta simple de lista de contenido (usado en recomendaciones)
@JsonSerializable()
class ContentListResponseDto {
  final List<ContentItemResponseDto> content;

  const ContentListResponseDto({
    required this.content,
  });

  factory ContentListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ContentListResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ContentListResponseDtoToJson(this);
}
