import 'package:json_annotation/json_annotation.dart';

part 'connect_with_psychologist_request_dto.g.dart';

@JsonSerializable()
class ConnectWithPsychologistRequestDto {
  final String connectionCode;

  const ConnectWithPsychologistRequestDto({
    required this.connectionCode,
  });

  Map<String, dynamic> toJson() => _$ConnectWithPsychologistRequestDtoToJson(this);
}
