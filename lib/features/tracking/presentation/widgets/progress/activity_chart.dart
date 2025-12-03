
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../domain/entities/check_in.dart';

class ActivityChart extends StatelessWidget {
  final List<CheckIn> checkIns;

  const ActivityChart({
    Key? key,
    required this.checkIns,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (checkIns.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: Text(
            'No hay datos para mostrar',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    final sortedCheckIns = List<CheckIn>.from(checkIns)
      ..sort((a, b) => a.completedAt.compareTo(b.completedAt));

    final last7CheckIns = sortedCheckIns.length > 7
        ? sortedCheckIns.sublist(sortedCheckIns.length - 7)
        : sortedCheckIns;

    return SizedBox(
      height: 250,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 2,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.shade200,
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 2,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  );
                },
                reservedSize: 28,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < last7CheckIns.length) {
                    final date = last7CheckIns[index].completedAt;
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        '${date.day}/${date.month}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    );
                  }
                  return const Text('');
                },
                reservedSize: 30,
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: (last7CheckIns.length - 1).toDouble(),
          minY: 0,
          maxY: 10,
          lineBarsData: [
            // Emotional level line
            LineChartBarData(
              spots: List.generate(
                last7CheckIns.length,
                (index) => FlSpot(
                  index.toDouble(),
                  last7CheckIns[index].emotionalLevel.toDouble(),
                ),
              ),
              isCurved: true,
              color: const Color(0xFF6B8E7C),
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: const Color(0xFF6B8E7C).withOpacity(0.1),
              ),
            ),
            // Energy level line
            LineChartBarData(
              spots: List.generate(
                last7CheckIns.length,
                (index) => FlSpot(
                  index.toDouble(),
                  last7CheckIns[index].energyLevel.toDouble(),
                ),
              ),
              isCurved: true,
              color: Colors.orange,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: Colors.orange.withOpacity(0.1),
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  final isEmotional = spot.barIndex == 0;
                  return LineTooltipItem(
                    '${isEmotional ? 'Emocional' : 'Energía'}: ${spot.y.toInt()}',
                    TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }
}