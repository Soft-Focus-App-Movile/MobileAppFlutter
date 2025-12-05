import '../../domain/models/subscription.dart';
import '../../domain/models/checkout_session.dart';
import '../../domain/models/usage_stats.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../remote/subscription_service.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final SubscriptionService _subscriptionService;

  SubscriptionRepositoryImpl({
    required SubscriptionService service,
  }) : _subscriptionService = service;

  @override
  Future<Subscription> getMySubscription() async {
    try {
      final response = await _subscriptionService.getMySubscription();
      return response.toDomain();
    } catch (e) {
      throw Exception('Error al obtener suscripción: ${_extractErrorMessage(e)}');
    }
  }

  @override
  Future<UsageStats> getUsageStats() async {
    try {
      final response = await _subscriptionService.getUsageStats();
      return response.toDomain();
    } catch (e) {
      throw Exception('Error al obtener estadísticas de uso: ${_extractErrorMessage(e)}');
    }
  }

  @override
  Future<CheckoutSession> createCheckoutSession({
    required String successUrl,
    required String cancelUrl,
  }) async {
    try {
      final response = await _subscriptionService.createCheckoutSession(
        successUrl: successUrl,
        cancelUrl: cancelUrl,
      );
      return response.toDomain();
    } catch (e) {
      throw Exception('Error al crear sesión de pago: ${_extractErrorMessage(e)}');
    }
  }

  @override
  Future<Subscription> handleCheckoutSuccess({required String sessionId}) async {
    try {
      final response = await _subscriptionService.handleCheckoutSuccess(
        sessionId: sessionId,
      );
      return response.toDomain();
    } catch (e) {
      throw Exception('Error al confirmar pago: ${_extractErrorMessage(e)}');
    }
  }

  @override
  Future<Subscription> initializeSubscription() async {
    try {
      final response = await _subscriptionService.initializeSubscription();
      return response.toDomain();
    } catch (e) {
      throw Exception('Error al inicializar suscripción: ${_extractErrorMessage(e)}');
    }
  }

  String _extractErrorMessage(dynamic error) {
    final errorString = error.toString();

    if (errorString.contains('Exception: ')) {
      return errorString.split('Exception: ').last;
    } else if (errorString.contains('failed: ')) {
      return errorString.split('failed: ').last;
    }

    return 'An error occurred: $errorString';
  }
}
