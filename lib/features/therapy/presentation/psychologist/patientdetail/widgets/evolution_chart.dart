// lib/features/therapy/presentation/psychologist/patientdetail/widgets/evolution_chart.dart
import 'dart:math';
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

    // --- CÁLCULO DE ESCALA COMÚN (Vertical) ---
    // Obtenemos el valor más alto de AMBAS listas combinadas
    double maxLineValue = lineData.isNotEmpty ? lineData.reduce(max) : 0;
    double maxColValue = columnData.isNotEmpty ? columnData.reduce(max) : 0;
    double globalMax = max(maxLineValue, maxColValue);

    // Definimos un tope común. Si el dato es menor a 10, usamos 10 como base.
    // Si supera 10, usamos el dato real + 20% de margen.
    final double commonMaxY = globalMax > 10 ? globalMax * 1.2 : 10;

    // Configuración horizontal
    const double minX = -0.5;
    const double maxX = 6.5;

    return SizedBox(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            // CAPA 1: BARRAS (Fondo)
            BarChart(
              BarChartData(
                minY: 0,
                // AHORA: Usamos el mismo máximo que la línea
                maxY: commonMaxY, 
                // AHORA: Mantenemos spaceAround para la alineación horizontal correcta
                alignment: BarChartAlignment.spaceAround,
                
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) => const SizedBox.shrink(),
                    ),
                  ),
                ),
                barGroups: columnData
                    .asMap()
                    .entries
                    .map((e) => BarChartGroupData(
                          x: e.key,
                          barRods: [
                            BarChartRodData(
                              toY: e.value,
                              color: const Color(0xFFABBC8A).withOpacity(0.5),
                              width: 6,
                              borderRadius: BorderRadius.circular(2),
                              backDrawRodData: BackgroundBarChartRodData(show: false),
                            )
                          ],
                        ))
                    .toList(),
              ),
            ),
            
            // CAPA 2: LÍNEA (Frente)
            LineChart(
              LineChartData(
                minX: minX,
                maxX: maxX,
                minY: 0,
                // AHORA: Usamos el mismo máximo que las barras
                maxY: commonMaxY,
                
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        const days = ['Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa', 'Do'];
                        final index = value.toInt();
                        if (value == index.toDouble() && index >= 0 && index < days.length) {
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
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: lineData
                        .asMap()
                        .entries
                        .map((e) => FlSpot(e.key.toDouble(), e.value))
                        .toList(),
                    isCurved: true,
                    curveSmoothness: 0.2,
                    preventCurveOverShooting: true,
                    color: const Color(0xFFABBC8A),
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      checkToShowDot: (spot, barData) => spot.y > 0,
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
          ],
        ),
      ),
    );
  }
}