import 'package:flutter/material.dart';

class SymptomsSelectionStep extends StatelessWidget {
  final List<String> selectedSymptoms;
  final Function(List<String>) onSymptomsSelected;
  final VoidCallback onNext;

  const SymptomsSelectionStep({
    Key? key,
    required this.selectedSymptoms,
    required this.onSymptomsSelected,
    required this.onNext,
  }) : super(key: key);

  static const List<String> _symptoms = [
    'Ansiedad',
    'Tristeza',
    'Estrés',
    'Insomnio',
    'Fatiga',
    'Irritabilidad',
    'Pérdida de apetito',
    'Dificultad para concentrarse',
  ];

  void _toggleSymptom(String symptom) {
    final newSelection = List<String>.from(selectedSymptoms);
    if (newSelection.contains(symptom)) {
      newSelection.remove(symptom);
    } else {
      newSelection.add(symptom);
    }
    onSymptomsSelected(newSelection);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          '¿Experimentaste alguno de estos síntomas?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        
        // Symptoms grid
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: _symptoms.map((symptom) {
            final isSelected = selectedSymptoms.contains(symptom);
            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _toggleSymptom(symptom),
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? Colors.white 
                        : Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    symptom,
                    style: TextStyle(
                      color: isSelected 
                          ? const Color(0xFF6B8E7C) 
                          : Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
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