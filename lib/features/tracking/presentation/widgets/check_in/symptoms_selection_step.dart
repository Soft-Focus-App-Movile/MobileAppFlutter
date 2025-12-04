import 'package:flutter/material.dart';

class SymptomsSelectionStep extends StatefulWidget {
  final List<String> selectedSymptoms;
  final Function(List<String>) onSymptomsSelected;
  final VoidCallback onNext;

  const SymptomsSelectionStep({
    Key? key,
    required this.selectedSymptoms,
    required this.onSymptomsSelected,
    required this.onNext,
  }) : super(key: key);

  @override
  State<SymptomsSelectionStep> createState() => _SymptomsSelectionStepState();
}

class _SymptomsSelectionStepState extends State<SymptomsSelectionStep> {
  bool _showPositiveSymptoms = false;

  static const List<String> _negativeSymptoms = [
    'Ansiedad',
    'Tristeza',
    'Estrés',
    'Insomnio',
    'Fatiga',
    'Irritabilidad',
    'Pérdida de apetito',
    'Dificultad para concentrarse',
  ];

  static const List<String> _positiveSymptoms = [
    'Energía',
    'Motivación',
    'Tranquilidad',
    'Alegría',
    'Concentración',
    'Optimismo',
    'Buen apetito',
    'Sueño reparador',
  ];

  List<String> get _currentSymptoms => _showPositiveSymptoms ? _positiveSymptoms : _negativeSymptoms;

  void _toggleSymptom(String symptom) {
    final newSelection = List<String>.from(widget.selectedSymptoms);
    if (newSelection.contains(symptom)) {
      newSelection.remove(symptom);
    } else {
      newSelection.add(symptom);
    }
    widget.onSymptomsSelected(newSelection);
  }

  Widget _buildToggleButton(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showPositiveSymptoms = text == 'Positivos';
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? const Color(0xFF6B8E7C) : Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          _showPositiveSymptoms 
              ? '¿Experimentaste alguno de estos aspectos positivos?'
              : '¿Experimentaste alguno de estos síntomas?',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        
        // Toggle between negative and positive symptoms
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildToggleButton('Síntomas', !_showPositiveSymptoms),
              _buildToggleButton('Positivos', _showPositiveSymptoms),
            ],
          ),
        ),
        const SizedBox(height: 32),
        
        // Symptoms grid
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: _currentSymptoms.map((symptom) {
            final isSelected = widget.selectedSymptoms.contains(symptom);
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
            onPressed: widget.onNext,
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