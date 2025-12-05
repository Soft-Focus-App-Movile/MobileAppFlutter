import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/ui/colors.dart';
import '../../../../../../core/ui/text_styles.dart';
import '../../../../../tracking/domain/entities/check_in.dart';

class LastCheckInCard extends StatelessWidget {
  final CheckIn? checkIn;
  final bool isLoading;

  const LastCheckInCard({
    super.key,
    this.checkIn,
    this.isLoading = false,
  });

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final checkInDate = DateTime(date.year, date.month, date.day);

    if (checkInDate == today) {
      return 'Hoy';
    } else if (checkInDate == yesterday) {
      return 'Ayer';
    } else {
      return DateFormat('d MMM', 'es_ES').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (checkIn == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            'No hay registros de check-in.',
            style: sourceSansRegular.copyWith(
              color: gray808,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: const Color(0xFFF7F7F3),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDate(checkIn!.completedAt),
                  style: crimsonSemiBold.copyWith(
                    fontSize: 20,
                    color: black,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: yellowCB9C,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${checkIn!.emotionalLevel}/10',
                    style: sourceSansRegular.copyWith(
                      fontSize: 10,
                      color: white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (checkIn!.symptoms.isNotEmpty) ...[
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: checkIn!.symptoms
                    .map((symptom) => _SymptomTag(text: symptom))
                    .toList(),
              ),
              const SizedBox(height: 8),
            ],
            if (checkIn!.notes != null && checkIn!.notes!.isNotEmpty)
              Text(
                checkIn!.notes!,
                style: sourceSansRegular.copyWith(
                  fontSize: 12,
                  color: black,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SymptomTag extends StatelessWidget {
  final String text;

  const _SymptomTag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: yellowCB9C,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: sourceSansRegular.copyWith(
          fontSize: 10,
          color: white,
        ),
      ),
    );
  }
}