import 'package:flutter/material.dart';

class MoodSelectionStep extends StatelessWidget {
  final int selectedMood;
  final Function(int) onMoodSelected;
  final VoidCallback onNext;

  const MoodSelectionStep({
    Key? key,
    required this.selectedMood,
    required this.onMoodSelected,
    required this.onNext,
  }) : super(key: key);

  String _getMoodEmoji(int level) {
    if (level <= 2) return '😢';
    if (level <= 4) return '😕';
    if (level <= 6) return '😐';
    if (level <= 8) return '🙂';
    return '😄';
  }

  String _getMoodDescription(int level) {
    if (level <= 2) return 'Me siento terrible';
    if (level <= 4) return 'Me siento mal';
    if (level <= 6) return 'Me siento regular';
    if (level <= 8) return 'Me siento bien';
    return 'Me siento excelente';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          '¿Cómo te sientes hoy?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 48),
        
        // Emoji display
        Text(
          _getMoodEmoji(selectedMood),
          style: const TextStyle(fontSize: 80),
        ),
        const SizedBox(height: 16),
        
        Text(
          _getMoodDescription(selectedMood),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 48),
        
        // Slider
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.white,
                  inactiveTrackColor: Colors.white.withOpacity(0.3),
                  thumbColor: Colors.white,
                  overlayColor: Colors.white.withOpacity(0.2),
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 16,
                  ),
                  trackHeight: 4,
                ),
                child: Slider(
                  value: selectedMood.toDouble(),
                  min: 1,
                  max: 10,
                  divisions: 9,
                  onChanged: (value) => onMoodSelected(value.round()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(10, (index) {
                    return Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
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
}
