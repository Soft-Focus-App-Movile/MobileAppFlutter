// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_session_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutSessionResponseDto _$CheckoutSessionResponseDtoFromJson(
  Map<String, dynamic> json,
) => CheckoutSessionResponseDto(
  sessionId: json['sessionId'] as String,
  checkoutUrl: json['checkoutUrl'] as String,
);

Map<String, dynamic> _$CheckoutSessionResponseDtoToJson(
  CheckoutSessionResponseDto instance,
) => <String, dynamic>{
  'sessionId': instance.sessionId,
  'checkoutUrl': instance.checkoutUrl,
};
