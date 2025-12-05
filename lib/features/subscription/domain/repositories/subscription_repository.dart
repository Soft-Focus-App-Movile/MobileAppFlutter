import '../models/subscription.dart';
import '../models/checkout_session.dart';
import '../models/usage_stats.dart';

abstract class SubscriptionRepository {
  Future<Subscription> getMySubscription();
  Future<UsageStats> getUsageStats();
  Future<CheckoutSession> createCheckoutSession({
    required String successUrl,
    required String cancelUrl,
  });
  Future<Subscription> handleCheckoutSuccess({required String sessionId});
  Future<Subscription> initializeSubscription();
}
