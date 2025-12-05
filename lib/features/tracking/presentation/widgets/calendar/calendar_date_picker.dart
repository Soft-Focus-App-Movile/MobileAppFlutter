import 'package:flutter/material.dart';

class CalendarDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const CalendarDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  String _getMonthName(int month) {
    const months = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              final previousMonth = DateTime(
                selectedDate.year,
                selectedDate.month - 1,
              );
              onDateSelected(previousMonth);
            },
            icon: const Icon(Icons.chevron_left),
            color: const Color(0xFF6B8E7C),
          ),
          Text(
            '${_getMonthName(selectedDate.month)} ${selectedDate.year}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B8E7C),
            ),
          ),
          IconButton(
            onPressed: () {
              final nextMonth = DateTime(
                selectedDate.year,
                selectedDate.month + 1,
              );
              onDateSelected(nextMonth);
            },
            icon: const Icon(Icons.chevron_right),
            color: const Color(0xFF6B8E7C),
          ),
        ],
      ),
    );
  }
}