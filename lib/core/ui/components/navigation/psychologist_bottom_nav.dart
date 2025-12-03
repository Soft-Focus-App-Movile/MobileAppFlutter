import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../colors.dart';
import '../../../navigation/route.dart';

class PsychologistBottomNav extends StatelessWidget {
  const PsychologistBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.path;

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
          selectedIndex: _getSelectedIndex(currentPath),
          onDestinationSelected: (index) => _onItemTapped(context, index),
          indicatorColor: Colors.transparent,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            _buildNavItem(
              icon: Icons.home_rounded,
              selectedIcon: Icons.home_rounded,
              label: 'Inicio',
              isSelected: currentPath == '/psychologist_home' || currentPath == AppRoute.home.path,
            ),
            _buildNavItem(
              icon: Icons.people_outline,
              selectedIcon: Icons.people,
              label: 'Pacientes',
              isSelected: currentPath == AppRoute.psychologistPatientList.path,
            ),
            _buildNavItem(
              icon: Icons.emergency_outlined,
              selectedIcon: Icons.emergency,
              label: 'Alertas',
              isSelected: currentPath == AppRoute.crisisAlerts.path,
            ),
            _buildNavItem(
              icon: Icons.collections_bookmark_outlined,
              selectedIcon: Icons.collections_bookmark,
              label: 'Biblioteca',
              isSelected: currentPath == AppRoute.library.path,
            ),
            _buildNavItem(
              icon: Icons.person_outline,
              selectedIcon: Icons.person,
              label: 'Perfil',
              isSelected: currentPath == AppRoute.psychologistProfile.path,
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

  int _getSelectedIndex(String currentPath) {
    if (currentPath == '/psychologist_home' || currentPath == AppRoute.home.path) return 0;
    if (currentPath == AppRoute.psychologistPatientList.path) return 1;
    if (currentPath == AppRoute.crisisAlerts.path) return 2;
    if (currentPath == AppRoute.library.path) return 3;
    if (currentPath == AppRoute.psychologistProfile.path) return 4;
    return 0;
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/psychologist_home');
        break;
      case 1:
        // TODO: Therapy team - implement navigation
        context.go(AppRoute.psychologistPatientList.path);
        break;
      case 2:
        // TODO: Crisis team - implement navigation
        context.go(AppRoute.crisisAlerts.path);
        break;
      case 3:
        // TODO: Library team - implement navigation
        context.go(AppRoute.library.path);
        break;
      case 4:
        // TODO: Profile team - implement navigation
        context.go(AppRoute.psychologistProfile.path);
        break;
    }
  }
}
