import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/tracking_bloc.dart';
import '../bloc/tracking_state.dart';
import '../bloc/tracking_event.dart';
import '../widgets/progress/empty_progress_state.dart';
import '../widgets/progress/activity_chart.dart';
import '../widgets/progress/statistics_card.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TrackingBloc>().add(LoadCheckInHistoryEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
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
          'Progreso',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<TrackingBloc, TrackingState>(
        builder: (context, state) {
          return _buildBody(state);
        },
      ),
    );
  }

  Widget _buildBody(TrackingState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tu Progreso',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B8E7C),
            ),
          ),
          const SizedBox(height: 16),
          _buildProgressContent(state),
        ],
      ),
    );
  }

  Widget _buildProgressContent(TrackingState state) {
    if (state is TrackingLoading || state is TrackingInitial) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: CircularProgressIndicator(
            color: Color(0xFF6B8E7C),
          ),
        ),
      );
    }

    if (state is TrackingError) {
      return Center(
        child: Column(
          children: [
            Text(
              state.message,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<TrackingBloc>().add(LoadCheckInHistoryEvent());
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

    if (state is TrackingLoaded && state.checkInHistory != null) {
      final checkIns = state.checkInHistory!.checkIns;
      
      if (checkIns.isEmpty) {
        return const EmptyProgressState();
      }
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Activity',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B8E7C),
            ),
          ),
          const SizedBox(height: 16),
          
          // Activity Chart
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
          
          const Text(
            'Estadísticas',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B8E7C),
            ),
          ),
          const SizedBox(height: 16),
          
          // Statistics Cards
          StatisticsCard(
            title: 'Total de registros',
            value: checkIns.length.toString(),
            icon: '📊',
          ),
          const SizedBox(height: 12),
          
          StatisticsCard(
            title: 'Nivel emocional promedio',
            value: _calculateAverage(checkIns.map((e) => e.emotionalLevel.toDouble()).toList()),
            icon: '😊',
          ),
          const SizedBox(height: 12),
          
          StatisticsCard(
            title: 'Nivel de energía promedio',
            value: _calculateAverage(checkIns.map((e) => e.energyLevel.toDouble()).toList()),
            icon: '⚡',
          ),
          const SizedBox(height: 12),
          
          StatisticsCard(
            title: 'Horas de sueño promedio',
            value: _calculateAverage(checkIns.map((e) => e.sleepHours.toDouble()).toList()),
            icon: '😴',
          ),
        ],
      );
    }
    
    return const EmptyProgressState();
  }



  String _calculateAverage(List<double> values) {
    if (values.isEmpty) return '0.0';
    final sum = values.reduce((a, b) => a + b);
    final average = sum / values.length;
    return average.toStringAsFixed(1);
  }
}