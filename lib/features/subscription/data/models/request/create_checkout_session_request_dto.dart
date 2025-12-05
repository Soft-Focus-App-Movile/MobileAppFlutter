import 'package:json_annotation/json_annotation.dart';

part 'create_checkout_session_request_dto.g.dart';

@JsonSerializable()
class CreateCheckoutSessionRequestDto {
  final String successUrl;
  final String cancelUrl;

  CreateCheckoutSessionRequestDto({
    required this.successUrl,
    required this.cancelUrl,
  });

  factory CreateCheckoutSessionRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateCheckoutSessionRequestDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreateCheckoutSessionRequestDtoToJson(this);
}
