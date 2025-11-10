import 'package:flutter/material.dart';
import '../../../../core/ui/colors.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/utils/session_manager.dart';

class SplashPage extends StatefulWidget {
  final Function() onNavigateToLogin;
  final Function() onNavigateToHome;

  const SplashPage({
    super.key,
    required this.onNavigateToLogin,
    required this.onNavigateToHome,
  });

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    // Wait for splash animation
    await Future.delayed(const Duration(milliseconds: 2500));

    // Check if there's an active session
    final isAuthenticated = await SessionManager.hasActiveSession();

    if (!mounted) return;

    if (isAuthenticated) {
      // Get current user to check if they exist and token is valid
      final user = await SessionManager.getCurrentUser();

      if (user != null && user.token != null && user.token!.isNotEmpty) {
        // Check token expiration
        // Note: Token expiration check is handled by SessionManager.hasActiveSession()
        // If we get here, the session is valid
        widget.onNavigateToHome();
      } else {
        // Invalid session - logout and go to login
        await SessionManager.logout();
        widget.onNavigateToLogin();
      }
    } else {
      widget.onNavigateToLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              greenC1,
              green49,
            ],
          ),
        ),
        child: Center(
          child: Image.asset(
            AppAssets.pandaSoft,
            width: 550,
            height: 550,
          ),
        ),
      ),
    );
  }
}
