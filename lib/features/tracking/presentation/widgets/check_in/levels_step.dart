import 'package:flutter/material.dart';

class LevelsStep extends StatelessWidget {
  final int emotionalLevel;
  final Function(int) onEmotionalLevelChanged;
  final int energyLevel;
  final Function(int) onEnergyLevelChanged;
  final int sleepHours;
  final Function(int) onSleepHoursChanged;
  final VoidCallback onNext;

  const LevelsStep({
    super.key,
    required this.emotionalLevel,
    required this.onEmotionalLevelChanged,
    required this.energyLevel,
    required this.onEnergyLevelChanged,
    required this.sleepHours,
    required this.onSleepHoursChanged,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Últimas preguntas',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 48),
        
        // Emotional Level
        _buildSliderSection(
          context: context,
          title: 'Nivel Emocional',
          value: emotionalLevel,
          onChanged: (value) => onEmotionalLevelChanged(value.round()),
          min: 1,
          max: 10,
        ),
        const SizedBox(height: 32),
        
        // Energy Level
        _buildSliderSection(
          context: context,
          title: 'Nivel de Energía',
          value: energyLevel,
          onChanged: (value) => onEnergyLevelChanged(value.round()),
          min: 1,
          max: 10,
        ),
        const SizedBox(height: 32),
        
        // Sleep Hours
        _buildSliderSection(
          context: context,
          title: 'Horas de Sueño',
          value: sleepHours,
          onChanged: (value) => onSleepHoursChanged(value.round()),
          min: 0,
          max: 12,
          divisions: 12,
        ),
        const SizedBox(height: 48),
        
        // Next button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF6B8E7C),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Siguiente',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSliderSection({
    required BuildContext context,
    required String title,
    required int value,
    required Function(double) onChanged,
    required int min,
    required int max,
    int? divisions,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                value.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.white,
              inactiveTrackColor: Colors.white.withOpacity(0.3),
              thumbColor: Colors.white,
              overlayColor: Colors.white.withOpacity(0.2),
              thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: 12,
              ),
              trackHeight: 4,
            ),
            child: Slider(
              value: value.toDouble(),
              min: min.toDouble(),
              max: max.toDouble(),
              divisions: divisions ?? (max - min),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}