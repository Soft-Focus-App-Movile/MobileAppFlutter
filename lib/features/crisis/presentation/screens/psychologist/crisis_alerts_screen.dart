import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/ui/colors.dart';
import '../../../../../core/ui/text_styles.dart';
import '../../blocs/crisis_alerts/crisis_alerts_bloc.dart';
import '../../blocs/crisis_alerts/crisis_alerts_event.dart';
import '../../blocs/crisis_alerts/crisis_alerts_state.dart';
import '../../widgets/psychologist/patient_crisis_card.dart';

class CrisisAlertsScreen extends StatefulWidget {
  final Function(String) onNavigateToPatientProfile;
  final Function(String) onSendMessage;

  const CrisisAlertsScreen({
    super.key,
    required this.onNavigateToPatientProfile,
    required this.onSendMessage,
  });

  @override
  State<CrisisAlertsScreen> createState() => _CrisisAlertsScreenState();
}

class _CrisisAlertsScreenState extends State<CrisisAlertsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  final List<_TabItem> _tabs = const [
    _TabItem(title: 'Todas', severity: null),
    _TabItem(title: 'Críticas', severity: 'Critical'),
    _TabItem(title: 'Altas', severity: 'High'),
    _TabItem(title: 'Moderadas', severity: 'Moderate'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
      final severity = _tabs[_tabController.index].severity;
      context.read<CrisisAlertsBloc>().add(LoadCrisisAlerts(severity: severity));
    }
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
          'Alertas',
          style: crimsonSemiBold.copyWith(
            fontSize: 32,
            color: green49,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: white,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        labelColor: green65,
        unselectedLabelColor: black,
        labelStyle: sourceSansRegular.copyWith(fontSize: 15),
        unselectedLabelStyle: sourceSansRegular.copyWith(fontSize: 15),
        indicatorColor: green65,
        indicatorWeight: 3,
        dividerColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        tabs: _tabs.map((tab) => Tab(text: tab.title)).toList(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<CrisisAlertsBloc, CrisisAlertsState>(
      builder: (context, state) {
        if (state is CrisisAlertsLoadingState) {
          return _buildLoadingState();
        } else if (state is CrisisAlertsEmptyState) {
          return _buildEmptyState();
        } else if (state is CrisisAlertsSuccessState) {
          return _buildSuccessState(state);
        } else if (state is CrisisAlertsErrorState) {
          return _buildErrorState(state);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(color: green49),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 120,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No hay alertas de crisis',
            style: sourceSansRegular.copyWith(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessState(CrisisAlertsSuccessState state) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: state.alerts.length,
      itemBuilder: (context, index) {
        final alert = state.alerts[index];
        return PatientCrisisCard(
          alert: alert,
          onViewProfile: () => widget.onNavigateToPatientProfile(alert.patientId),
          onSendMessage: () => widget.onSendMessage(alert.patientId),
          onUpdateStatus: () {
            context.read<CrisisAlertsBloc>().add(
                  UpdateAlertStatus(
                    alertId: alert.id,
                    currentStatus: alert.status,
                  ),
                );
          },
        );
      },
    );
  }

  Widget _buildErrorState(CrisisAlertsErrorState state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 120,
            color: Colors.red[400],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              state.message,
              style: sourceSansRegular.copyWith(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<CrisisAlertsBloc>().add(
                    LoadCrisisAlerts(
                      severity: _tabs[_selectedTabIndex].severity,
                    ),
                  );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: green49,
              foregroundColor: white,
            ),
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }
}

class _TabItem {
  final String title;
  final String? severity;

  const _TabItem({
    required this.title,
    required this.severity,
  });
}
