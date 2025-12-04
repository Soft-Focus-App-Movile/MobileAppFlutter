// lib/features/therapy/presentation/psychologist/patientlist/widgets/patient_card.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/ui/colors.dart';
import '../../../../../../core/ui/text_styles.dart';
import '../../../../../../core/widgets/profile_avatar.dart';
import '../../../../domain/models/patient_directory_item.dart';

class PatientCard extends StatelessWidget {
  final PatientDirectoryItem patient;
  final VoidCallback onTap;

  const PatientCard({
    super.key,
    required this.patient,
    required this.onTap,
  });

  String _formatDate(DateTime date) {
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: const Color(0xFFF7F7F3),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Profile Avatar
              ProfileAvatar(
                imageUrl: patient.profilePhotoUrl,
                fullName: patient.patientName,
                size: 64,
                fontSize: 24,
              ),
              const SizedBox(width: 16),

              // Patient Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patient.patientName,
                      style: crimsonSemiBold.copyWith(
                        fontSize: 24,
                        color: black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Conectado desde: ${_formatDate(patient.startDate)}',
                      style: sourceSansRegular.copyWith(
                        fontSize: 14,
                        color: const Color(0xFF8B8B8B),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Sesiones: ${patient.sessionCount}',
                      style: sourceSansRegular.copyWith(
                        fontSize: 14,
                        color: const Color(0xFF8B8B8B),
                      ),
                    ),
                    const SizedBox(height: 2),
                    TextButton(
                      onPressed: onTap,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft,
                      ),
                      child: Text(
                        'Ver Perfil',
                        style: sourceSansSemiBold.copyWith(
                          fontSize: 14,
                          color: const Color(0xFF4B634B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}