import 'package:flutter/material.dart';

class DetailsStep extends StatefulWidget {
  final String question;
  final String notes;
  final Function(String) onNotesChanged;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const DetailsStep({
    Key? key,
    required this.question,
    required this.notes,
    required this.onNotesChanged,
    required this.onNext,
    required this.onSkip,
  }) : super(key: key);

  @override
  State<DetailsStep> createState() => _DetailsStepState();
}

class _DetailsStepState extends State<DetailsStep> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.notes);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          widget.question,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 48),
        
        // Text field
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: _controller,
            onChanged: widget.onNotesChanged,
            maxLines: 6,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
            decoration: const InputDecoration(
              hintText: 'Escribe aquí...',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(20),
            ),
          ),
        ),
        const SizedBox(height: 32),
        
        // Buttons
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
        const SizedBox(height: 12),
        
        TextButton(
          onPressed: widget.onSkip,
          child: const Text(
            'Omitir',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}