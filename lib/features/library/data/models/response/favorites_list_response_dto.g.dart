// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_list_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteItemResponseDto _$FavoriteItemResponseDtoFromJson(
  Map<String, dynamic> json,
) => FavoriteItemResponseDto(
  id: json['favoriteId'] as String?,
  userId: json['userId'] as String?,
  content: json['content'] == null
      ? null
      : ContentItemResponseDto.fromJson(
          json['content'] as Map<String, dynamic>,
        ),
  addedAt: json['addedAt'] as String?,
);

Map<String, dynamic> _$FavoriteItemResponseDtoToJson(
  FavoriteItemResponseDto instance,
) => <String, dynamic>{
  'favoriteId': instance.id,
  'userId': instance.userId,
  'content': instance.content,
  'addedAt': instance.addedAt,
};

FavoritesListResponseDto _$FavoritesListResponseDtoFromJson(
  Map<String, dynamic> json,
) => FavoritesListResponseDto(
  favorites: (json['favorites'] as List<dynamic>)
      .map((e) => FavoriteItemResponseDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num?)?.toInt(),
);

Map<String, dynamic> _$FavoritesListResponseDtoToJson(
  FavoritesListResponseDto instance,
) => <String, dynamic>{
  'favorites': instance.favorites,
  'total': instance.total,
};
