import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/presentation/pages/pages.dart';
import '../../features/home/presentation/blocs/home/home_bloc.dart';
import '../../features/home/presentation/blocs/home/home_state.dart';
import '../../features/home/presentation/blocs/home/home_event.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../features/profiles/presentation/pages/shared/privacy_policy_page.dart';
import '../../features/profiles/presentation/pages/shared/help_support_page.dart';
import '../../features/library/presentation/pages/library_page.dart';
import '../../features/auth/data/local/user_session.dart';
import '../../features/auth/domain/models/user_type.dart';
import '../../core/ui/components/navigation/general_scaffold.dart';
import '../../core/ui/components/navigation/patient_bottom_nav.dart';
import '../../core/ui/components/navigation/psychologist_scaffold.dart';
import 'route.dart';

/// Shared navigation graph.
/// Contains routes available to all authenticated users
List<RouteBase> sharedRoutes() {
  return [
    // Home Screen - Entry point after login
    // Decides which home to show based on user type (exactly like Kotlin)
    GoRoute(
      path: AppRoute.home.path,
      name: 'home',
      builder: (context, state) {
        final userSession = UserSession();

        return FutureBuilder(
          future: userSession.getUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            final currentUser = snapshot.data;

            // PSYCHOLOGIST users
            if (currentUser?.userType == UserType.PSYCHOLOGIST) {
              return const PsychologistScaffold();
            }

            // GENERAL and PATIENT users
            if (currentUser?.userType == UserType.GENERAL ||
                currentUser?.userType == UserType.PATIENT) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.read<HomeBloc>().add(const CheckPatientStatusRequested());
              });

              return BlocBuilder<HomeBloc, HomeState>(
                builder: (context, homeState) {
                  if (homeState.isLoading) {
                    return const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (homeState.isPatient) {
                    return Scaffold(
                      bottomNavigationBar: const PatientBottomNav(),
                      body: const PatientHomePage(),
                    );
                  }

                  return const GeneralScaffold();
                },
              );
            }

            // Fallback
            return const Scaffold(
              body: Center(child: Text('Error: Tipo de usuario no reconocido')),
            );
          },
        );
      },
    ),

    // Notifications Screen
    GoRoute(
      path: AppRoute.notifications.path,
      name: 'notifications',
      builder: (context, state) {
        // TODO: Add NotificationsBloc provider
        return const NotificationsPage();
      },
    ),

    // Notification Preferences Screen
    GoRoute(
      path: AppRoute.notificationPreferences.path,
      name: 'notification_preferences',
      builder: (context, state) {
        // TODO: Implement NotificationPreferencesPage
        return Scaffold(
          appBar: AppBar(title: const Text('Preferencias de Notificaciones')),
          body: const Center(
            child: Text('TODO: Implementar NotificationPreferencesPage'),
          ),
        );
      },
    ),

    // AI Welcome Screen
    GoRoute(
      path: AppRoute.aiWelcome.path,
      name: 'ai_welcome',
      builder: (context, state) {
        // TODO: Implement AIWelcomePage and AI feature team will add their navigation
        return Scaffold(
          appBar: AppBar(title: const Text('Asistente IA')),
          body: const Center(
            child: Text('TODO: AI team - Implementar AIWelcomePage'),
          ),
        );
      },
    ),

    // Emotion Detection Screen
    GoRoute(
      path: AppRoute.emotionDetection.path,
      name: 'emotion_detection',
      builder: (context, state) {
        // TODO: AI/Emotion Detection team will implement this
        return Scaffold(
          appBar: AppBar(title: const Text('Detección de Emociones')),
          body: const Center(
            child: Text('TODO: Emotion Detection team - Implementar página'),
          ),
        );
      },
    ),

    // Library/Content Browser Screen
    GoRoute(
      path: AppRoute.library.path,
      name: 'library',
      builder: (context, state) {
        return const LibraryPage();
      },
    ),

    // Permissions Screen (if needed)
    GoRoute(
      path: AppRoute.permissions.path,
      name: 'permissions',
      builder: (context, state) {
        // TODO: Implement PermissionsPage if permission flow is needed
        return Scaffold(
          appBar: AppBar(title: const Text('Permisos')),
          body: const Center(
            child: Text('TODO: Implementar PermissionsPage si es necesario'),
          ),
        );
      },
    ),

    // Privacy Policy Screen
    GoRoute(
      path: AppRoute.privacyPolicy.path,
      name: 'privacy_policy',
      builder: (context, state) {
        return PrivacyPolicyPage(
          onNavigateBack: () => context.pop(),
        );
      },
    ),

    // Help & Support Screen
    GoRoute(
      path: AppRoute.helpSupport.path,
      name: 'help_support',
      builder: (context, state) {
        return HelpSupportPage(
          onNavigateBack: () => context.pop(),
        );
      },
    ),
  ];
}
