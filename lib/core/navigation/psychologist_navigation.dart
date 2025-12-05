import 'package:flutter/material.dart';
import 'package:flutter_app_softfocus/features/therapy/domain/usecases/get_patient_check_ins_usecase.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/presentation/pages/pages.dart';
import '../../features/therapy/presentation/psychologist/patientlist/pages/patient_list_page.dart';
import '../../features/therapy/presentation/psychologist/patientlist/blocs/patient_list_bloc.dart';
import '../../features/therapy/presentation/psychologist/patientlist/blocs/patient_list_event.dart';
import '../../features/therapy/domain/usecases/get_patient_directory_usecase.dart';
import '../../features/therapy/data/repositories/therapy_repository_impl.dart';
import '../../features/therapy/data/services/therapy_service.dart';
import '../../features/auth/data/local/user_session.dart';
import '../../core/networking/http_client.dart';
import '../../features/profiles/presentation/pages/psychologist/my_invitation_code_page.dart';
import '../../features/profiles/presentation/pages/psychologist/edit_personal_info_page.dart';
import '../../features/profiles/presentation/pages/psychologist/professional_data_page.dart';
import '../../features/profiles/presentation/pages/psychologist/psychologist_stats_page.dart';
import '../../features/profiles/presentation/blocs/psychologist_profile/psychologist_profile_bloc.dart';
import '../../features/profiles/presentation/blocs/psychologist_profile/psychologist_profile_event.dart';
import '../../features/profiles/data/repositories/profile_repository_impl.dart';
import '../../features/profiles/data/remote/profile_service.dart';
import '../../features/psychologist/data/remote/psychologist_service.dart';
import '../../features/psychologist/data/repositories/psychologist_repository_impl.dart';
import '../../features/therapy/presentation/psychologist/patientdetail/pages/patient_detail_page.dart';
import '../../features/therapy/presentation/psychologist/patientdetail/blocs/patient_detail_bloc.dart';
import '../../features/therapy/presentation/psychologist/patientdetail/blocs/patient_detail_event.dart';
import '../../features/therapy/domain/usecases/get_patient_profile_usecase.dart';
import '../../features/therapy/domain/usecases/get_patient_check_ins_usecase.dart';
import '../../features/library/data/services/assignments_service.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../features/notifications/presentation/pages/notification_preferences_page.dart';
import '../../features/notifications/presentation/blocs/notifications/notifications_bloc.dart';
import '../../features/notifications/presentation/blocs/preferences/notification_preferences_bloc.dart';
import '../../features/notifications/injection_container.dart' as notifications_di;
import '../../features/auth/domain/models/user_type.dart';
import '../../features/crisis/presentation/screens/psychologist/crisis_alerts_screen.dart';
import '../../features/crisis/presentation/blocs/crisis_alerts/crisis_alerts_bloc.dart';
import '../../features/crisis/presentation/blocs/crisis_alerts/crisis_alerts_event.dart';
import '../../features/crisis/data/repositories/crisis_repository_impl.dart';
import '../../features/crisis/data/remote/crisis_service.dart';

import '../../features/home/presentation/blocs/psychologist_home/psychologist_home_bloc.dart';
import '../../features/home/presentation/blocs/psychologist_home/psychologist_home_event.dart';

import '../../features/library/presentation/pages/library_page.dart';
import 'route.dart';

/// Psychologist user navigation graph.
/// Contains routes specific to Psychologist users.
List<RouteBase> psychologistRoutes() {
  return [
    // Psychologist Home Screen
    GoRoute(
      path: '/psychologist_home',
      name: 'psychologist_home',
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

            // Crear todos los servicios necesarios con el token
            final psychologistService = PsychologistService(httpClient: httpClient);
            final therapyService = TherapyService(httpClient: httpClient);

            return BlocProvider(
              create: (context) => PsychologistHomeBloc(
                psychologistService: psychologistService,
                therapyService: therapyService,
              )..add(LoadPsychologistHomeData()),
              child: const PsychologistHomePage(),
            );
          },
        );
      },
    ),

    // ========== RUTAS DE NOTIFICACIONES ==========
    
    // Notifications List Screen
    GoRoute(
      path: AppRoute.notifications.path,
      name: 'psychologist_notifications',
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
      name: 'psychologist_notification_preferences',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => notifications_di.sl<NotificationPreferencesBloc>(),
          child: const NotificationPreferencesPage(userType: UserType.PSYCHOLOGIST),
        );
      },
    ),

    // ========== FIN RUTAS DE NOTIFICACIONES ==========

    // Library Screen
    GoRoute(
      path: AppRoute.library.path,
      name: 'psychologist_library',
      builder: (context, state) {
        return const LibraryPage();
      },
    ),

    // Psychologist Profile Screen
    GoRoute(
      path: AppRoute.psychologistProfile.path,
      name: 'psychologist_profile',
      builder: (context, state) {
        // TODO: Profile team - Implement PsychologistProfilePage with BLoC
        return Scaffold(
          appBar: AppBar(title: const Text('Mi Perfil Profesional')),
          body: const Center(
            child: Text('TODO: Profile team - Implementar PsychologistProfilePage'),
          ),
        );
      },
    ),

    // Psychologist Edit Profile Screen
    GoRoute(
      path: AppRoute.psychologistEditProfile.path,
      name: 'psychologist_edit_profile',
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
            final therapyRepository = TherapyRepositoryImpl(service: therapyService);
            final profileRepository = ProfileRepositoryImpl(
              service: profileService,
              therapyRepository: therapyRepository,
              userSession: userSession,
            );

            return BlocProvider(
              create: (context) => PsychologistProfileBloc(
                profileRepository: profileRepository,
                userSession: userSession,
              )..add(LoadPsychologistProfile()),
              child: EditPersonalInfoPage(
                onNavigateBack: () => context.pop(),
              ),
            );
          },
        );
      },
    ),

    // Professional Data Screen
    GoRoute(
      path: AppRoute.professionalData.path,
      name: 'professional_data',
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
            final therapyRepository = TherapyRepositoryImpl(service: therapyService);
            final profileRepository = ProfileRepositoryImpl(
              service: profileService,
              therapyRepository: therapyRepository,
              userSession: userSession,
            );

            return BlocProvider(
              create: (context) => PsychologistProfileBloc(
                profileRepository: profileRepository,
                userSession: userSession,
              )..add(LoadPsychologistProfile()),
              child: ProfessionalDataPage(
                onNavigateBack: () => context.pop(),
              ),
            );
          },
        );
      },
    ),

    // Invitation Code Screen
    GoRoute(
      path: AppRoute.invitationCode.path,
      name: 'invitation_code',
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
            final psychologistService = PsychologistService(httpClient: httpClient);
            final psychologistRepository = PsychologistRepositoryImpl(
              psychologistService: psychologistService,
            );

            return FutureBuilder(
              future: psychologistRepository.getInvitationCode(),
              builder: (context, codeSnapshot) {
                if (codeSnapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }

                if (codeSnapshot.hasError) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Mi código de invitación'),
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => context.pop(),
                      ),
                    ),
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, size: 64, color: Colors.red),
                          const SizedBox(height: 16),
                          Text('Error: ${codeSnapshot.error}'),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => context.pop(),
                            child: const Text('Volver'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final invitationCode = codeSnapshot.data;
                return MyInvitationCodePage(
                  onNavigateBack: () => context.pop(),
                  invitationCode: invitationCode?.code ?? 'N/A',
                );
              },
            );
          },
        );
      },
    ),

    // Psychologist Plan/Subscription Screen
    GoRoute(
      path: AppRoute.psychologistPlan.path,
      name: 'psychologist_plan',
      builder: (context, state) {
        // TODO: Subscription team - Implement PsychologistPlanPage
        return Scaffold(
          appBar: AppBar(title: const Text('Mi Plan')),
          body: const Center(
            child: Text('TODO: Subscription team - Implementar PsychologistPlanPage'),
          ),
        );
      },
    ),

    // Psychologist Stats Screen
    GoRoute(
      path: AppRoute.psychologistStats.path,
      name: 'psychologist_stats',
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
            final psychologistService = PsychologistService(httpClient: httpClient);
            final therapyService = TherapyService(httpClient: httpClient);
            final therapyRepository = TherapyRepositoryImpl(service: therapyService);
            final profileRepository = ProfileRepositoryImpl(
              service: profileService,
              therapyRepository: therapyRepository,
              userSession: userSession,
            );

            return BlocProvider(
              create: (context) => PsychologistProfileBloc(
                profileRepository: profileRepository,
                userSession: userSession,
              )..add(LoadPsychologistProfile()),
              child: PsychologistStatsPage(
                onNavigateBack: () => context.pop(),
                psychologistService: psychologistService,
              ),
            );
          },
        );
      },
    ),

    // Patient List Screen
    GoRoute(
      path: AppRoute.psychologistPatientList.path,
      name: 'psychologist_patient_list',
      builder: (context, state) {
        return FutureBuilder(
          future: _buildPatientListPage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text('Error: ${snapshot.error}'),
                ),
              );
            }

            return snapshot.data ?? const Scaffold(
              body: Center(child: Text('Error al cargar')),
            );
          },
        );
      },
    ),

    // ===== Patient Detail Screen =====
    GoRoute(
      path: '/psychologist_patient_detail/:patientId',
      name: 'psychologist_patient_detail',
      builder: (context, state) {
        final patientId = state.pathParameters['patientId']!;
        
        return FutureBuilder(
          future: _buildPatientDetailPage(patientId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text('Error: ${snapshot.error}'),
                ),
              );
            }

            return snapshot.data ?? const Scaffold(
              body: Center(child: Text('Error al cargar')),
            );
          },
        );
      },
    ),

    // Crisis Alerts Screen
    GoRoute(
      path: AppRoute.crisisAlerts.path,
      name: 'crisis_alerts',
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
            final crisisService = CrisisService(httpClient: httpClient);
            final crisisRepository = CrisisRepositoryImpl(crisisService);

            return BlocProvider(
              create: (context) => CrisisAlertsBloc(
                crisisRepository: crisisRepository,
              )..add(LoadCrisisAlerts()),
              child: CrisisAlertsScreen(
                onNavigateToPatientProfile: (patientId) {
                  // TODO: Navigate to patient profile
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Ver perfil de paciente: $patientId')),
                  );
                },
                onSendMessage: (patientId) {
                  // TODO: Navigate to chat with patient
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Enviar mensaje a paciente: $patientId')),
                  );
                },
              ),
            );
          },
        );
      },
    ),

    // Patient Plan Screen (create/edit therapy plan for a patient)
    GoRoute(
      path: AppRoute.patientPlan.path,
      name: 'patient_plan',
      builder: (context, state) {
        // TODO: Therapy Plan team - Implement PatientPlanPage
        return Scaffold(
          appBar: AppBar(title: const Text('Plan del Paciente')),
          body: const Center(
            child: Text('TODO: Therapy Plan team - Implementar PatientPlanPage'),
          ),
        );
      },
    ),
  ];
}

// Función auxiliar para construir la página con el token
Future<Widget> _buildPatientListPage() async {
  final userSession = UserSession();
  final user = await userSession.getUser();

  if (user?.token == null) {
    return const Scaffold(
      body: Center(
        child: Text('Error: No hay sesión activa'),
      ),
    );
  }

  // Crear HttpClient con el token
  final httpClient = HttpClient(token: user!.token);
  final therapyService = TherapyService(httpClient: httpClient);
  final therapyRepository = TherapyRepositoryImpl(service: therapyService);
  final getPatientDirectoryUseCase = GetPatientDirectoryUseCase(therapyRepository);

  return BlocProvider(
    create: (context) => PatientListBloc(
      getPatientDirectoryUseCase: getPatientDirectoryUseCase,
    )..add(LoadPatients()),
    child: const PatientListPage(),
  );
}

// ===== NUEVA FUNCIÓN: Construir página de detalle de paciente =====
Future<Widget> _buildPatientDetailPage(String patientId) async {
  final userSession = UserSession();
  final user = await userSession.getUser();
  
  if (user?.token == null) {
    return const Scaffold(
      body: Center(
        child: Text('Error: No hay sesión activa'),
      ),
    );
  }

  final httpClient = HttpClient(token: user!.token);
  final therapyService = TherapyService(httpClient: httpClient);
  final therapyRepository = TherapyRepositoryImpl(service: therapyService);
  final getPatientProfileUseCase = GetPatientProfileUseCase(therapyRepository);
  final getPatientCheckInsUseCase = GetPatientCheckInsUseCase(therapyRepository);
  final assignmentsService = AssignmentsService(httpClient: httpClient);

  return BlocProvider(
    create: (context) => PatientDetailBloc(
      getPatientProfileUseCase: getPatientProfileUseCase,
      getPatientCheckInsUseCase: getPatientCheckInsUseCase,
      therapyRepository: therapyRepository,
      assignmentsService: assignmentsService,
    )..add(LoadPatientDetail(patientId)),
    child: PatientDetailPage(patientId: patientId),
  );
}