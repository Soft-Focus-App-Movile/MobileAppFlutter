import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/ui/colors.dart';
import '../../../../core/ui/text_styles.dart';
import '../../domain/models/subscription.dart';
import '../blocs/subscription/subscription_bloc.dart';
import '../blocs/subscription/subscription_event.dart';
import '../blocs/subscription/subscription_state.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyPlanPage extends StatelessWidget {
  const MyPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _MyPlanPageContent();
  }
}

class _MyPlanPageContent extends StatelessWidget {
  const _MyPlanPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text(
          'Mi plan',
          style: crimsonSemiBold.copyWith(
            fontSize: 25,
            color: greenA3,
          ),
        ),
        backgroundColor: white,
        elevation: 0,
        iconTheme: IconThemeData(color: greenA3),
      ),
      body: BlocConsumer<SubscriptionBloc, SubscriptionState>(
        listenWhen: (previous, current) {
          // Listen to checkout URL changes and success messages
          if (previous is SubscriptionLoaded && current is SubscriptionLoaded) {
            return previous.checkoutUrl != current.checkoutUrl ||
                   previous.successMessage != current.successMessage;
          }
          return true;
        },
        listener: (context, state) {
          if (state is SubscriptionLoaded) {
            if (state.checkoutUrl != null) {
              print('🌐 Opening checkout WebView');

              // Get the bloc reference BEFORE navigating
              final bloc = context.read<SubscriptionBloc>();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (webViewContext) => _StripeCheckoutWebView(
                    checkoutUrl: state.checkoutUrl!,
                    onSuccess: (sessionId) {
                      print('💳 Payment success! SessionId: $sessionId');
                      print('💳 Dispatching HandleCheckoutSuccess event...');

                      // Close the WebView first
                      Navigator.pop(webViewContext);

                      // Then dispatch the event using the bloc reference we saved
                      bloc.add(HandleCheckoutSuccess(sessionId: sessionId));
                      print('💳 Event dispatched!');
                    },
                    onCancel: () {
                      print('❌ Payment cancelled by user');

                      // Close the WebView first
                      Navigator.pop(webViewContext);

                      // Then clear the checkout URL using the bloc reference we saved
                      bloc.add(ClearCheckoutUrl());
                    },
                  ),
                ),
              );
            }

            if (state.successMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.successMessage!),
                  backgroundColor: greenA3,
                  duration: const Duration(seconds: 3),
                ),
              );
            }
          }
        },
        builder: (context, state) {
          if (state is SubscriptionLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is SubscriptionError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: sourceSansRegular.copyWith(
                        fontSize: 16,
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<SubscriptionBloc>().add(LoadSubscription());
                      },
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is SubscriptionLoaded) {
            return _PlanContent(
              subscription: state.subscription,
              isLoadingCheckout: state.isLoadingCheckout,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _PlanContent extends StatelessWidget {
  final Subscription subscription;
  final bool isLoadingCheckout;

  const _PlanContent({
    required this.subscription,
    required this.isLoadingCheckout,
  });

  @override
  Widget build(BuildContext context) {
    final isPro = subscription.plan == SubscriptionPlan.pro;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 32),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: green29,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                Text(
                  'USUARIO',
                  style: crimsonSemiBold.copyWith(
                    fontSize: 16,
                    color: white,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  isPro ? 'Plan Pro' : 'Plan Gratuito',
                  style: crimsonSemiBold.copyWith(
                    fontSize: 32,
                    color: white,
                  ),
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: isPro
                      ? [
                          _PlanFeature('Pacientes ilimitados'),
                          _PlanFeature('Asignaciones de contenido ilimitadas'),
                          _PlanFeature('IA personalizada avanzada'),
                          _PlanFeature('Análisis de emociones ilimitado'),
                          _PlanFeature('Soporte prioritario'),
                          _PlanFeature('Sin anuncios'),
                        ]
                      : [
                          _PlanFeature('Máximo ${subscription.usageLimits.maxPatientConnections ?? 5} pacientes'),
                          _PlanFeature('Asignaciones limitadas de contenido'),
                          _PlanFeature('Funciones básicas de análisis'),
                          _PlanFeature('Soporte estándar'),
                        ],
                ),
                const SizedBox(height: 32),
                if (!isPro)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isLoadingCheckout
                          ? null
                          : () {
                              context.read<SubscriptionBloc>().add(
                                    CreateCheckoutSession(
                                      successUrl: 'softfocus://subscription/success',
                                      cancelUrl: 'softfocus://subscription/cancel',
                                    ),
                                  );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: white,
                        foregroundColor: green29,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: isLoadingCheckout
                          ? SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: green29,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Cambiar a Plan Pro',
                              style: crimsonSemiBold.copyWith(fontSize: 18),
                            ),
                    ),
                  )
                else
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: null, // Deshabilitado por ahora
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: white, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Plan Pro Activo ✓',
                        style: crimsonSemiBold.copyWith(
                          fontSize: 18,
                          color: white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: green29),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              isPro ? 'Pro' : 'Gratuito',
              style: crimsonSemiBold.copyWith(
                fontSize: 20,
                color: green29,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanFeature extends StatelessWidget {
  final String text;

  const _PlanFeature(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: sourceSansRegular.copyWith(
              fontSize: 18,
              color: white,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: sourceSansRegular.copyWith(
                fontSize: 16,
                color: white,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StripeCheckoutWebView extends StatefulWidget {
  final String checkoutUrl;
  final Function(String sessionId) onSuccess;
  final VoidCallback onCancel;

  const _StripeCheckoutWebView({
    required this.checkoutUrl,
    required this.onSuccess,
    required this.onCancel,
  });

  @override
  State<_StripeCheckoutWebView> createState() => _StripeCheckoutWebViewState();
}

class _StripeCheckoutWebViewState extends State<_StripeCheckoutWebView> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            final url = request.url;
            print('🌐 Navigation requested: $url');

            if (url.contains('softfocus://subscription/success')) {
              final uri = Uri.parse(url);
              final sessionId = uri.queryParameters['session_id'];

              print('✅ Payment success detected! SessionId: $sessionId');

              if (sessionId != null) {
                widget.onSuccess(sessionId);
              } else {
                print('❌ Success URL detected but no session_id found!');
              }
              // Prevent the WebView from loading this URL
              return NavigationDecision.prevent;
            } else if (url.contains('softfocus://subscription/cancel')) {
              print('❌ Payment cancellation detected');
              widget.onCancel();
              // Prevent the WebView from loading this URL
              return NavigationDecision.prevent;
            }

            // Allow normal navigation for Stripe URLs
            return NavigationDecision.navigate;
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.checkoutUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pago',
          style: crimsonSemiBold.copyWith(
            fontSize: 20,
            color: greenA3,
          ),
        ),
        backgroundColor: white,
        elevation: 0,
        iconTheme: IconThemeData(color: greenA3),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: widget.onCancel,
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
