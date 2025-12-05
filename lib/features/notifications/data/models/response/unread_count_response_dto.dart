import 'package:json_annotation/json_annotation.dart';

part 'unread_count_response_dto.g.dart';

@JsonSerializable()
class UnreadCountResponseDto {
  @JsonKey(name: 'unread_count', defaultValue: 0)
  final int unreadCount;

  const UnreadCountResponseDto({required this.unreadCount});

  factory UnreadCountResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UnreadCountResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UnreadCountResponseDtoToJson(this);
}