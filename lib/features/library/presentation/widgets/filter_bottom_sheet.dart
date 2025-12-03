import 'package:flutter/material.dart';
import '../../../../core/ui/colors.dart';
import '../../../../core/ui/text_styles.dart';

enum EmotionalTag {
  happy,
  calm,
  energetic;

  String get displayName {
    switch (this) {
      case EmotionalTag.happy:
        return 'Alegre';
      case EmotionalTag.calm:
        return 'Tranquilo';
      case EmotionalTag.energetic:
        return 'En�rgico';
    }
  }

  String get apiValue {
    switch (this) {
      case EmotionalTag.happy:
        return 'Happy';
      case EmotionalTag.calm:
        return 'Calm';
      case EmotionalTag.energetic:
        return 'Energetic';
    }
  }
}

class FilterBottomSheet extends StatelessWidget {
  final String? selectedEmotion;
  final Function(String?) onEmotionSelected;
  final VoidCallback onClearFilters;

  const FilterBottomSheet({
    super.key,
    this.selectedEmotion,
    required this.onEmotionSelected,
    required this.onClearFilters,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filtrar contenido',
            style: crimsonSemiBold.copyWith(
              fontSize: 20,
              color: green29,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Filtrar por emoci�n',
            style: sourceSansSemiBold.copyWith(
              fontSize: 14,
              color: green29,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: EmotionalTag.values.map((emotion) {
              final isSelected = selectedEmotion == emotion.apiValue;
              return FilterChip(
                selected: isSelected,
                onSelected: (_) {
                  if (isSelected) {
                    onEmotionSelected(null);
                  } else {
                    onEmotionSelected(emotion.apiValue);
                  }
                },
                label: Text(
                  emotion.displayName,
                  style: sourceSansRegular.copyWith(
                    fontSize: 14,
                    color: isSelected ? green49 : green29,
                  ),
                ),
                backgroundColor: isSelected ? greenF2 : white,
                selectedColor: greenF2,
                checkmarkColor: green49,
                side: BorderSide(
                  color: isSelected ? green49 : green29,
                  width: 1,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    onClearFilters();
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: green29,
                    side: const BorderSide(color: green29),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Limpiar filtros',
                    style: sourceSansSemiBold.copyWith(fontSize: 14, color: green29),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: green49,
                    foregroundColor: white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Aplicar',
                    style: sourceSansSemiBold.copyWith(fontSize: 14, color: white),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
