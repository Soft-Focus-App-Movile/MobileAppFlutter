import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../../../core/ui/colors.dart';
import '../../../../../../core/ui/text_styles.dart';

class EvolutionChart extends StatelessWidget {
  final List<double> lineData;
  final List<double> columnData;
  final bool isLoading;

  const EvolutionChart({
    super.key,
    required this.lineData,
    required this.columnData,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: 150,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final hasData = lineData.any((value) => value > 0);

    if (!hasData) {
      return SizedBox(
        height: 150,
        child: Center(
          child: Text(
            'No hay datos de evolución para esta semana.',
            style: sourceSansRegular.copyWith(
              color: gray808,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return SizedBox(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(show: false),
            titlesData: FlTitlesData(
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    const days = ['Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa', 'Do'];
                    final index = value.toInt();
                    if (index >= 0 && index < days.length) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          days[index],
                          style: sourceSansRegular.copyWith(
                            color: gray808,
                            fontSize: 12,
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                  reservedSize: 30,
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            minX: 0,
            maxX: 6,
            minY: 0,
            maxY: 10,
            lineBarsData: [
              // Barras de columna (máximo del día)
              LineChartBarData(
                spots: columnData
                    .asMap()
                    .entries
                    .map((e) => FlSpot(e.key.toDouble(), e.value))
                    .toList(),
                isCurved: false,
                color: const Color(0xFFABBC8A).withOpacity(0.5),
                barWidth: 6,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
              ),
              // Línea de evolución
              LineChartBarData(
                spots: lineData
                    .asMap()
                    .entries
                    .where((e) => e.value > 0) // Solo puntos con datos
                    .map((e) => FlSpot(e.key.toDouble(), e.value))
                    .toList(),
                isCurved: true,
                color: const Color(0xFFABBC8A),
                barWidth: 2,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 3,
                      color: const Color(0xFFABBC8A),
                      strokeWidth: 0,
                    );
                  },
                ),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFFABBC8A).withOpacity(0.4),
                      const Color(0xFFABBC8A).withOpacity(0.0),
                    ],
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