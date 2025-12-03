import 'package:json_annotation/json_annotation.dart';
import '../../../domain/models/invitation_code.dart';

part 'invitation_code_response_dto.g.dart';

@JsonSerializable()
class InvitationCodeResponseDto {
  @JsonKey(name: 'invitationCode')
  final String code;

  final String generatedAt;
  final String expiresAt;
  final bool isExpired;
  final String timeUntilExpiration;

  InvitationCodeResponseDto({
    required this.code,
    required this.generatedAt,
    required this.expiresAt,
    required this.isExpired,
    required this.timeUntilExpiration,
  });

  factory InvitationCodeResponseDto.fromJson(Map<String, dynamic> json) =>
      _$InvitationCodeResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$InvitationCodeResponseDtoToJson(this);

  InvitationCode toDomain() {
    return InvitationCode(
      code: code,
      expiresAt: expiresAt,
      timeUntilExpiration: timeUntilExpiration,
    );
  }
}
