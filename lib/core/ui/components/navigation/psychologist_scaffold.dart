import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../features/home/presentation/pages/psychologist_home_page.dart';
import '../../../../features/profiles/presentation/pages/psychologist/psychologist_profile_page.dart';
import '../../../../features/profiles/presentation/blocs/psychologist_profile/psychologist_profile_bloc.dart';
import '../../../../features/profiles/presentation/blocs/psychologist_profile/psychologist_profile_event.dart';
import '../../../../features/profiles/data/repositories/profile_repository_impl.dart';
import '../../../../features/profiles/data/remote/profile_service.dart';
import '../../../../features/therapy/data/repositories/therapy_repository_impl.dart';
import '../../../../features/therapy/data/services/therapy_service.dart';
import '../../../../features/auth/data/local/user_session.dart';
import '../../../../core/networking/http_client.dart';
import '../../../navigation/route.dart';
import '../../colors.dart';

class PsychologistScaffold extends StatefulWidget {
  const PsychologistScaffold({super.key});

  @override
  State<PsychologistScaffold> createState() => _PsychologistScaffoldState();
}

class _PsychologistScaffoldState extends State<PsychologistScaffold> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _PsychologistBottomNavInternal(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const PsychologistHomePage(),
          _buildPatientListPlaceholder(),
          _buildCrisisAlertsPlaceholder(),
          _buildLibraryPlaceholder(),
          _buildProfilePage(),
        ],
      ),
    );
  }

  Widget _buildPatientListPlaceholder() {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis Pacientes')),
      body: const Center(
        child: Text('TODO: Therapy team - Implementar PsychologistPatientListPage'),
      ),
    );
  }

  Widget _buildCrisisAlertsPlaceholder() {
    return Scaffold(
      appBar: AppBar(title: const Text('Alertas de Crisis')),
      body: const Center(
        child: Text('TODO: Crisis team - Implementar CrisisAlertsPage'),
      ),
    );
  }

  Widget _buildLibraryPlaceholder() {
    return Scaffold(
      appBar: AppBar(title: const Text('Biblioteca')),
      body: const Center(
        child: Text('TODO: Library team - Implementar LibraryPage'),
      ),
    );
  }

  Widget _buildProfilePage() {
    final userSession = UserSession();

    return FutureBuilder(
      future: userSession.getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
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
          create: (context) => PsychologistProfileBloc(
            profileRepository: profileRepository,
            userSession: userSession,
          )..add(LoadPsychologistProfile()),
          child: PsychologistProfilePage(
            onNavigateToEditProfile: () => context.push(AppRoute.psychologistEditProfile.path),
            onNavigateToProfessionalData: () => context.push(AppRoute.professionalData.path),
            onNavigateToInvitationCode: () => context.push(AppRoute.invitationCode.path),
            onNavigateToPlan: () => context.push(AppRoute.psychologistPlan.path),
            onNavigateToStats: () => context.push(AppRoute.psychologistStats.path),
            onNavigateToNotifications: () => context.push(AppRoute.notifications.path),
            onLogout: () async {
              await userSession.clear();
              if (context.mounted) {
                context.go(AppRoute.login.path);
              }
            },
          ),
        );
      },
    );
  }
}

class _PsychologistBottomNavInternal extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const _PsychologistBottomNavInternal({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: NavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedIndex: currentIndex,
          onDestinationSelected: onTap,
          indicatorColor: Colors.transparent,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            _buildNavItem(
              icon: Icons.home_rounded,
              selectedIcon: Icons.home_rounded,
              label: 'Inicio',
              isSelected: currentIndex == 0,
            ),
            _buildNavItem(
              icon: Icons.people_outline,
              selectedIcon: Icons.people,
              label: 'Pacientes',
              isSelected: currentIndex == 1,
            ),
            _buildNavItem(
              icon: Icons.emergency_outlined,
              selectedIcon: Icons.emergency,
              label: 'Alertas',
              isSelected: currentIndex == 2,
            ),
            _buildNavItem(
              icon: Icons.collections_bookmark_outlined,
              selectedIcon: Icons.collections_bookmark,
              label: 'Biblioteca',
              isSelected: currentIndex == 3,
            ),
            _buildNavItem(
              icon: Icons.person_outline,
              selectedIcon: Icons.person,
              label: 'Perfil',
              isSelected: currentIndex == 4,
            ),
          ],
        ),
      ),
    );
  }

  NavigationDestination _buildNavItem({
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required bool isSelected,
  }) {
    return NavigationDestination(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? selectedIcon : icon,
            color: isSelected ? green29 : gray808,
            size: 24,
          ),
          const SizedBox(height: 4),
          Container(
            width: 10,
            height: 5,
            decoration: BoxDecoration(
              color: isSelected ? green29 : Colors.transparent,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ],
      ),
      label: label,
      selectedIcon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(selectedIcon, color: green29, size: 24),
          const SizedBox(height: 4),
          Container(
            width: 10,
            height: 5,
            decoration: BoxDecoration(
              color: green29,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ],
      ),
    );
  }
}
