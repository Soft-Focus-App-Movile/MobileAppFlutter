import 'package:flutter/material.dart';

class StatItem {
  final IconData? icon;
  final String? imageAsset; // Para emojis
  final String title;
  final String value;
  final String subtitle;

  StatItem({
    this.icon,
    this.imageAsset,
    required this.title,
    required this.value,
    required this.subtitle,
  });
}

String getEmotionalEmoji(double level) {
  if (level <= 2.0) return 'assets/images/calendar_emoji_angry.png';
  if (level <= 4.0) return 'assets/images/calendar_emoji_sad.png';
  if (level <= 6.0) return 'assets/images/calendar_emoji_serius.png';
  if (level <= 8.0) return 'assets/images/calendar_emoji_happy.png';
  return 'assets/images/calendar_emoji_joy.png';
}

class StatsSection extends StatelessWidget {
  final List<StatItem> stats;

  const StatsSection({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: stats.map((stat) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: StatCard(stat: stat),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final StatItem stat;

  const StatCard({
    super.key,
    required this.stat,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
      elevation: 2,
      child: Container(
        height: 220,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icono o Imagen (emoji)
            if (stat.imageAsset != null)
              Image.asset(
                stat.imageAsset!,
                width: 30,
                height: 30,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.sentiment_neutral,
                    size: 30,
                    color: Color(0xFF497654),
                  );
                },
              )
            else if (stat.icon != null)
              Icon(
                stat.icon!,
                size: 30,
                color: Color(0xFF497654),
              ),

            // Título
            Text(
              stat.title,
              style: TextStyle(
                fontFamily: 'SourceSans3',
                fontSize: 12,
                color: Colors.black,
                height: 1.17,
              ),
              textAlign: TextAlign.center,
            ),

            // Valor grande
            Text(
              stat.value,
              style: TextStyle(
                fontFamily: 'Crimson',
                fontWeight: FontWeight.w600,
                fontSize: 32,
                color: Color(0xFF497654),
              ),
              textAlign: TextAlign.center,
            ),

            // Subtítulo
            Text(
              stat.subtitle,
              style: TextStyle(
                fontFamily: 'SourceSans3',
                fontSize: 10,
                color: Color(0xFFA2A2A2),
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
