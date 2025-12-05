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
  final String? successMessage;

  SubscriptionLoaded({
    required this.subscription,
    this.usageStats,
    this.checkoutUrl,
    this.isLoadingCheckout = false,
    this.successMessage,
  });

  SubscriptionLoaded copyWith({
    Subscription? subscription,
    UsageStats? usageStats,
    String? checkoutUrl,
    bool? isLoadingCheckout,
    bool clearCheckoutUrl = false,
    String? successMessage,
    bool clearSuccessMessage = false,
  }) {
    return SubscriptionLoaded(
      subscription: subscription ?? this.subscription,
      usageStats: usageStats ?? this.usageStats,
      checkoutUrl: clearCheckoutUrl ? null : (checkoutUrl ?? this.checkoutUrl),
      isLoadingCheckout: isLoadingCheckout ?? this.isLoadingCheckout,
      successMessage: clearSuccessMessage ? null : (successMessage ?? this.successMessage),
    );
  }
}

class SubscriptionError extends SubscriptionState {
  final String message;

  SubscriptionError({required this.message});
}
