import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_softfocus/core/navigation/route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/ui/colors.dart';
import '../../../../core/ui/text_styles.dart';
import '../../../../core/widgets/invitation_card.dart';
import '../../../../core/utils/location_helper.dart';
import '../../../auth/data/local/user_session.dart';
import '../blocs/psychologist_home/psychologist_home_bloc.dart';
import '../blocs/psychologist_home/psychologist_home_event.dart';
import '../blocs/psychologist_home/psychologist_home_state.dart';
import '../widgets/psychologist/stats_card.dart';
import '../widgets/psychologist/patients_tracking.dart';

/// Home screen for psychologist users
class PsychologistHomePage extends StatefulWidget {
  const PsychologistHomePage({super.key});

  @override
  State<PsychologistHomePage> createState() => _PsychologistHomePageState();
}

class _PsychologistHomePageState extends State<PsychologistHomePage> {
  String _locationText = '-';
  String _userName = 'Usuario';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _loadLocation();
    context.read<PsychologistHomeBloc>().add(LoadPsychologistHomeData());
  }

  Future<void> _loadUserInfo() async {
    final userSession = UserSession();
    final user = await userSession.getUser();
    if (user != null && mounted) {
      setState(() {
        _userName = user.fullName?.split(' ').first ?? 'Usuario';
      });
    }
  }

  Future<void> _loadLocation() async {
    try {
      final hasPermission = await LocationHelper.hasLocationPermission();
      if (hasPermission) {
        final position = await LocationHelper.getCurrentLocation();
        if (position != null && mounted) {
          final location = await LocationHelper.getCityAndCountry(position);
          setState(() {
            _locationText = location;
          });
        } else if (mounted) {
          setState(() {
            _locationText = 'Lima, Peru';
          });
        }
      } else if (mounted) {
        setState(() {
          _locationText = 'Lima, Peru';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _locationText = 'Lima, Peru';
        });
      }
    }
  }

  void _handleCopyCode(String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Código copiado: $code'),
        backgroundColor: green49,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _handleShareCode(String code) {
    // TODO: Implement share functionality
    // Requires adding share_plus package to pubspec.yaml
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Compartir: $code'),
        backgroundColor: green49,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.location_on,
              color: green49,
              size: 23,
            ),
            SizedBox(width: 4),
            Text(
              _locationText,
              style: sourceSansRegular.copyWith(
                fontSize: 14,
                color: gray828,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: green49,
              size: 25,
            ),
            onPressed: () {
              context.push(AppRoute.notifications.path);
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<PsychologistHomeBloc, PsychologistHomeState>(
        listener: (context, state) {
          if (state is InvitationCodeCopied) {
            // Handle copy action
          } else if (state is InvitationCodeShared) {
            // Handle share action
          }
        },
        builder: (context, state) {
          if (state is PsychologistHomeLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: green49,
              ),
            );
          }

          if (state is PsychologistHomeError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Error al cargar datos',
                    style: crimsonSemiBold.copyWith(
                      fontSize: 18,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      state.message,
                      style: sourceSansRegular.copyWith(
                        fontSize: 14,
                        color: gray828,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<PsychologistHomeBloc>()
                          .add(LoadPsychologistHomeData());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: green49,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          if (state is PsychologistHomeLoaded) {
            // Crear lista de estadísticas basada en los datos del API
            final statsList = state.stats != null
                ? [
                    StatItem(
                      icon: Icons.people,
                      title: 'Pacientes Activos',
                      value: state.stats!.activePatientsCount > 0
                          ? state.stats!.activePatientsCount.toString()
                          : '-',
                      subtitle: state.stats!.activePatientsCount > 0
                          ? '${state.stats!.activePatientsCount} pacientes activos'
                          : 'Sin pacientes aún',
                    ),
                    StatItem(
                      icon: Icons.warning_amber,
                      title: 'Alertas Pendientes',
                      value: state.stats!.pendingCrisisAlerts > 0
                          ? state.stats!.pendingCrisisAlerts.toString()
                          : '-',
                      subtitle: state.stats!.pendingCrisisAlerts > 0
                          ? '${state.stats!.pendingCrisisAlerts} alertas'
                          : 'Sin alertas',
                    ),
                    StatItem(
                      imageAsset: state.stats!.averageEmotionalLevel > 0
                          ? getEmotionalEmoji(
                              state.stats!.averageEmotionalLevel)
                          : 'assets/emojis/calendar_emoji_serius.png',
                      title: 'Estado Emocional',
                      value: state.stats!.averageEmotionalLevel > 0
                          ? state.stats!.averageEmotionalLevel
                              .toStringAsFixed(1)
                          : '-',
                      subtitle: state.stats!.averageEmotionalLevel > 0
                          ? 'Promedio de tus pacientes'
                          : 'Sin datos disponibles',
                    ),
                  ]
                : [
                    StatItem(
                      icon: Icons.people,
                      title: 'Pacientes Activos',
                      value: '-',
                      subtitle: 'Cargando...',
                    ),
                    StatItem(
                      icon: Icons.warning_amber,
                      title: 'Alertas Pendientes',
                      value: '-',
                      subtitle: 'Cargando...',
                    ),
                    StatItem(
                      imageAsset: 'assets/emojis/calendar_emoji_serius.png',
                      title: 'Estado Emocional',
                      value: '-',
                      subtitle: 'Cargando...',
                    ),
                  ];

            return RefreshIndicator(
              onRefresh: () async {
                context.read<PsychologistHomeBloc>().add(RefreshAll());
              },
              color: green49,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24),

                      // Saludo
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Hola $_userName,',
                          style: crimsonSemiBold.copyWith(
                            fontSize: 24,
                            color: green49,
                          ),
                        ),
                      ),

                      SizedBox(height: 24),

                      // Stats Cards
                      StatsSection(stats: statsList),

                      SizedBox(height: 24),

                      // Título de código de invitación
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Mi código de invitación',
                          style: crimsonSemiBold.copyWith(
                            fontSize: 20,
                            color: green49,
                          ),
                        ),
                      ),

                      SizedBox(height: 8),

                      // Invitation Card
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: InvitationCard(
                          code: state.invitationCode?.code ?? 'Cargando...',
                          onCopyClick: () => _handleCopyCode(
                              state.invitationCode?.code ?? ''),
                          onShareClick: () => _handleShareCode(
                              state.invitationCode?.code ?? ''),
                        ),
                      ),

                      SizedBox(height: 24),

                      // Patients Tracking
                      PatientsTracking(
                        patients: state.patients,
                        onPatientClick: (patient) {
                          // TODO: Navigate to patient detail
                          print('Navigate to patient: ${patient.patientName}');
                        },
                        onViewAllClick: () {
                          // TODO: Navigate to patient list
                          print('Navigate to patient list');
                        },
                      ),

                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
