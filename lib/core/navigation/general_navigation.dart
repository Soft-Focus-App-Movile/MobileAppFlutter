import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/pages/pages.dart';
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

    // General Profile Screen
    GoRoute(
      path: AppRoute.generalProfile.path,
      name: 'general_profile',
      builder: (context, state) {
        // TODO: Profile team - Implement GeneralProfilePage
        return Scaffold(
          appBar: AppBar(title: const Text('Mi Perfil')),
          body: const Center(
            child: Text('TODO: Profile team - Implementar GeneralProfilePage'),
          ),
        );
      },
    ),

    // Edit Profile Screen
    GoRoute(
      path: AppRoute.editProfile.path,
      name: 'edit_profile',
      builder: (context, state) {
        // TODO: Profile team - Implement EditProfilePage
        return Scaffold(
          appBar: AppBar(title: const Text('Editar Perfil')),
          body: const Center(
            child: Text('TODO: Profile team - Implementar EditProfilePage'),
          ),
        );
      },
    ),

    // Diary Screen
    GoRoute(
      path: AppRoute.diary.path,
      name: 'diary',
      builder: (context, state) {
        // TODO: Diary/Tracking team - Implement DiaryPage
        return Scaffold(
          appBar: AppBar(title: const Text('Mi Diario')),
          body: const Center(
            child: Text('TODO: Diary team - Implementar DiaryPage'),
          ),
        );
      },
    ),

    // Search Psychologist Screen
    GoRoute(
      path: AppRoute.searchPsychologist.path,
      name: 'search_psychologist',
      builder: (context, state) {
        // TODO: Psychologist Search team - Implement SearchPsychologistPage
        return Scaffold(
          appBar: AppBar(title: const Text('Buscar Psicólogo')),
          body: const Center(
            child: Text('TODO: Search team - Implementar SearchPsychologistPage'),
          ),
        );
      },
    ),

    // Connect Psychologist Screen
    GoRoute(
      path: AppRoute.connectPsychologist.path,
      name: 'connect_psychologist',
      builder: (context, state) {
        // TODO: Connection team - Implement ConnectPsychologistPage
        return Scaffold(
          appBar: AppBar(title: const Text('Conectar con Psicólogo')),
          body: const Center(
            child: Text('TODO: Connection team - Implementar ConnectPsychologistPage'),
          ),
        );
      },
    ),
  ];
}
