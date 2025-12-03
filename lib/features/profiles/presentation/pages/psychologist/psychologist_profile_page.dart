import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/ui/colors.dart';
import '../../../../../core/ui/text_styles.dart';
import '../../../../../core/widgets/profile_avatar.dart';
import '../../blocs/psychologist_profile/psychologist_profile_bloc.dart';
import '../../blocs/psychologist_profile/psychologist_profile_state.dart';
import 'package:intl/intl.dart';

class PsychologistProfilePage extends StatelessWidget {
  final VoidCallback onNavigateToEditProfile;
  final VoidCallback onNavigateToInvitationCode;
  final VoidCallback onNavigateToNotifications;
  final VoidCallback onNavigateToPlan;
  final VoidCallback onNavigateToStats;
  final VoidCallback onNavigateToProfessionalData;
  final VoidCallback onLogout;

  const PsychologistProfilePage({
    super.key,
    required this.onNavigateToEditProfile,
    required this.onNavigateToInvitationCode,
    required this.onNavigateToNotifications,
    required this.onNavigateToPlan,
    required this.onNavigateToStats,
    required this.onNavigateToProfessionalData,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
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
      body: BlocBuilder<PsychologistProfileBloc, PsychologistProfileState>(
        builder: (context, state) {
          if (state is PsychologistProfileLoading && state.profile == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PsychologistProfileError && state.profile == null) {
            return Center(
              child: Text(
                state.message,
                style: sourceSansRegular.copyWith(color: Colors.red),
              ),
            );
          }

          final profile = state.profile;
          if (profile == null) {
            return const Center(child: Text('No profile data'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfileAvatar(
                      imageUrl: profile.profileImageUrl,
                      fullName: profile.fullName,
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
                            profile.fullName,
                            style: crimsonSemiBold.copyWith(
                              fontSize: profile.fullName.length > 20 ? 20 : 28,
                              color: black,
                              height: 1.0,
                            ),
                            maxLines: 2,
                          ),
                          const SizedBox(height: 8),
                          if (profile.dateOfBirth != null) ...[
                            Text(
                              '${_calculateAge(profile.dateOfBirth!)} años',
                              style: crimsonSemiBold.copyWith(
                                fontSize: 18,
                                color: black,
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                          Text(
                            profile.email,
                            style: crimsonSemiBold.copyWith(
                              fontSize: 18,
                              color: black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: profile.specialties.take(2).map((specialty) {
                              return _Badge(text: specialty);
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _MenuOption(
                  icon: Icons.edit_outlined,
                  text: 'Editar Información Personal',
                  onTap: onNavigateToEditProfile,
                ),
                const SizedBox(height: 12),
                _MenuOption(
                  icon: Icons.qr_code,
                  text: 'Mi Código de Invitación',
                  onTap: onNavigateToInvitationCode,
                ),
                const SizedBox(height: 12),
                _MenuOption(
                  icon: Icons.notifications_outlined,
                  text: 'Notificaciones',
                  onTap: onNavigateToNotifications,
                ),
                const SizedBox(height: 12),
                _MenuOption(
                  icon: Icons.card_membership_outlined,
                  text: 'Mi plan',
                  onTap: onNavigateToPlan,
                ),
                const SizedBox(height: 12),
                _MenuOption(
                  icon: Icons.bar_chart_outlined,
                  text: 'Mis Estadísticas',
                  onTap: onNavigateToStats,
                ),
                const SizedBox(height: 12),
                _MenuOption(
                  icon: Icons.work_outline,
                  text: 'Datos profesionales',
                  onTap: onNavigateToProfessionalData,
                ),
                const SizedBox(height: 12),
                _MenuOption(
                  icon: Icons.logout_outlined,
                  text: 'Cerrar Sesión',
                  onTap: onLogout,
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  int _calculateAge(String dateOfBirth) {
    try {
      final birthDate = DateTime.parse(dateOfBirth);
      final currentDate = DateTime.now();
      int age = currentDate.year - birthDate.year;
      if (currentDate.month < birthDate.month ||
          (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
        age--;
      }
      return age;
    } catch (e) {
      return 0;
    }
  }
}

class _Badge extends StatelessWidget {
  final String text;

  const _Badge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: green65,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: sourceSansRegular.copyWith(
          fontSize: 12,
          color: white,
        ),
      ),
    );
  }
}

class _MenuOption extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _MenuOption({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: greenA3,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, color: black, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  style: sourceSansRegular.copyWith(
                    fontSize: 16,
                    color: black,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, color: black),
            ],
          ),
        ),
      ),
    );
  }
}
