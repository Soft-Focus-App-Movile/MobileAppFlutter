import 'package:json_annotation/json_annotation.dart';
import 'notification_preference_response_dto.dart';

part 'preference_list_response_dto.g.dart';

@JsonSerializable()
class PreferenceListResponseDto {
  final List<NotificationPreferenceResponseDto>? preferences;

  const PreferenceListResponseDto({this.preferences});

  factory PreferenceListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PreferenceListResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PreferenceListResponseDtoToJson(this);
}