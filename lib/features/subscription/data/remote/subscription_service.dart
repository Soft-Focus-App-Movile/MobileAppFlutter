import 'dart:convert';
import '../../../../core/networking/http_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/response/subscription_response_dto.dart';
import '../models/response/checkout_session_response_dto.dart';
import '../models/response/usage_stats_response_dto.dart';
import '../models/request/create_checkout_session_request_dto.dart';

class SubscriptionService {
  final HttpClient _httpClient;

  SubscriptionService({HttpClient? httpClient})
      : _httpClient = httpClient ?? HttpClient();

  Future<SubscriptionResponseDto> getMySubscription() async {
    final response = await _httpClient.get(SubscriptionEndpoints.me);
    if (response.statusCode == 200) {
      return SubscriptionResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al obtener suscripción: ${response.body}');
    }
  }

  Future<UsageStatsResponseDto> getUsageStats() async {
    final response = await _httpClient.get(SubscriptionEndpoints.usage);
    if (response.statusCode == 200) {
      return UsageStatsResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al obtener estadísticas de uso: ${response.body}');
    }
  }

  Future<CheckoutSessionResponseDto> createCheckoutSession({
    required String successUrl,
    required String cancelUrl,
  }) async {
    final requestDto = CreateCheckoutSessionRequestDto(
      successUrl: successUrl,
      cancelUrl: cancelUrl,
    );

    final response = await _httpClient.post(
      SubscriptionEndpoints.upgradeCheckout,
      body: requestDto.toJson(),
    );

    if (response.statusCode == 200) {
      return CheckoutSessionResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al crear sesión de pago: ${response.body}');
    }
  }

  Future<SubscriptionResponseDto> handleCheckoutSuccess({
    required String sessionId,
  }) async {
    final response = await _httpClient.post(
      '${SubscriptionEndpoints.checkoutSuccess}?sessionId=$sessionId',
    );

    if (response.statusCode == 200) {
      return SubscriptionResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al confirmar pago: ${response.body}');
    }
  }

  Future<SubscriptionResponseDto> initializeSubscription() async {
    final response = await _httpClient.post(SubscriptionEndpoints.initialize);
    if (response.statusCode == 200) {
      return SubscriptionResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al inicializar suscripción: ${response.body}');
    }
  }
}
