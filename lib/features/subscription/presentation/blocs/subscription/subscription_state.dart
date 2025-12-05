import '../../../domain/models/subscription.dart';
import '../../../domain/models/usage_stats.dart';

abstract class SubscriptionState {}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionLoading extends SubscriptionState {}

class SubscriptionLoaded extends SubscriptionState {
  final Subscription subscription;
  final UsageStats? usageStats;
  final String? checkoutUrl;
  final bool isLoadingCheckout;

  SubscriptionLoaded({
    required this.subscription,
    this.usageStats,
    this.checkoutUrl,
    this.isLoadingCheckout = false,
  });

  SubscriptionLoaded copyWith({
    Subscription? subscription,
    UsageStats? usageStats,
    String? checkoutUrl,
    bool? isLoadingCheckout,
    bool clearCheckoutUrl = false,
  }) {
    return SubscriptionLoaded(
      subscription: subscription ?? this.subscription,
      usageStats: usageStats ?? this.usageStats,
      checkoutUrl: clearCheckoutUrl ? null : (checkoutUrl ?? this.checkoutUrl),
      isLoadingCheckout: isLoadingCheckout ?? this.isLoadingCheckout,
    );
  }
}

class SubscriptionError extends SubscriptionState {
  final String message;

  SubscriptionError({required this.message});
}
