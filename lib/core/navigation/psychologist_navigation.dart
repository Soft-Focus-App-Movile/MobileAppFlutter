import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/pages/pages.dart';
import '../../features/tracking/presentation/screens/check_in_form_screen.dart';
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
        // TODO: Therapy team - Implement PsychologistPatientListPage
        return Scaffold(
          appBar: AppBar(title: const Text('Mis Pacientes')),
          body: const Center(
            child: Text('TODO: Therapy team - Implementar PsychologistPatientListPage'),
          ),
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
