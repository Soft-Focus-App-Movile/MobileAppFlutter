// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_checkout_session_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCheckoutSessionRequestDto _$CreateCheckoutSessionRequestDtoFromJson(
  Map<String, dynamic> json,
) => CreateCheckoutSessionRequestDto(
  successUrl: json['successUrl'] as String,
  cancelUrl: json['cancelUrl'] as String,
);

Map<String, dynamic> _$CreateCheckoutSessionRequestDtoToJson(
  CreateCheckoutSessionRequestDto instance,
) => <String, dynamic>{
  'successUrl': instance.successUrl,
  'cancelUrl': instance.cancelUrl,
};
