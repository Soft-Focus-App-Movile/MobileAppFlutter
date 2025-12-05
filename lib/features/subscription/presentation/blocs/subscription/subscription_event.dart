abstract class SubscriptionEvent {}

class LoadSubscription extends SubscriptionEvent {}

class LoadUsageStats extends SubscriptionEvent {}

class CreateCheckoutSession extends SubscriptionEvent {
  final String successUrl;
  final String cancelUrl;

  CreateCheckoutSession({
    required this.successUrl,
    required this.cancelUrl,
  });
}

class HandleCheckoutSuccess extends SubscriptionEvent {
  final String sessionId;

  HandleCheckoutSuccess({required this.sessionId});
}

class InitializeSubscription extends SubscriptionEvent {}

class ClearCheckoutUrl extends SubscriptionEvent {}
