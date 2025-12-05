import 'package:flutter/material.dart';
import 'dashboard_stat_card.dart';

class DashboardSummaryGrid extends StatelessWidget {
  final int totalCheckIns;
  final int totalEmotionalEntries;
  final double averageEmotionalLevel;
  final double averageEnergyLevel;
  final double averageMoodLevel;

  const DashboardSummaryGrid({
    super.key,
    required this.totalCheckIns,
    required this.totalEmotionalEntries,
    required this.averageEmotionalLevel,
    required this.averageEnergyLevel,
    required this.averageMoodLevel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DashboardStatCard(
                title: 'Check-ins',
                value: totalCheckIns.toString(),
                subtitle: 'Registros totales',
                icon: Icons.assignment_turned_in,
                color: const Color(0xFF6B8E7C),
                backgroundColor: const Color(0xFFE8F5E9),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DashboardStatCard(
                title: 'Calendario',
                value: totalEmotionalEntries.toString(),
                subtitle: 'Días registrados',
                icon: Icons.calendar_today,
                color: const Color(0xFF2196F3),
                backgroundColor: const Color(0xFFE3F2FD),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        Row(
          children: [
            Expanded(
              child: DashboardStatCard(
                title: 'Nivel Emocional',
                value: averageEmotionalLevel.toStringAsFixed(1),
                subtitle: 'Promedio',
                icon: Icons.favorite,
                color: const Color(0xFFE91E63),
                backgroundColor: const Color(0xFFFCE4EC),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DashboardStatCard(
                title: 'Energía',
                value: averageEnergyLevel.toStringAsFixed(1),
                subtitle: 'Promedio',
                icon: Icons.bolt,
                color: const Color(0xFFFF9800),
                backgroundColor: const Color(0xFFFFF3E0),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        DashboardStatCard(
          title: 'Estado de Ánimo',
          value: averageMoodLevel.toStringAsFixed(1),
          subtitle: 'Promedio general',
          icon: Icons.sentiment_satisfied_alt,
          color: const Color(0xFF9C27B0),
          backgroundColor: const Color(0xFFF3E5F5),
        ),
      ],
    );
  }
}
