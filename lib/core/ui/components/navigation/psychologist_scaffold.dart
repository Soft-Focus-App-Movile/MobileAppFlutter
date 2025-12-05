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
import '../../../../features/crisis/presentation/screens/psychologist/crisis_alerts_screen.dart';
import '../../../../features/crisis/presentation/blocs/crisis_alerts/crisis_alerts_bloc.dart';
import '../../../../features/crisis/presentation/blocs/crisis_alerts/crisis_alerts_event.dart';
import '../../../../features/crisis/data/repositories/crisis_repository_impl.dart';
import '../../../../features/crisis/data/remote/crisis_service.dart';

import '../../../../features/home/presentation/blocs/psychologist_home/psychologist_home_bloc.dart';
import '../../../../features/home/presentation/blocs/psychologist_home/psychologist_home_event.dart';
import '../../../../features/psychologist/data/remote/psychologist_service.dart';

import '../../../../features/library/presentation/pages/library_page.dart';
import '../../../../features/library/data/services/assignments_service.dart';

import '../../../../features/therapy/presentation/psychologist/patientlist/pages/patient_list_page.dart';
import '../../../../features/therapy/presentation/psychologist/patientlist/blocs/patient_list_bloc.dart';
import '../../../../features/therapy/presentation/psychologist/patientlist/blocs/patient_list_event.dart';
import '../../../../features/therapy/domain/usecases/get_patient_directory_usecase.dart';
import '../../../../features/therapy/presentation/psychologist/patientdetail/pages/patient_detail_page.dart';
import '../../../../features/therapy/presentation/psychologist/patientdetail/blocs/patient_detail_bloc.dart';
import '../../../../features/therapy/presentation/psychologist/patientdetail/blocs/patient_detail_event.dart';
import '../../../../features/therapy/domain/usecases/get_patient_profile_usecase.dart';
import '../../../../features/therapy/domain/usecases/get_patient_check_ins_usecase.dart';

import '../../../../features/auth/data/local/user_session.dart';
import '../../../../core/networking/http_client.dart';
import '../../../navigation/route.dart';
import '../../colors.dart';

class PsychologistScaffold extends StatefulWidget {
  const PsychologistScaffold({super.key});

  @override
  State<PsychologistScaffold> createState() => PsychologistScaffoldState();
}

class PsychologistScaffoldState extends State<PsychologistScaffold> {
  int _selectedIndex = 0;

  // Estado para manejar la navegación interna de Pacientes
  String? _selectedPatientId;

  // Método público para navegar al detalle
  void showPatientDetail(String patientId) {
    setState(() {
      _selectedIndex = 1; // Asegurar que estamos en la tab de pacientes
      _selectedPatientId = patientId;
    });
  }

  // Método público para volver a la lista
  void showPatientList() {
    setState(() {
      _selectedPatientId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // PopScope maneja el botón "Atrás" de Android
    return PopScope(
      canPop: _selectedPatientId == null,
      onPopInvoked: (didPop) {
        if (didPop) return;
        if (_selectedPatientId != null) {
          showPatientList();
        }
      },
      child: Scaffold(
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
            _buildHomePage(),
            _buildPatientsTab(), 
            _buildCrisisAlertsPage(),
            _buildLibraryPlaceholder(),
            _buildProfilePage(),
          ],
        ),
      ),
    );
  }

  Widget _buildHomePage() {
    final userSession = UserSession();

    return FutureBuilder(
      future: userSession.getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = snapshot.data;
        final httpClient = HttpClient(token: user?.token);
        final psychologistService = PsychologistService(httpClient: httpClient);
        final therapyService = TherapyService(httpClient: httpClient);

        return BlocProvider(
          create: (context) => PsychologistHomeBloc(
            psychologistService: psychologistService,
            therapyService: therapyService,
          )..add(LoadPsychologistHomeData()),
          child: const PsychologistHomePage(),
        );
      },
    );
  }

  Widget _buildCrisisAlertsPage() {
    final userSession = UserSession();

    return FutureBuilder(
      future: userSession.getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = snapshot.data;
        final httpClient = HttpClient(token: user?.token);
        final crisisService = CrisisService(httpClient: httpClient);
        final crisisRepository = CrisisRepositoryImpl(crisisService);

        return BlocProvider(
          create: (context) => CrisisAlertsBloc(
            crisisRepository: crisisRepository,
          )..add(LoadCrisisAlerts()),
          child: CrisisAlertsScreen(
            onNavigateToPatientProfile: (patientId) {
              // TODO: Navigate to patient profile
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Ver perfil de paciente: $patientId')),
              );
            },
            onSendMessage: (patientId) {
              // TODO: Navigate to chat with patient
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Enviar mensaje a paciente: $patientId')),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildPatientsTab() {
    // Si hay un ID seleccionado, mostramos el detalle, si no, la lista.
    if (_selectedPatientId != null) {
      // Envolvemos en un sub-scaffold o container para manejar el botón atrás en la AppBar si es necesario
      return _buildPatientDetailPage(_selectedPatientId!);
    }
    return _buildPatientListPage();
  }

  // Patient Detail Screen =====
  Widget _buildPatientListPage() {
    return FutureBuilder(
      future: _initPatientListDeps(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Mis Pacientes')),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }

        return snapshot.data ?? const Scaffold(
          body: Center(child: Text('Error al cargar')),
        );
      },
    );
  }

  Future<Widget> _initPatientListDeps() async {
    final userSession = UserSession();
    final user = await userSession.getUser();

    if (user?.token == null) {
      return const Center(child: Text('Error: No hay sesión activa'));
    }

    final httpClient = HttpClient(token: user!.token);
    final therapyService = TherapyService(httpClient: httpClient);
    final therapyRepository = TherapyRepositoryImpl(service: therapyService);
    final getPatientDirectoryUseCase = GetPatientDirectoryUseCase(therapyRepository);

    return BlocProvider(
      create: (context) => PatientListBloc(
        getPatientDirectoryUseCase: getPatientDirectoryUseCase,
      )..add(LoadPatients()),
      child: const PatientListPage(),
    );
  }

  // ===== MOVIDO DESDE NAVIGATION =====
  Widget _buildPatientDetailPage(String patientId) {
    return FutureBuilder(
      future: _initPatientDetailDeps(patientId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
        }
        return snapshot.data ?? const Scaffold(body: Center(child: Text('Error al cargar')));
      },
    );
  }

  Future<Widget> _initPatientDetailDeps(String patientId) async {
    final userSession = UserSession();
    final user = await userSession.getUser();
    
    if (user?.token == null) {
      return const Scaffold(body: Center(child: Text('Error: No hay sesión activa')));
    }

    final httpClient = HttpClient(token: user!.token);
    final therapyService = TherapyService(httpClient: httpClient);
    final therapyRepository = TherapyRepositoryImpl(service: therapyService);
    final getPatientProfileUseCase = GetPatientProfileUseCase(therapyRepository);
    final getPatientCheckInsUseCase = GetPatientCheckInsUseCase(therapyRepository);
    final assignmentsService = AssignmentsService(httpClient: httpClient);

    return BlocProvider(
      create: (context) => PatientDetailBloc(
        getPatientProfileUseCase: getPatientProfileUseCase,
        getPatientCheckInsUseCase: getPatientCheckInsUseCase,
        therapyRepository: therapyRepository,
        assignmentsService: assignmentsService,
      )..add(LoadPatientDetail(patientId)),
      child: PatientDetailPage(patientId: patientId),
    );
  }

  Widget _buildLibraryPlaceholder() {
    return const LibraryPage();
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
