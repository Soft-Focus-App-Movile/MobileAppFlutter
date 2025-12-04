import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/widgets/profile_avatar.dart';
import '../../../../../core/ui/colors.dart';
import '../../../../../core/ui/text_styles.dart';
import '../../blocs/profile/profile_bloc.dart';
import '../../blocs/profile/profile_event.dart';
import '../../blocs/profile/profile_state.dart';
import '../../../../../core/navigation/route.dart';

class PatientProfilePage extends StatelessWidget {
  final VoidCallback onNavigateToEditProfile;
  final VoidCallback onNavigateToNotifications;
  final VoidCallback onNavigateToPrivacyPolicy;
  final VoidCallback onNavigateToHelpSupport;
  final VoidCallback onLogout;

  const PatientProfilePage({
    super.key,
    required this.onNavigateToEditProfile,
    required this.onNavigateToNotifications,
    required this.onNavigateToPrivacyPolicy,
    required this.onNavigateToHelpSupport,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: redE8,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading && state.user == null) {
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
                const SizedBox(height: 24),
                _buildTherapistSection(context, state),
                const SizedBox(height: 24),
                _ProfileOptionItem(
                  icon: Icons.edit,
                  title: 'Editar información Personal',
                  onTap: onNavigateToEditProfile,
                ),
                _ProfileOptionItem(
                  icon: Icons.notifications,
                  title: 'Notificaciones',
                  onTap: onNavigateToNotifications,
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

  Widget _buildTherapistSection(BuildContext context, ProfileState state) {
    switch (state.psychologistLoadState) {
      case PsychologistLoadState.success:
        final psychologist = state.assignedPsychologist;
        if (psychologist != null) {
          return _CurrentTherapistCard(
            therapistName: psychologist.fullName,
            therapistImageUrl: psychologist.profileImageUrl,
            onUnlinkClick: () => _showDisconnectDialog(context),
            onViewProfile: () {
              context.push(AppRoute.psychologistChatProfile.path);
            },
          );
        }
        return _buildNoTherapistCard();
      case PsychologistLoadState.loading:
        return _buildLoadingCard();
      case PsychologistLoadState.noTherapist:
        return _buildNoTherapistCard();
      case PsychologistLoadState.error:
        return _buildErrorCard(context);
    }
  }

  Widget _buildLoadingCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: grayF5,
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  Widget _buildNoTherapistCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: grayF5,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              'No tienes un terapeuta asignado',
              style: sourceSansRegular.copyWith(
                fontSize: 16,
                color: black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: grayF5,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Error al cargar información del terapeuta',
                style: sourceSansRegular.copyWith(
                  fontSize: 16,
                  color: redE8,
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  context.read<ProfileBloc>().add(LoadProfile());
                },
                child: Text(
                  'Reintentar',
                  style: sourceSansBold.copyWith(
                    fontSize: 14,
                    color: blue77,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDisconnectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: white,
        title: Text(
          'Desvincular Terapeuta',
          style: crimsonSemiBold.copyWith(
            fontSize: 20,
            color: black,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '¿Estás seguro de que deseas desvincularte de tu terapeuta?',
              style: sourceSansRegular.copyWith(
                fontSize: 16,
                color: black,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Esta acción no se puede deshacer.',
              style: sourceSansRegular.copyWith(
                fontSize: 14,
                color: gray808,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              'Cancelar',
              style: sourceSansBold.copyWith(
                fontSize: 14,
                color: black,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<ProfileBloc>().add(
                    DisconnectPsychologist(
                      onSuccess: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Terapeuta desvinculado exitosamente'),
                          ),
                        );
                      },
                    ),
                  );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: redE8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              'Confirmar',
              style: sourceSansBold.copyWith(
                fontSize: 14,
                color: white,
              ),
            ),
          ),
        ],
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

class _CurrentTherapistCard extends StatelessWidget {
  final String therapistName;
  final String? therapistImageUrl;
  final VoidCallback onUnlinkClick;
  final VoidCallback onViewProfile;

  const _CurrentTherapistCard({
    required this.therapistName,
    this.therapistImageUrl,
    required this.onUnlinkClick,
    required this.onViewProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: grayF5,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Mi Terapeuta Actual',
                style: crimsonSemiBold.copyWith(
                  fontSize: 20,
                  color: black,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  ProfileAvatar(
                    imageUrl: therapistImageUrl,
                    fullName: therapistName,
                    size: 100,
                    fontSize: 40,
                    backgroundColor: greenA3,
                    textColor: white,
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          therapistName,
                          style: crimsonSemiBold.copyWith(
                            fontSize: 18,
                            color: black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        InkWell(
                          onTap: onViewProfile,
                          child: Text(
                            'Ver perfil',
                            style: sourceSansRegular.copyWith(
                              fontSize: 13,
                              color: blue77,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: onUnlinkClick,
                style: ElevatedButton.styleFrom(
                  backgroundColor: redE8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  'Desvincular',
                  style: sourceSansBold.copyWith(
                    fontSize: 14,
                    color: white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
