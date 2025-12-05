import 'package:json_annotation/json_annotation.dart';
import 'content_item_response_dto.dart';

part 'favorites_list_response_dto.g.dart';

@JsonSerializable()
class FavoriteItemResponseDto {
  @JsonKey(name: 'favoriteId')
  final String? id;

  @JsonKey(name: 'userId')
  final String? userId;

  @JsonKey(name: 'content')
  final ContentItemResponseDto? content;

  @JsonKey(name: 'addedAt')
  final String? addedAt;

  const FavoriteItemResponseDto({
    this.id,
    this.userId,
    this.content,
    this.addedAt,
  });

  factory FavoriteItemResponseDto.fromJson(Map<String, dynamic> json) =>
      _$FavoriteItemResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteItemResponseDtoToJson(this);
}

@JsonSerializable()
class FavoritesListResponseDto {
  final List<FavoriteItemResponseDto> favorites;
  final int? total;

  const FavoritesListResponseDto({
    required this.favorites,
    this.total,
  });

  factory FavoritesListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$FavoritesListResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FavoritesListResponseDtoToJson(this);
}
