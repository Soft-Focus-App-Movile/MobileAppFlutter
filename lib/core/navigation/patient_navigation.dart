import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/presentation/pages/pages.dart';
// NUEVO: Importar notificaciones
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../features/notifications/presentation/pages/notification_preferences_page.dart';
import '../../features/notifications/presentation/blocs/notifications/notifications_bloc.dart';
import '../../features/notifications/presentation/blocs/preferences/notification_preferences_bloc.dart';
import '../../features/notifications/injection_container.dart' as notifications_di;
import '../../features/auth/domain/models/user_type.dart';
import 'route.dart';

/// Patient user navigation graph.
/// Contains routes specific to Patient users.
/// Patients are General users who have been assigned a psychologist.
List<RouteBase> patientRoutes() {
  return [
    // Patient Home Screen
    GoRoute(
      path: '/patient_home',
      name: 'patient_home',
      builder: (context, state) => const PatientHomePage(),
    ),

    // ========== NUEVAS RUTAS DE NOTIFICACIONES ==========
    
    // Notifications List Screen
    GoRoute(
      path: AppRoute.notifications.path,
      name: 'patient_notifications',
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
      name: 'patient_notification_preferences',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => notifications_di.sl<NotificationPreferencesBloc>(),
          child: const NotificationPreferencesPage(userType: UserType.PATIENT),
        );
      },
    ),

    // ========== FIN RUTAS DE NOTIFICACIONES ==========

    // Patient Profile Screen
    GoRoute(
      path: AppRoute.patientProfile.path,
      name: 'patient_profile',
      builder: (context, state) {
        // TODO: Profile team - Implement PatientProfilePage
        return Scaffold(
          appBar: AppBar(title: const Text('Mi Perfil')),
          body: const Center(
            child: Text('TODO: Profile team - Implementar PatientProfilePage'),
          ),
        );
      },
    ),

    // Patient-Psychologist Chat Screen
    GoRoute(
      path: AppRoute.patientPsychologistChat.path,
      name: 'patient_psychologist_chat',
      builder: (context, state) {
        // TODO: Chat/Therapy team - Implement PatientPsychologistChatPage
        return Scaffold(
          appBar: AppBar(title: const Text('Mi Terapeuta')),
          body: const Center(
            child: Text('TODO: Chat team - Implementar PatientPsychologistChatPage'),
          ),
        );
      },
    ),

    // Psychologist Chat Profile Screen
    GoRoute(
      path: AppRoute.psychologistChatProfile.path,
      name: 'psychologist_chat_profile',
      builder: (context, state) {
        // TODO: Chat/Therapy team - Implement PsychologistChatProfilePage
        return Scaffold(
          appBar: AppBar(title: const Text('Perfil del Terapeuta')),
          body: const Center(
            child: Text('TODO: Chat team - Implementar PsychologistChatProfilePage'),
          ),
        );
      },
    ),

    // Progress Screen
    GoRoute(
      path: AppRoute.progress.path,
      name: 'patient_progress',
      builder: (context, state) {
        // TODO: Tracking team - Implement ProgressScreen with BLoC
        return Scaffold(
          appBar: AppBar(title: const Text('Mi Progreso')),
          body: const Center(
            child: Text('TODO: Tracking team - Implementar ProgressScreen con BLoC'),
          ),
        );
      },
    ),

    // My Plan Screen (therapy plan assigned by psychologist)
    GoRoute(
      path: AppRoute.myPlan.path,
      name: 'my_plan',
      builder: (context, state) {
        // TODO: Therapy Plan team - Implement MyPlanPage
        return Scaffold(
          appBar: AppBar(title: const Text('Mi Plan de Terapia')),
          body: const Center(
            child: Text('TODO: Therapy Plan team - Implementar MyPlanPage'),
          ),
        );
      },
    ),

    // Check-in Form Screen
    GoRoute(
      path: AppRoute.checkInForm.path,
      name: 'patient_check_in_form',
      builder: (context, state) {
        // TODO: Tracking team - Implement CheckInFormScreen with BLoC
        return Scaffold(
          appBar: AppBar(title: const Text('Check-in')),
          body: const Center(
            child: Text('TODO: Tracking team - Implementar CheckInFormScreen con BLoC'),
          ),
        );
      },
    ),
  ];
}