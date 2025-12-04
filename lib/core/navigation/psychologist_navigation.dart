import 'package:flutter/material.dart';
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
import 'route.dart';

/// Psychologist user navigation graph.
/// Contains routes specific to Psychologist users.
List<RouteBase> psychologistRoutes() {
  return [
    // Psychologist Home Screen
    GoRoute(
      path: '/psychologist_home',
      name: 'psychologist_home',
      builder: (context, state) => const PsychologistHomePage(),
    ),

    // Psychologist Profile Screen
    GoRoute(
      path: AppRoute.psychologistProfile.path,
      name: 'psychologist_profile',
      builder: (context, state) {
        // TODO: Profile team - Implement PsychologistProfilePage
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
        // TODO: Profile team - Implement PsychologistEditProfilePage
        return Scaffold(
          appBar: AppBar(title: const Text('Editar Perfil Profesional')),
          body: const Center(
            child: Text('TODO: Profile team - Implementar PsychologistEditProfilePage'),
          ),
        );
      },
    ),

    // Professional Data Screen
    GoRoute(
      path: AppRoute.professionalData.path,
      name: 'professional_data',
      builder: (context, state) {
        // TODO: Profile team - Implement ProfessionalDataPage
        return Scaffold(
          appBar: AppBar(title: const Text('Datos Profesionales')),
          body: const Center(
            child: Text('TODO: Profile team - Implementar ProfessionalDataPage'),
          ),
        );
      },
    ),

    // Invitation Code Screen
    GoRoute(
      path: AppRoute.invitationCode.path,
      name: 'invitation_code',
      builder: (context, state) {
        // TODO: Psychologist team - Implement InvitationCodePage
        return Scaffold(
          appBar: AppBar(title: const Text('Código de Invitación')),
          body: const Center(
            child: Text('TODO: Psychologist team - Implementar InvitationCodePage'),
          ),
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
        // TODO: Analytics team - Implement PsychologistStatsPage
        return Scaffold(
          appBar: AppBar(title: const Text('Mis Estadísticas')),
          body: const Center(
            child: Text('TODO: Analytics team - Implementar PsychologistStatsPage'),
          ),
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

    // Crisis Alerts Screen
    GoRoute(
      path: AppRoute.crisisAlerts.path,
      name: 'crisis_alerts',
      builder: (context, state) {
        // TODO: Crisis team - Implement CrisisAlertsPage
        return Scaffold(
          appBar: AppBar(title: const Text('Alertas de Crisis')),
          body: const Center(
            child: Text('TODO: Crisis team - Implementar CrisisAlertsPage'),
          ),
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