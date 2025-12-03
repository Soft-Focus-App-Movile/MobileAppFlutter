import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/profile_avatar.dart';
import '../../../../../core/ui/colors.dart';
import '../../../../../core/ui/text_styles.dart';
import '../../blocs/profile/profile_bloc.dart';
import '../../blocs/profile/profile_state.dart';

class GeneralProfilePage extends StatelessWidget {
  final VoidCallback onNavigateToConnect;
  final VoidCallback onNavigateToEditProfile;
  final VoidCallback onNavigateToNotifications;
  final VoidCallback onNavigateToPrivacyPolicy;
  final VoidCallback onNavigateToHelpSupport;
  final VoidCallback onNavigateToMyPlan;
  final VoidCallback onLogout;

  const GeneralProfilePage({
    super.key,
    required this.onNavigateToConnect,
    required this.onNavigateToEditProfile,
    required this.onNavigateToNotifications,
    required this.onNavigateToPrivacyPolicy,
    required this.onNavigateToHelpSupport,
    required this.onNavigateToMyPlan,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Editar información Personal',
          style: crimsonSemiBold.copyWith(
            fontSize: 25,
            color: greenA3,
          ),
        ),
        backgroundColor: white,
        elevation: 0,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final user = state.user;

          return SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ProfileAvatar(
                        imageUrl: user?.profileImageUrl,
                        fullName: user?.fullName ?? 'Usuario',
                        size: 120,
                        fontSize: 48,
                        backgroundColor: greenA3,
                        textColor: white,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.fullName ?? 'Usuario',
                              style: crimsonSemiBold.copyWith(
                                fontSize: 28,
                                color: black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (user?.dateOfBirth != null)
                              Builder(
                                builder: (context) {
                                  final age = _calculateAge(user!.dateOfBirth!);
                                  if (age != null) {
                                    return Text(
                                      '$age años',
                                      style: crimsonSemiBold.copyWith(
                                        fontSize: 18,
                                        color: black,
                                      ),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            const SizedBox(height: 8),
                            Text(
                              user?.email ?? '',
                              style: crimsonSemiBold.copyWith(
                                fontSize: 18,
                                color: black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                _ProfileOptionItem(
                  icon: Icons.edit,
                  title: 'Editar información Personal',
                  onTap: onNavigateToEditProfile,
                ),
                _ProfileOptionItem(
                  icon: Icons.psychology,
                  title: 'Conectar con Psicólogo',
                  onTap: onNavigateToConnect,
                ),
                _ProfileOptionItem(
                  icon: Icons.notifications,
                  title: 'Notificaciones',
                  onTap: onNavigateToNotifications,
                ),
                _ProfileOptionItem(
                  icon: Icons.card_membership,
                  title: 'Mi plan',
                  onTap: onNavigateToMyPlan,
                ),
                _ProfileOptionItem(
                  icon: Icons.privacy_tip,
                  title: 'Política de Privacidad',
                  onTap: onNavigateToPrivacyPolicy,
                ),
                _ProfileOptionItem(
                  icon: Icons.help,
                  title: 'Ayuda y Soporte',
                  onTap: onNavigateToHelpSupport,
                ),
                _ProfileOptionItem(
                  icon: Icons.logout,
                  title: 'Cerrar Sesión',
                  onTap: onLogout,
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }

  int? _calculateAge(String dateOfBirth) {
    try {
      final birthDate = DateTime.parse(dateOfBirth);
      final currentDate = DateTime.now();
      int age = currentDate.year - birthDate.year;
      if (currentDate.month < birthDate.month ||
          (currentDate.month == birthDate.month &&
              currentDate.day < birthDate.day)) {
        age--;
      }
      return age;
    } catch (e) {
      return null;
    }
  }
}

class _ProfileOptionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileOptionItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        color: greenA3,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 24,
                  color: black,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: sourceSansRegular.copyWith(
                      fontSize: 16,
                      color: black,
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
