import 'package:json_annotation/json_annotation.dart';

part 'connect_response_dto.g.dart';

@JsonSerializable()
class ConnectResponseDto {
  final String relationshipId;

  const ConnectResponseDto({
    required this.relationshipId,
  });

  factory ConnectResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ConnectResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ConnectResponseDtoToJson(this);
}
