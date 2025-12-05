import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/ui/colors.dart';
import '../../../../../../core/ui/text_styles.dart';
import '../blocs/patient_detail_bloc.dart';
import '../blocs/patient_detail_state.dart';
import '../blocs/patient_detail_event.dart';
import '../widgets/patient_detail_header.dart';
import '../widgets/last_check_in_card.dart';
import '../widgets/evolution_chart.dart';
import '../widgets/task_card.dart';
import '../../../../../../core/navigation/route.dart';
import '../../../../../../core/ui/components/navigation/psychologist_scaffold.dart';

class PatientDetailPage extends StatefulWidget {
  final String patientId;

  const PatientDetailPage({
    super.key,
    required this.patientId,
  });

  @override
  State<PatientDetailPage> createState() => _PatientDetailPageState();
}

class _PatientDetailPageState extends State<PatientDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _selectedTabIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Pacientes',
          style: crimsonSemiBold.copyWith(
            fontSize: 32,
            color: green49,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: black),
          onPressed: () {
            final scaffoldState = context.findAncestorStateOfType<PsychologistScaffoldState>();
            if (scaffoldState != null) {
              scaffoldState.showPatientList();
            } else {
              // Fallback por seguridad (si se usara fuera del scaffold)
              if (context.canPop()) {
                context.pop();
              }
            }
          },
        ),
        actions: const [
          SizedBox(width: 48),
        ],
      ),
      body: BlocBuilder<PatientDetailBloc, PatientDetailState>(
        builder: (context, state) {
          if (state.isLoading && state.profile == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.profileError != null && state.profile == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${state.profileError}',
                      style: sourceSansRegular.copyWith(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<PatientDetailBloc>().add(
                              LoadPatientDetail(widget.patientId),
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: green49,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Reintentar',
                        style: sourceSansBold.copyWith(color: white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final profile = state.profile;
          if (profile == null) {
            return const Center(child: Text('No se encontró información'));
          }

          final age = _calculateAge(profile.dateOfBirth);

          return RefreshIndicator(
            onRefresh: () async {
              context.read<PatientDetailBloc>().add(
                    RefreshPatientDetail(widget.patientId),
                  );
              await context.read<PatientDetailBloc>().stream.firstWhere(
                    (state) => !state.isLoading,
                  );
            },
            child: ListView(
              children: [
                PatientDetailHeader(
                  patientName: profile.fullName,
                  age: age,
                  profilePhotoUrl: profile.profilePhotoUrl,
                  startDate: profile.createdAt,
                ),
                const SizedBox(height: 16),
                _buildTabBar(),
                const SizedBox(height: 21),
                _buildTabContent(state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 42),
      child: TabBar(
        controller: _tabController,
        indicatorColor: green49,
        indicatorWeight: 2,
        labelColor: green49,
        unselectedLabelColor: gray808,
        labelStyle: sourceSansRegular.copyWith(fontSize: 17),
        onTap: (index) {
          // Si el usuario toca "Chat", navegar a la pantalla de chat dentro del Scaffold
          if (index == 2) {
            // Evitamos que el TabController cambie visualmente al tab vacío
            _tabController.index = _selectedTabIndex; 

            final state = context.read<PatientDetailBloc>().state;
            final profile = state.profile;
            
            if (profile != null) {
              final scaffoldState = context.findAncestorStateOfType<PsychologistScaffoldState>();
              if (scaffoldState != null) {
                scaffoldState.showPatientChat(
                  widget.patientId,
                  profile.fullName,
                  profile.profilePhotoUrl,
                );
              }
            }
          }
        },
        tabs: const [
          Tab(text: 'Resumen'),
          Tab(text: 'Tareas'),
          Tab(text: 'Chat'),
        ],
      ),
    );
  }

  Widget _buildTabContent(PatientDetailState state) {
    switch (_selectedTabIndex) {
      case 0:
        return _buildSummaryTab(state);
      case 1:
        return _buildTasksTab(state);
      case 2:
        return const SizedBox.shrink(); // El chat se abre en otra pantalla
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildSummaryTab(PatientDetailState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Último registro',
            style: crimsonSemiBold.copyWith(
              fontSize: 21,
              color: green49,
            ),
          ),
          const SizedBox(height: 21),
          LastCheckInCard(
            checkIn: state.lastCheckIn,
            isLoading: state.checkInsLoading,
          ),
          const SizedBox(height: 16),
          Text(
            'Evolución',
            style: crimsonSemiBold.copyWith(
              fontSize: 21,
              color: green49,
            ),
          ),
          const SizedBox(height: 21),
          EvolutionChart(
            lineData: state.weeklyChartLineData,
            columnData: state.weeklyChartColumnData,
            isLoading: state.checkInsLoading,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildTasksTab(PatientDetailState state) {
    if (state.assignmentsLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state.assignmentsError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Error: ${state.assignmentsError}',
            style: sourceSansRegular.copyWith(
              color: Colors.red,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (state.assignments.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            'Aún no hay tareas asignadas.',
            style: sourceSansRegular.copyWith(
              color: gray808,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildFilterButton(),
              const SizedBox(width: 4),
              _buildFilterIconButton(),
            ],
          ),
          const SizedBox(height: 16),
          ...state.assignments.map(
            (assignment) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TaskCard(assignment: assignment),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildFilterButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: grayD9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Todos',
            style: sourceSansRegular.copyWith(fontSize: 16),
          ),
          const Icon(Icons.arrow_drop_down, color: gray808),
        ],
      ),
    );
  }

  Widget _buildFilterIconButton() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: green49,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(
        Icons.filter_list,
        color: white,
        size: 15,
      ),
    );
  }

  int _calculateAge(String? dateOfBirth) {
    if (dateOfBirth == null) return 0;
    try {
      final birthDate = DateTime.parse(dateOfBirth);
      final today = DateTime.now();
      int age = today.year - birthDate.year;

      if (today.month < birthDate.month ||
          (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }

      return age;
    } catch (e) {
      return 0;
    }
  }
}