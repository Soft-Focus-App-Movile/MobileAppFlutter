import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/data/local/user_session.dart';
import '../../features/auth/domain/models/user_type.dart';
import 'auth_navigation.dart';
import 'shared_navigation.dart';
import 'general_navigation.dart';
import 'patient_navigation.dart';
import 'psychologist_navigation.dart';
import 'admin_navigation.dart';
import 'route.dart';

/// Main navigation orchestrator for the SoftFocus app.
///
/// This class delegates navigation to specialized navigation graphs based on user type:
/// - AuthNavigation: Pre-login routes (Splash, Login, Register, AccountReview)
/// - SharedNavigation: Post-login routes shared by all user types (Home, Profile, Notifications, AI)
/// - GeneralNavigation: Routes specific to General users
/// - PatientNavigation: Routes specific to Patient users
/// - PsychologistNavigation: Routes specific to Psychologist users
/// - AdminNavigation: Routes specific to Admin users
///
/// Benefits of this modular approach:
/// - Improved maintainability: Each navigation graph is in its own file
/// - Better scalability: Easy to add new routes without bloating a single file
/// - Clear separation of concerns: Each user type has dedicated navigation logic
/// - Type safety: Routes are only registered for authorized user types
class AppNavigation {
  static final UserSession _userSession = UserSession();

  /// Creates the GoRouter instance with all routes
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: AppRoute.splash.path,
      debugLogDiagnostics: true,
      routes: _buildRoutes(),
      redirect: _redirect,
      refreshListenable: NavigationNotifier(),
    );
  }

  /// Build all routes based on current user type
  static List<RouteBase> _buildRoutes() {
    // Start with auth and shared routes (always available)
    final routes = <RouteBase>[
      ...authRoutes(),
      ...sharedRoutes(),
    ];

    // Note: User-specific routes (general, patient, psychologist, admin) are added
    // regardless of current user to allow navigation after login.
    // The redirect function handles authorization.
    routes.addAll(generalRoutes());
    routes.addAll(patientRoutes());
    routes.addAll(psychologistRoutes());
    routes.addAll(adminRoutes());

    return routes;
  }

  /// Redirect logic based on authentication and user type
  static Future<String?> _redirect(BuildContext context, GoRouterState state) async {
    final user = await _userSession.getUser();
    final isTokenExpired = await _userSession.isTokenExpired();

    final isAuthRoute = AppRoute.authRoutes.any((route) => state.matchedLocation == route.path);
    final isLoggedIn = user != null && !isTokenExpired;

    // If user is logged in and trying to access auth routes, redirect to home
    if (isLoggedIn && isAuthRoute && state.matchedLocation != AppRoute.splash.path) {
      return _getHomeRouteForUserType(user.userType);
    }

    // If user is not logged in and trying to access protected routes, redirect to login
    if (!isLoggedIn && !isAuthRoute && state.matchedLocation != AppRoute.splash.path) {
      return AppRoute.login.path;
    }

    // No redirect needed
    return null;
  }

  /// Get the appropriate home route based on user type
  static String _getHomeRouteForUserType(UserType userType) {
    switch (userType) {
      case UserType.GENERAL:
      case UserType.PATIENT:  // PATIENT is just GENERAL with psychologist relationship
      case UserType.PSYCHOLOGIST:
        return AppRoute.home.path;  // All non-admin users go to /home
      case UserType.ADMIN:
        return AppRoute.adminUsers.path;  // Admin goes to user management
    }
  }
}

/// Notifier to refresh navigation when user state changes
class NavigationNotifier extends ChangeNotifier {
  // This can be expanded to listen to user session changes
  // and notify the router to rebuild routes

  void refresh() {
    notifyListeners();
  }
}
