import 'package:json_annotation/json_annotation.dart';
import '../../../domain/models/checkout_session.dart';

part 'checkout_session_response_dto.g.dart';

@JsonSerializable()
class CheckoutSessionResponseDto {
  final String sessionId;
  final String checkoutUrl;

  CheckoutSessionResponseDto({
    required this.sessionId,
    required this.checkoutUrl,
  });

  factory CheckoutSessionResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CheckoutSessionResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutSessionResponseDtoToJson(this);

  CheckoutSession toDomain() {
    return CheckoutSession(
      sessionId: sessionId,
      checkoutUrl: checkoutUrl,
    );
  }
}
