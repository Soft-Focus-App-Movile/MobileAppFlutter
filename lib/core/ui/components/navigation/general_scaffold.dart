import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../features/home/presentation/pages/general_home_page.dart';
import '../../../../features/profiles/presentation/pages/general/general_profile_page.dart';
import '../../../../features/profiles/presentation/blocs/profile/profile_bloc.dart';
import '../../../../features/profiles/presentation/blocs/profile/profile_event.dart';
import '../../../../features/profiles/data/repositories/profile_repository_impl.dart';
import '../../../../features/profiles/data/remote/profile_service.dart';
import '../../../../features/therapy/data/repositories/therapy_repository_impl.dart';
import '../../../../features/therapy/data/services/therapy_service.dart';
import '../../../../features/auth/data/local/user_session.dart';
import '../../../../core/networking/http_client.dart';
import '../../../../features/library/presentation/pages/library_page.dart';
import '../../../../features/tracking/presentation/screens/diary_screen.dart';
import '../../../../features/tracking/presentation/bloc/tracking_bloc.dart';
import '../../../../features/tracking/injection_container.dart' as tracking_di;
import '../../../navigation/route.dart';
import '../../colors.dart';

class GeneralScaffold extends StatefulWidget {
  const GeneralScaffold({super.key});

  @override
  State<GeneralScaffold> createState() => _GeneralScaffoldState();
}

class _GeneralScaffoldState extends State<GeneralScaffold> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _GeneralBottomNavInternal(
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
          const GeneralHomePage(),
          _buildDiaryPage(),
          _buildAIPlaceholder(),
          const LibraryPage(),
          _buildProfilePage(),
        ],
      ),
    );
  }

  Widget _buildDiaryPage() {
    return BlocProvider<TrackingBloc>(
      create: (context) => tracking_di.sl<TrackingBloc>(),
      child: const DiaryScreen(),
    );
  }

  Widget _buildAIPlaceholder() {
    return Scaffold(
      appBar: AppBar(title: const Text('Asistente IA')),
      body: const Center(
        child: Text('TODO: AI team - Implementar AIWelcomePage'),
      ),
    );
  }

  Widget _buildProfilePage() {
    final httpClient = HttpClient();
    final userSession = UserSession();
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
      child: GeneralProfilePage(
        onNavigateToConnect: () => context.push(AppRoute.connectPsychologist.path),
        onNavigateToEditProfile: () => context.push(AppRoute.editProfile.path),
        onNavigateToNotifications: () => context.push(AppRoute.notifications.path),
        onNavigateToPrivacyPolicy: () => context.push(AppRoute.privacyPolicy.path),
        onNavigateToHelpSupport: () => context.push(AppRoute.helpSupport.path),
        onNavigateToMyPlan: () => context.push(AppRoute.myPlan.path),
        onLogout: () async {
          await userSession.clear();
          if (context.mounted) {
            context.go(AppRoute.login.path);
          }
        },
      ),
    );
  }
}

class _GeneralBottomNavInternal extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const _GeneralBottomNavInternal({
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
              icon: Icons.book_outlined,
              selectedIcon: Icons.book,
              label: 'Diario',
              isSelected: currentIndex == 1,
            ),
            _buildNavItem(
              icon: Icons.psychology_outlined,
              selectedIcon: Icons.psychology,
              label: 'IA',
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
