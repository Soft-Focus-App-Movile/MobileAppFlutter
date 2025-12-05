import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/subscription_repository.dart';
import 'subscription_event.dart';
import 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final SubscriptionRepository subscriptionRepository;

  SubscriptionBloc({
    required this.subscriptionRepository,
  }) : super(SubscriptionInitial()) {
    on<LoadSubscription>(_onLoadSubscription);
    on<LoadUsageStats>(_onLoadUsageStats);
    on<CreateCheckoutSession>(_onCreateCheckoutSession);
    on<HandleCheckoutSuccess>(_onHandleCheckoutSuccess);
    on<InitializeSubscription>(_onInitializeSubscription);
    on<ClearCheckoutUrl>(_onClearCheckoutUrl);
  }

  Future<void> _onLoadSubscription(
    LoadSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionLoading());
    try {
      final subscription = await subscriptionRepository.getMySubscription();
      emit(SubscriptionLoaded(subscription: subscription));
    } catch (e) {
      emit(SubscriptionError(message: e.toString()));
    }
  }

  Future<void> _onLoadUsageStats(
    LoadUsageStats event,
    Emitter<SubscriptionState> emit,
  ) async {
    final currentState = state;
    if (currentState is SubscriptionLoaded) {
      try {
        final usageStats = await subscriptionRepository.getUsageStats();
        emit(currentState.copyWith(usageStats: usageStats));
      } catch (e) {
        emit(SubscriptionError(message: e.toString()));
      }
    }
  }

  Future<void> _onCreateCheckoutSession(
    CreateCheckoutSession event,
    Emitter<SubscriptionState> emit,
  ) async {
    final currentState = state;
    if (currentState is SubscriptionLoaded) {
      emit(currentState.copyWith(isLoadingCheckout: true));
      try {
        final checkoutSession =
            await subscriptionRepository.createCheckoutSession(
          successUrl: event.successUrl,
          cancelUrl: event.cancelUrl,
        );
        emit(currentState.copyWith(
          checkoutUrl: checkoutSession.checkoutUrl,
          isLoadingCheckout: false,
        ));
      } catch (e) {
        emit(SubscriptionError(message: e.toString()));
      }
    }
  }

  Future<void> _onHandleCheckoutSuccess(
    HandleCheckoutSuccess event,
    Emitter<SubscriptionState> emit,
  ) async {
    final currentState = state;

    // Show loading but keep the current subscription visible
    if (currentState is SubscriptionLoaded) {
      emit(currentState.copyWith(isLoadingCheckout: true, clearCheckoutUrl: true));
    } else {
      emit(SubscriptionLoading());
    }

    try {
      print('🔄 Processing checkout success with sessionId: ${event.sessionId}');

      final subscription = await subscriptionRepository.handleCheckoutSuccess(
        sessionId: event.sessionId,
      );

      print('✅ Payment processed successfully. New plan: ${subscription.plan}, Status: ${subscription.status}');
      print('✅ Subscription updated successfully to: ${subscription.plan}');

      emit(SubscriptionLoaded(
        subscription: subscription,
        successMessage: '¡Pago exitoso! Ahora tienes el Plan Pro',
        isLoadingCheckout: false,
      ));
    } catch (e) {
      print('❌ Error processing payment: $e');

      // Close WebView even on error so user isn't stuck
      if (currentState is SubscriptionLoaded) {
        emit(currentState.copyWith(clearCheckoutUrl: true, isLoadingCheckout: false));
      }

      emit(SubscriptionError(message: e.toString()));
    }
  }

  Future<void> _onInitializeSubscription(
    InitializeSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionLoading());
    try {
      final subscription = await subscriptionRepository.initializeSubscription();
      emit(SubscriptionLoaded(subscription: subscription));
    } catch (e) {
      emit(SubscriptionError(message: e.toString()));
    }
  }

  Future<void> _onClearCheckoutUrl(
    ClearCheckoutUrl event,
    Emitter<SubscriptionState> emit,
  ) async {
    final currentState = state;
    if (currentState is SubscriptionLoaded) {
      emit(currentState.copyWith(clearCheckoutUrl: true));
    }
  }
}
