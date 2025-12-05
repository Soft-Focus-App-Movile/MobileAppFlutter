import 'package:flutter/material.dart';
import '../../../../therapy/domain/models/patient_directory_item.dart';

class PatientsTracking extends StatelessWidget {
  final List<PatientDirectoryItem> patients;
  final Function(PatientDirectoryItem) onPatientClick;
  final VoidCallback onViewAllClick;

  const PatientsTracking({
    super.key,
    required this.patients,
    required this.onPatientClick,
    required this.onViewAllClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Pacientes con actividad reciente',
            style: TextStyle(
              fontFamily: 'Crimson',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Color(0xFF497654),
            ),
          ),
          const SizedBox(height: 12),

          // Estado vacío o lista de pacientes
          if (patients.isEmpty)
            _EmptyPatientsState()
          else ...[
            // Lista de pacientes (máximo 4)
            ...patients.take(4).map((patient) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: PatientActivityCard(
                    patient: patient,
                    onClick: () => onPatientClick(patient),
                  ),
                )),

            // Botón "Ver todos"
            if (patients.length > 4)
              TextButton(
                onPressed: onViewAllClick,
                child: Text(
                  'Ver todos',
                  style: TextStyle(
                    fontFamily: 'SourceSans3',
                    fontSize: 14,
                    color: Color(0xFF497654),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _EmptyPatientsState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Column(
        children: [
          // Imagen del elefante
          Image.asset(
            'assets/images/elephant_focus.png',
            width: 120,
            height: 120,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.people_outline,
                size: 120,
                color: Color(0xFF497654).withOpacity(0.3),
              );
            },
          ),
          const SizedBox(height: 16),

          // Mensaje
          Text(
            'Aún no tienes pacientes',
            style: TextStyle(
              fontFamily: 'Crimson',
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Color(0xFF497654),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              'Conecta compartiendo tu código de invitación',
              style: TextStyle(
                fontFamily: 'SourceSans3',
                fontSize: 14,
                color: Color(0xFF828282),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class PatientActivityCard extends StatelessWidget {
  final PatientDirectoryItem patient;
  final VoidCallback onClick;

  const PatientActivityCard({
    super.key,
    required this.patient,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Color(0xFFF2FCF4),
      elevation: 2,
      child: InkWell(
        onTap: onClick,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Avatar del paciente
              _ProfileAvatar(
                imageUrl: patient.profilePhotoUrl,
                fullName: patient.patientName,
              ),
              const SizedBox(width: 16),

              // Información del paciente
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patient.patientName,
                      style: TextStyle(
                        fontFamily: 'Crimson',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${patient.sessionCount} sesiones',
                      style: TextStyle(
                        fontFamily: 'SourceSans3',
                        fontSize: 13,
                        color: Color(0xFFA2A2A2),
                      ),
                    ),
                    if (patient.lastSessionDate != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        'Última sesión: ${patient.lastSessionDate}',
                        style: TextStyle(
                          fontFamily: 'SourceSans3',
                          fontSize: 12,
                          color: Color(0xFFA2A2A2),
                        ),
                      ),
                    ],
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

class _ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final String fullName;

  const _ProfileAvatar({
    required this.imageUrl,
    required this.fullName,
  });

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl!,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Text(
                      _getInitials(fullName),
                      style: TextStyle(
                        fontFamily: 'Crimson',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Color(0xFF2D6F3C),
                      ),
                    ),
                  );
                },
              ),
            )
          : Center(
              child: Text(
                _getInitials(fullName),
                style: TextStyle(
                  fontFamily: 'Crimson',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Color(0xFF2D6F3C),
                ),
              ),
            ),
    );
  }
}
