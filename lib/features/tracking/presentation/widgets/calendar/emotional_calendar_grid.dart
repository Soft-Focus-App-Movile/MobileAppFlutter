import 'package:flutter/material.dart';
import '../../../domain/entities/emotional_calendar_entry.dart';
import '../../../../../core/utils/mood_helper.dart';

class EmotionalCalendarGrid extends StatelessWidget {
  final List<EmotionalCalendarEntry> entries;
  final DateTime selectedMonth;
  final Function(EmotionalCalendarEntry) onDateClick;

  const EmotionalCalendarGrid({
    Key? key,
    required this.entries,
    required this.selectedMonth,
    required this.onDateClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateTime(
      selectedMonth.year,
      selectedMonth.month + 1,
      0,
    ).day;

    final firstDayOfMonth = DateTime(
      selectedMonth.year,
      selectedMonth.month,
      1,
    );

    final weekdayOfFirstDay = firstDayOfMonth.weekday;
    final leadingEmptyDays = weekdayOfFirstDay == 7 ? 0 : weekdayOfFirstDay;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Weekday headers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['L', 'M', 'X', 'J', 'V', 'S', 'D']
                .map((day) => SizedBox(
                      width: 40,
                      child: Center(
                        child: Text(
                          day,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6B8E7C),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),

          // Calendar grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: leadingEmptyDays + daysInMonth,
            itemBuilder: (context, index) {
              if (index < leadingEmptyDays) {
                return const SizedBox();
              }

              final day = index - leadingEmptyDays + 1;
              final date = DateTime(
                selectedMonth.year,
                selectedMonth.month,
                day,
              );

              final entry = entries.firstWhere(
                (e) =>
                    e.date.year == date.year &&
                    e.date.month == date.month &&
                    e.date.day == date.day,
                orElse: () => EmotionalCalendarEntry(
                  id: '',
                  userId: '',
                  date: date,
                  emotionalEmoji: '',
                  moodLevel: 0,
                  emotionalTags: [],
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                ),
              );

              final hasEntry = entry.id.isNotEmpty;

              return GestureDetector(
                onTap: hasEntry ? () => onDateClick(entry) : null,
                child: Container(
                  decoration: BoxDecoration(
                    color: hasEntry
                        ? const Color(0xFFE8F5E9)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: hasEntry
                          ? const Color(0xFF6B8E7C).withOpacity(0.3)
                          : Colors.transparent,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (hasEntry)
                        Container(
                          width: 24,
                          height: 24,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              MoodHelper.getMoodImageFromLevel(entry.moodLevel),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      else
                        Text(
                          day.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      if (hasEntry)
                        Text(
                          day.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xFF6B8E7C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}