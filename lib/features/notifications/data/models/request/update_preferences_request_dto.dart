import 'package:json_annotation/json_annotation.dart';
import 'notification_preference_dto.dart';

part 'update_preferences_request_dto.g.dart';

@JsonSerializable()
class UpdatePreferencesRequestDto {
  @JsonKey(name: 'preferences')
  final List<NotificationPreferenceDto> preferences;

  const UpdatePreferencesRequestDto({required this.preferences});

  factory UpdatePreferencesRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdatePreferencesRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePreferencesRequestDtoToJson(this);
}