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

    if (!mounted) return;

    try {
      // Check if there's an active session
      final isAuthenticated = await SessionManager.instance.hasActiveSession();

      if (isAuthenticated) {
        final user = await SessionManager.instance.getCurrentUser();

        if (user != null && user.token != null && user.token!.isNotEmpty) {
          // Valid session - navigate to home
          widget.onNavigateToHome();
        } else {
          // Invalid session - logout and go to login
          await SessionManager.instance.logout();
          widget.onNavigateToLogin();
        }
      } else {
        widget.onNavigateToLogin();
      }
    } catch (e) {
      // Error reading session - go to login
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
