/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/progress/activity_chart.dart';
import '../widgets/progress/statistics_card.dart';
import '../widgets/progress/empty_progress_state.dart';
import '../di/tracking_di.dart';
import '../providers/tracking_provider.dart';

class ProgressScreen extends ConsumerStatefulWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends ConsumerState<ProgressScreen> {
  @override
  void initState() {
    super.initState();
    // Load check-in history when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(trackingNotifierProvider.notifier).loadCheckInHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final trackingState = ref.watch(trackingNotifierProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Diario',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: const Color(0xFFF5F5F5),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Calendario',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFF6B8E7C),
                          width: 2,
                        ),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Progreso',
                        style: TextStyle(
                          color: Color(0xFF6B8E7C),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _buildBody(trackingState),
    );
  }

  Widget _buildBody(TrackingState state) {
    if (state.isLoadingHistory || state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF6B8E7C),
        ),
      );
    }

    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.error!,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(trackingNotifierProvider.notifier).loadCheckInHistory();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6B8E7C),
              ),
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    final checkIns = state.checkInHistory?.checkIns ?? [];

    if (checkIns.isEmpty) {
      return const EmptyProgressState();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Activity',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B8E7C),
            ),
          ),

          const SizedBox(height: 16),

          // Activity chart
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ActivityChart(checkIns: checkIns),
            ),
          ),

          const SizedBox(height: 24),

          // Statistics
          const Text(
            'Estadísticas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B8E7C),
            ),
          ),

          const SizedBox(height: 16),

          StatisticsCard(
            title: 'Total de registros',
            value: checkIns.length.toString(),
            icon: '📊',
          ),

          const SizedBox(height: 12),

          StatisticsCard(
            title: 'Nivel emocional promedio',
            value: _calculateAverage(
              checkIns.map((e) => e.emotionalLevel.toDouble()).toList(),
            ),
            icon: '😊',
          ),

          const SizedBox(height: 12),

          StatisticsCard(
            title: 'Nivel de energía promedio',
            value: _calculateAverage(
              checkIns.map((e) => e.energyLevel.toDouble()).toList(),
            ),
            icon: '⚡',
          ),

          const SizedBox(height: 12),

          StatisticsCard(
            title: 'Horas de sueño promedio',
            value: _calculateAverage(
              checkIns.map((e) => e.sleepHours.toDouble()).toList(),
            ),
            icon: '😴',
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  String _calculateAverage(List<double> values) {
    if (values.isEmpty) return '0.0';
    final sum = values.reduce((a, b) => a + b);
    final average = sum / values.length;
    return average.toStringAsFixed(1);
  }
}*/