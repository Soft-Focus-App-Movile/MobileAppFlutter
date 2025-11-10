import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/ui/theme.dart';
import 'core/utils/session_manager.dart';
import 'core/utils/navigation_helper.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/data/services/auth_service.dart';
import 'features/auth/presentation/blocs/login/login_bloc.dart';
import 'features/auth/presentation/blocs/register/register_bloc.dart';
import 'features/auth/presentation/pages/splash_page.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/register_page.dart';
import 'features/auth/presentation/pages/account_review_page.dart';
import 'features/home/presentation/blocs/home/home_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Create auth repository singleton
    final authRepository = AuthRepositoryImpl(
      service: AuthService(),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(repository: authRepository),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(repository: authRepository),
        ),
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: const AppRoot(),
      ),
    );
  }
}

/// Root widget that handles the splash screen and navigation
class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashPage(
      onNavigateToLogin: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const AuthNavigator()),
        );
      },
      onNavigateToHome: () async {
        final user = await SessionManager.getCurrentUser();
        NavigationHelper.navigateToHome(context, user);
      },
    );
  }
}

/// Navigator for Auth flow (Login, Register, Account Review)
class AuthNavigator extends StatefulWidget {
  const AuthNavigator({super.key});

  @override
  State<AuthNavigator> createState() => _AuthNavigatorState();
}

class _AuthNavigatorState extends State<AuthNavigator> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  // Helper to navigate to home based on current user
  Future<void> _navigateToUserHome(BuildContext context) async {
    final user = await SessionManager.getCurrentUser();
    NavigationHelper.navigateToHome(context, user);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => LoginPage(
            onLoginSuccess: () => _navigateToUserHome(context),
            onAdminLoginSuccess: () => _navigateToUserHome(context),
            onNavigateToRegister: () {
              _navigatorKey.currentState?.push(
                MaterialPageRoute(
                  builder: (context) => RegisterPage(
                    onRegisterSuccess: (userType) {
                      // After successful regular registration, go back to login
                      _navigatorKey.currentState?.pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPage(
                          onLoginSuccess: () => _navigateToUserHome(context),
                          onAdminLoginSuccess: () => _navigateToUserHome(context),
                          onNavigateToRegister: () {},
                          onNavigateToRegisterWithOAuth: (email, fullName, tempToken) {},
                          onNavigateToPendingVerification: () {},
                        )),
                        (route) => false,
                      );
                    },
                    onAutoLogin: (user) => _navigateToUserHome(context),
                    onNavigateToLogin: () {
                      _navigatorKey.currentState?.pop();
                    },
                    onNavigateToPendingVerification: () {
                      _navigatorKey.currentState?.pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const AccountReviewPage(),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
            onNavigateToRegisterWithOAuth: (email, fullName, tempToken) {
              _navigatorKey.currentState?.push(
                MaterialPageRoute(
                  builder: (context) => RegisterPage(
                    oauthEmail: email,
                    oauthFullName: fullName,
                    oauthTempToken: tempToken,
                    onRegisterSuccess: (userType) {
                      // After successful regular registration, go back to login
                      _navigatorKey.currentState?.pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPage(
                          onLoginSuccess: () => _navigateToUserHome(context),
                          onAdminLoginSuccess: () => _navigateToUserHome(context),
                          onNavigateToRegister: () {},
                          onNavigateToRegisterWithOAuth: (email, fullName, tempToken) {},
                          onNavigateToPendingVerification: () {},
                        )),
                        (route) => false,
                      );
                    },
                    onAutoLogin: (user) => _navigateToUserHome(context),
                    onNavigateToLogin: () {
                      _navigatorKey.currentState?.pop();
                    },
                    onNavigateToPendingVerification: () {
                      _navigatorKey.currentState?.pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const AccountReviewPage(),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
            onNavigateToPendingVerification: () {
              _navigatorKey.currentState?.push(
                MaterialPageRoute(
                  builder: (context) => const AccountReviewPage(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
