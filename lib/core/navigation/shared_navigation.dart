import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../features/home/presentation/blocs/home/home_bloc.dart';
import '../../features/home/presentation/blocs/home/home_state.dart';
import '../../features/home/presentation/blocs/home/home_event.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../features/notifications/presentation/pages/notification_preferences_page.dart';
import '../../features/notifications/presentation/blocs/notifications/notifications_bloc.dart';
import '../../features/notifications/presentation/blocs/notifications/notifications_event.dart';
import '../../features/notifications/presentation/blocs/preferences/notification_preferences_bloc.dart';
import '../../features/notifications/presentation/blocs/preferences/notification_preferences_event.dart';
import '../../features/profiles/presentation/pages/shared/privacy_policy_page.dart';
import '../../features/profiles/presentation/pages/shared/help_support_page.dart';
import '../../features/library/presentation/pages/library_page.dart';
import '../../features/auth/data/local/user_session.dart';
import '../../features/auth/domain/models/user_type.dart';
import '../../core/ui/components/navigation/general_scaffold.dart';
import '../../core/ui/components/navigation/patient_scaffold.dart';
import '../../core/ui/components/navigation/psychologist_scaffold.dart';
import '../../core/data/local/local_user_data_source.dart';
import '../../features/therapy/data/repositories/therapy_repository_impl.dart';
import '../../features/therapy/data/services/therapy_service.dart';
import '../../core/networking/http_client.dart';
import 'route.dart';

final sl = GetIt.instance;

/// Shared navigation graph.
/// Contains routes available to all authenticated users
List<RouteBase> sharedRoutes() {
  return [
    // Home Screen - Entry point after login
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
              final httpClient = HttpClient(token: currentUser?.token);
              final therapyService = TherapyService(httpClient: httpClient);
              final therapyRepository = TherapyRepositoryImpl(service: therapyService);
              final localUserDataSource = LocalUserDataSource();

              return BlocProvider(
                create: (context) => HomeBloc(
                  therapyRepository: therapyRepository,
                  localUserDataSource: localUserDataSource,
                )..add(const CheckPatientStatusRequested()),
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, homeState) {
                    if (homeState.isLoading) {
                      return const Scaffold(
                        body: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (homeState.isPatient) {
                      return const PatientScaffold();
                    }

                    return const GeneralScaffold();
                  },
                ),
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

    // ✅ Notifications Screen - CON BLOCPROVIDER
    GoRoute(
      path: AppRoute.notifications.path,
      name: 'notifications',
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
            if (currentUser == null) {
              return Scaffold(
                appBar: AppBar(title: const Text('Error')),
                body: const Center(
                  child: Text('Usuario no autenticado'),
                ),
              );
            }

            return BlocProvider(
              create: (context) {
                print('🔵 Creando NotificationsBloc...');
                final bloc = sl<NotificationsBloc>();
                print('✅ NotificationsBloc creado, disparando eventos...');
                bloc.add(const LoadNotifications());
                bloc.add(const StartAutoRefresh());
                return bloc;
              },
              child: const NotificationsPage(),
            );
          },
        );
      },
    ),

    // ✅ Notification Preferences Screen - CON BLOCPROVIDER
    GoRoute(
      path: AppRoute.notificationPreferences.path,
      name: 'notification_preferences',
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
            if (currentUser == null) {
              return Scaffold(
                appBar: AppBar(title: const Text('Error')),
                body: const Center(
                  child: Text('Usuario no autenticado'),
                ),
              );
            }

            return BlocProvider(
              create: (context) {
                print('🔵 Creando NotificationPreferencesBloc...');
                final bloc = sl<NotificationPreferencesBloc>();
                print('✅ NotificationPreferencesBloc creado, disparando eventos...');
                bloc.add(const LoadPreferences());
                return bloc;
              },
              child: NotificationPreferencesPage(
                userType: currentUser.userType,
              ),
            );
          },
        );
      },
    ),

    // AI Welcome Screen
    GoRoute(
      path: AppRoute.aiWelcome.path,
      name: 'ai_welcome',
      builder: (context, state) {
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