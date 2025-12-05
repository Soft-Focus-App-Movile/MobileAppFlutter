import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/ui/colors.dart';
import '../../../../../../core/ui/text_styles.dart';
import '../../../../../../core/widgets/profile_avatar.dart';

class PatientDetailHeader extends StatelessWidget {
  final String patientName;
  final int age;
  final String profilePhotoUrl;
  final String startDate;

  const PatientDetailHeader({
    super.key,
    required this.patientName,
    required this.age,
    required this.profilePhotoUrl,
    required this.startDate,
  });

  String _formatStartDate(String isoDate) {
    if (isoDate.isEmpty) return 'Fecha desconocida';
    
    try {
      final date = DateTime.parse(isoDate);
      final formatted = DateFormat.yMMMM('es_ES').format(date);
      return 'Paciente desde ${formatted[0].toUpperCase()}${formatted.substring(1)}';
    } catch (e) {
      return 'Paciente desde ${isoDate.substring(0, 10)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        ProfileAvatar(
          imageUrl: profilePhotoUrl,
          fullName: patientName,
          size: 100,
          fontSize: 40,
        ),
        const SizedBox(height: 16),
        Text(
          patientName,
          style: crimsonSemiBold.copyWith(
            fontSize: 30,
            color: black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$age años',
          style: sourceSansSemiBold.copyWith(
            fontSize: 13,
            color: gray808,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _formatStartDate(startDate),
          style: sourceSansSemiBold.copyWith(
            fontSize: 13,
            color: green49,
          ),
        ),
      ],
    );
  }
}