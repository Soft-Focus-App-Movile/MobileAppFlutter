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

    // --- CONFIGURACIÓN DE EJES ---
    // Usamos -0.5 a 6.5 para que el primer día (0) y el último (6) 
    // tengan margen a los lados y no se corten las barras, 
    // alineando perfectamente el centro de la barra con el punto de la línea.
    
    const double minY = 0;
    const double maxY = 10;
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
                minY: minY,
                maxY: maxY,
                
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30, // Reservamos el mismo espacio
                      // IMPORTANTE: Devolvemos vacío para no duplicar texto
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
                minY: minY,
                maxY: maxY,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  // Aquí es donde SÍ dibujamos los textos
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1, // Asegura que se pinte cada día
                      getTitlesWidget: (value, meta) {
                        const days = ['Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa', 'Do'];
                        final index = value.toInt();
                        // Verificamos que sea un entero exacto para evitar pintar textos intermedios
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
                      // Solo mostramos el punto si hay valor (y > 0) para limpiar visualmente
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