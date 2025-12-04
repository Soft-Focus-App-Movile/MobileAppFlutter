import 'package:flutter/material.dart';
import '../../../../../../core/ui/colors.dart' as AppColors;
import '../../../../../../core/ui/text_styles.dart' as AppTextStyles;
import '../../../../domain/models/patient_directory_item.dart';

class PatientListItem extends StatelessWidget {
  final PatientDirectoryItem patient;
  final VoidCallback onTap;

  const PatientListItem({
    super.key,
    required this.patient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // Imagen de perfil (replicando el CircleShape/Image de Kotlin)
                ClipOval(
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.grey[200],
                    child: patient.profilePhotoUrl.isNotEmpty
                        ? Image.network(
                            patient.profilePhotoUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, color: Colors.grey),
                          )
                        : const Icon(Icons.person, color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 12),
                
                // Nombre y Estado
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        patient.patientName,
                        style: AppTextStyles.sourceSansSemiBold.copyWith(
                          fontSize: 16,
                          color: const Color(0xFF222222),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        patient.status,
                        style: AppTextStyles.sourceSansRegular.copyWith(
                          fontSize: 14,
                          // Usando el color PrimaryGreen de tu tema (AppColors.green49)
                          color: AppColors.green49, 
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                // Sesiones e Icono
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${patient.sessionCount} sessions',
                      style: AppTextStyles.sourceSansRegular.copyWith(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}