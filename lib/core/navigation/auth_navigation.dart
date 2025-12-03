import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/pages/pages.dart';
import '../../features/auth/presentation/blocs/login/login_bloc.dart';
import '../../features/auth/presentation/blocs/register/register_bloc.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/data/services/auth_service.dart';
import '../../features/auth/domain/models/user_type.dart';
import '../networking/http_client.dart';
import 'route.dart';

/// Authentication navigation graph.
/// Contains all pre-login routes: Splash, Login, Register, ForgotPassword, AccountReview
List<RouteBase> authRoutes() {
  return [
    // Splash Screen
    GoRoute(
      path: AppRoute.splash.path,
      name: 'splash',
      builder: (context, state) => SplashPage(
        onNavigateToLogin: () {
          context.go(AppRoute.login.path);
        },
        onNavigateToHome: () {
          context.go(AppRoute.home.path);
        },
      ),
    ),

    // Login Screen
    GoRoute(
      path: AppRoute.login.path,
      name: 'login',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => LoginBloc(
            repository: AuthRepositoryImpl(
              service: AuthService(
                httpClient: HttpClient(),
              ),
            ),
          ),
          child: LoginPage(
            onLoginSuccess: () {
              context.go(AppRoute.home.path);
            },
            onAdminLoginSuccess: () {
              context.go('/admin_home');
            },
            onNavigateToRegister: () {
              context.push(AppRoute.register.path);
            },
            onNavigateToRegisterWithOAuth: (email, fullName, tempToken) {
              context.push(Uri(
                path: AppRoute.register.path,
                queryParameters: {
                  'email': email,
                  'fullName': fullName,
                  'tempToken': tempToken,
                },
              ).toString());
            },
            onNavigateToPendingVerification: () {
              context.go(AppRoute.accountReview.path);
            },
            onNavigateToForgotPassword: () {
              context.push(AppRoute.forgotPassword.path);
            },
          ),
        );
      },
    ),

    // Register Screen
    GoRoute(
      path: AppRoute.register.path,
      name: 'register',
      builder: (context, state) {
        // Extract OAuth parameters from query params if provided
        final queryParams = state.uri.queryParameters;
        final oauthEmail = queryParams['email'];
        final oauthFullName = queryParams['fullName'];
        final oauthTempToken = queryParams['tempToken'];

        return BlocProvider(
          create: (context) => RegisterBloc(
            repository: AuthRepositoryImpl(
              service: AuthService(
                httpClient: HttpClient(),
              ),
            ),
          ),
          child: RegisterPage(
            oauthEmail: oauthEmail,
            oauthFullName: oauthFullName,
            oauthTempToken: oauthTempToken,
            onRegisterSuccess: (userType) {
              if (userType == UserType.PSYCHOLOGIST) {
                context.go(AppRoute.accountReview.path);
              } else {
                context.go(AppRoute.login.path);
              }
            },
            onAutoLogin: (user) {
              if (user.userType == UserType.PSYCHOLOGIST && !user.isVerified) {
                context.go(AppRoute.accountReview.path);
              } else {
                context.go(AppRoute.home.path);
              }
            },
            onNavigateToLogin: () {
              context.pop();
            },
            onNavigateToPendingVerification: () {
              context.go(AppRoute.accountReview.path);
            },
          ),
        );
      },
    ),

    // Forgot Password Screen
    GoRoute(
      path: AppRoute.forgotPassword.path,
      name: 'forgot_password',
      builder: (context, state) {
        // TODO: Auth team - Add ForgotPasswordBloc when implementing complete functionality
        return const ForgotPasswordPage();
      },
    ),

    // Account Review Screen (for pending psychologists)
    GoRoute(
      path: AppRoute.accountReview.path,
      name: 'account_review',
      builder: (context, state) => const AccountReviewPage(),
    ),

    // Account Success Screen - TODO: Implement if needed
    GoRoute(
      path: AppRoute.accountSuccess.path,
      name: 'account_success',
      builder: (context, state) {
        // TODO: Create AccountSuccessPage if needed
        return Scaffold(
          appBar: AppBar(title: const Text('Cuenta Aprobada')),
          body: const Center(
            child: Text('TODO: Implementar AccountSuccessPage'),
          ),
        );
      },
    ),

    // Account Denied Screen - TODO: Implement if needed
    GoRoute(
      path: AppRoute.accountDenied.path,
      name: 'account_denied',
      builder: (context, state) {
        // TODO: Create AccountDeniedPage if needed
        return Scaffold(
          appBar: AppBar(title: const Text('Cuenta Rechazada')),
          body: const Center(
            child: Text('TODO: Implementar AccountDeniedPage'),
          ),
        );
      },
    ),
  ];
}
