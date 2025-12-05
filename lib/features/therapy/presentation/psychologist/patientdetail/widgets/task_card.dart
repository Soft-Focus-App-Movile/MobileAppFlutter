import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/ui/colors.dart';
import '../../../../../../core/ui/text_styles.dart';
import '../../../../../library/domain/models/assignment.dart';

class TaskCard extends StatelessWidget {
  final Assignment assignment;

  const TaskCard({
    super.key,
    required this.assignment,
  });

  IconData _getIconForContentType(String type) {
    switch (type.toLowerCase()) {
      case 'movie':
        return Icons.movie;
      case 'music':
        return Icons.music_note;
      case 'video':
        return Icons.play_circle_outline;
      default:
        return Icons.wb_sunny;
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat("d 'de' MMMM", 'es_ES').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: const Color(0xFFF7F7F3),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              _getIconForContentType(assignment.content.type),
              color: green49,
              size: 32,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    assignment.content.title,
                    style: crimsonSemiBold.copyWith(
                      fontSize: 18,
                      color: black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    assignment.isCompleted ? 'Completada' : 'Pendiente',
                    style: sourceSansRegular.copyWith(
                      fontSize: 11,
                      color: assignment.isCompleted ? green49 : gray808,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Asignado el ${_formatDate(assignment.assignedDate)}',
                    style: sourceSansRegular.copyWith(
                      fontSize: 13,
                      color: gray808,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}