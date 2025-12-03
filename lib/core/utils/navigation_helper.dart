import 'package:flutter/material.dart';
import '../../features/auth/domain/models/user.dart';
import '../../features/auth/domain/models/user_type.dart';
import '../../features/home/presentation/pages/pages.dart';

/// Helper class for navigation throughout the app
class NavigationHelper {
  /// Navigate to appropriate home screen based on user type
  static void navigateToHome(BuildContext context, User? user) {
    Widget homePage;

    if (user != null) {
      switch (user.userType) {
        case UserType.ADMIN:
          // Admin navigation is handled by app_navigation.dart
          // This helper is only used for legacy navigation
          homePage = const GeneralHomePage();
          break;
        case UserType.PSYCHOLOGIST:
          homePage = const PsychologistHomePage();
          break;
        case UserType.PATIENT:
          homePage = const PatientHomePage();
          break;
        case UserType.GENERAL:
        default:
          homePage = const GeneralHomePage();
          break;
      }
    } else {
      homePage = const GeneralHomePage();
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => homePage),
    );
  }
}
