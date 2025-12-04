import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/presentation/pages/pages.dart';
import '../../features/tracking/presentation/screens/diary_screen.dart';
import '../../features/tracking/presentation/screens/check_in_form_screen.dart';
import '../../features/tracking/presentation/screens/progress_screen.dart';
import '../../features/tracking/presentation/bloc/tracking_bloc.dart';
import '../../features/tracking/injection_container.dart' as tracking_di;
import '../../features/profiles/presentation/pages/general/connect_psychologist_page.dart';
import '../../features/profiles/presentation/pages/edit/edit_profile_page.dart';
import '../../features/profiles/presentation/blocs/connect_psychologist/connect_psychologist_bloc.dart';
import '../../features/profiles/presentation/blocs/profile/profile_bloc.dart';
import '../../features/profiles/presentation/blocs/profile/profile_event.dart';
import '../../features/profiles/data/repositories/profile_repository_impl.dart';
import '../../features/profiles/data/remote/profile_service.dart';
import '../../features/therapy/data/repositories/therapy_repository_impl.dart';
import '../../features/therapy/data/services/therapy_service.dart';
import '../../features/auth/data/local/user_session.dart';
import '../../core/networking/http_client.dart';
// NUEVO: Importar notificaciones
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../features/notifications/presentation/pages/notification_preferences_page.dart';
import '../../features/notifications/presentation/blocs/notifications/notifications_bloc.dart';
import '../../features/notifications/presentation/blocs/preferences/notification_preferences_bloc.dart';
import '../../features/notifications/injection_container.dart' as notifications_di;
import '../../features/auth/domain/models/user_type.dart';
import 'route.dart';

/// General user navigation graph.
/// Contains routes specific to General users.
List<RouteBase> generalRoutes() {
  return [
    // General Home Screen
    GoRoute(
      path: '/general_home',
      name: 'general_home',
      builder: (context, state) => const GeneralHomePage(),
    ),

    // Connect Psychologist Screen
    GoRoute(
      path: AppRoute.connectPsychologist.path,
      name: 'connect_psychologist',
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

            final user = snapshot.data;
            final httpClient = HttpClient(token: user?.token);
            final therapyService = TherapyService(httpClient: httpClient);
            final therapyRepository = TherapyRepositoryImpl(
              service: therapyService,
            );

            return BlocProvider(
              create: (context) => ConnectPsychologistBloc(
                therapyRepository: therapyRepository,
              ),
              child: ConnectPsychologistPage(
                onNavigateBack: () => context.pop(),
                onConnectionSuccess: () {
                  context.pop();
                },
                onSearchPsychologists: () {
                  context.push(AppRoute.searchPsychologist.path);
                },
              ),
            );
          },
        );
      },
    ),

    // Edit Profile Screen
    GoRoute(
      path: AppRoute.editProfile.path,
      name: 'edit_profile',
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

            final user = snapshot.data;
            final httpClient = HttpClient(token: user?.token);
            final profileService = ProfileService(httpClient: httpClient);
            final therapyService = TherapyService(httpClient: httpClient);
            final therapyRepository = TherapyRepositoryImpl(
              service: therapyService,
            );
            final profileRepository = ProfileRepositoryImpl(
              service: profileService,
              therapyRepository: therapyRepository,
              userSession: userSession,
            );

            return BlocProvider(
              create: (context) => ProfileBloc(
                profileRepository: profileRepository,
                therapyRepository: therapyRepository,
                userSession: userSession,
              )..add(LoadProfile()),
              child: EditProfilePage(
                onNavigateBack: () => context.pop(),
              ),
            );
          },
        );
      },
    ),

    // ========== NUEVAS RUTAS DE NOTIFICACIONES ==========
    
    // Notifications List Screen
    GoRoute(
      path: AppRoute.notifications.path,
      name: 'general_notifications',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => notifications_di.sl<NotificationsBloc>(),
          child: const NotificationsPage(),
        );
      },
    ),

    // Notification Preferences Screen
    GoRoute(
      path: AppRoute.notificationPreferences.path,
      name: 'general_notification_preferences',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => notifications_di.sl<NotificationPreferencesBloc>(),
          child: const NotificationPreferencesPage(userType: UserType.GENERAL),
        );
      },
    ),

    // ========== FIN RUTAS DE NOTIFICACIONES ==========

    // Diary Screen
    GoRoute(
      path: AppRoute.diary.path,
      name: 'diary',
      builder: (context, state) {
        return BlocProvider<TrackingBloc>(
          create: (context) => tracking_di.sl<TrackingBloc>(),
          child: const DiaryScreen(),
        );
      },
    ),

    // Search Psychologist Screen
    GoRoute(
      path: AppRoute.searchPsychologist.path,
      name: 'search_psychologist',
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Buscar Psicólogo')),
          body: const Center(
            child: Text('TODO: Search team - Implementar SearchPsychologistPage'),
          ),
        );
      },
    ),

    // Check-in Form Screen
    GoRoute(
      path: AppRoute.checkInForm.path,
      name: 'general_check_in_form',
      builder: (context, state) {
        return BlocProvider<TrackingBloc>(
          create: (context) => tracking_di.sl<TrackingBloc>(),
          child: const CheckInFormScreen(),
        );
      },
    ),

    // Progress Screen
    GoRoute(
      path: AppRoute.progress.path,
      name: 'progress',
      builder: (context, state) {
        return BlocProvider<TrackingBloc>(
          create: (context) => tracking_di.sl<TrackingBloc>(),
          child: const ProgressScreen(),
        );
      },
    ),
  ];
}