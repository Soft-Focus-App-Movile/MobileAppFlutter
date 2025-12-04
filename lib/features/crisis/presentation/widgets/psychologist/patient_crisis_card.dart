import 'package:flutter/material.dart';
import '../../../../../core/ui/colors.dart';
import '../../../../../core/ui/text_styles.dart';
import '../../../../../core/widgets/profile_avatar.dart';
import '../../../domain/models/crisis_alert.dart';

class PatientCrisisCard extends StatelessWidget {
  final CrisisAlert alert;
  final VoidCallback onViewProfile;
  final VoidCallback onSendMessage;
  final VoidCallback onUpdateStatus;

  const PatientCrisisCard({
    super.key,
    required this.alert,
    required this.onViewProfile,
    required this.onSendMessage,
    required this.onUpdateStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: greenF2,
      elevation: 2.5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: green49, width: 2),
                        ),
                        padding: const EdgeInsets.all(2),
                        child: ProfileAvatar(
                          imageUrl: alert.patientPhotoUrl,
                          fullName: alert.patientName,
                          size: 70,
                          fontSize: 24,
                          backgroundColor: green49,
                          textColor: white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              alert.patientName,
                              style: crimsonBold.copyWith(
                                fontSize: 18,
                                color: black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _getTimeAgo(alert.createdAt),
                              style: sourceSansRegular.copyWith(
                                fontSize: 12,
                                color: gray89,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildStatusBadge(alert.status),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                _buildSeverityBadge(alert.severity),
              ],
            ),
            const SizedBox(height: 12),
            if (alert.emotionalContext?.lastDetectedEmotion != null) ...[
              _buildInfoRow(
                icon: Icons.sentiment_satisfied_alt,
                label: 'Emoción detectada',
                value: alert.emotionalContext!.lastDetectedEmotion!,
              ),
              const SizedBox(height: 8),
            ],
            if (alert.location?.displayString != null) ...[
              _buildInfoRow(
                icon: Icons.location_on,
                label: 'Ubicación',
                value: alert.location?.displayString ?? '',
              ),
              const SizedBox(height: 8),
            ],
            _buildInfoRow(
              icon: Icons.flag,
              label: 'Origen',
              value: _formatTriggerSource(alert.triggerSource),
            ),
            if (alert.triggerReason != null) ...[
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 28),
                child: Row(
                  children: [
                    const Icon(
                      Icons.help_outline,
                      size: 16,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Razón: ${alert.triggerReason}',
                        style: sourceSansRegular.copyWith(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onViewProfile,
                    icon: const Icon(Icons.person_outline, size: 16),
                    label: const Text('Perfil', style: TextStyle(fontSize: 13)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: green49,
                      side: const BorderSide(color: green49),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: onSendMessage,
                  icon: const Icon(Icons.message_outlined, size: 16),
                  label: const Text('Escribir', style: TextStyle(fontSize: 13)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: green49,
                    side: const BorderSide(color: green49),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onUpdateStatus,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _getStatusColor(alert.status),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      _getNextStatusText(alert.status),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeverityBadge(String severity) {
    final config = _getSeverityConfig(severity);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: config.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        config.text,
        style: TextStyle(
          color: config.textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final config = _getStatusBadgeConfig(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: config.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Estado: ${config.text}',
        style: sourceSansRegular.copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: black,
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: green49),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: sourceSansRegular.copyWith(fontSize: 13, color: Colors.grey),
        ),
        Expanded(
          child: Text(
            value,
            style: sourceSansRegular.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: black,
            ),
          ),
        ),
      ],
    );
  }

  _SeverityConfig _getSeverityConfig(String severity) {
    switch (severity.toUpperCase()) {
      case 'CRITICAL':
        return _SeverityConfig(
          backgroundColor: redE8,
          textColor: white,
          text: 'Crisis',
        );
      case 'HIGH':
        return _SeverityConfig(
          backgroundColor: orangeFB,
          textColor: white,
          text: 'Alta',
        );
      case 'MODERATE':
        return _SeverityConfig(
          backgroundColor: greenAB,
          textColor: black,
          text: 'Moderada',
        );
      default:
        return _SeverityConfig(
          backgroundColor: gray89,
          textColor: black,
          text: severity,
        );
    }
  }

  _StatusBadgeConfig _getStatusBadgeConfig(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return _StatusBadgeConfig(backgroundColor: pending, text: 'Pendiente');
      case 'ATTENDED':
        return _StatusBadgeConfig(backgroundColor: attended, text: 'Atendido');
      case 'RESOLVED':
        return _StatusBadgeConfig(backgroundColor: resolved, text: 'Resuelto');
      case 'DISMISSED':
        return _StatusBadgeConfig(
            backgroundColor: dismissed, text: 'Descartado');
      default:
        return _StatusBadgeConfig(backgroundColor: gray89, text: status);
    }
  }

  String _formatTriggerSource(String source) {
    switch (source.toUpperCase()) {
      case 'MANUAL_BUTTON':
        return 'Manual (Botón SOS)';
      case 'AI_CHAT':
        return 'Chat IA';
      case 'EMOTION_ANALYSIS':
        return 'Análisis de emoción';
      case 'CHECK_IN':
        return 'Check-in diario';
      default:
        return source;
    }
  }

  String _getNextStatusText(String currentStatus) {
    switch (currentStatus.toUpperCase()) {
      case 'PENDING':
        return 'Atender';
      case 'ATTENDED':
        return 'Resolver';
      case 'RESOLVED':
        return 'Marcar Pendiente';
      default:
        return 'Actualizar';
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return pendingButton;
      case 'ATTENDED':
        return attendedButton;
      case 'RESOLVED':
        return green49;
      default:
        return green49;
    }
  }

  String _getTimeAgo(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 0) {
        return 'Hace ${difference.inDays}d';
      } else if (difference.inHours > 0) {
        return 'Hace ${difference.inHours}h';
      } else if (difference.inMinutes > 0) {
        return 'Hace ${difference.inMinutes}m';
      } else {
        return 'Ahora';
      }
    } catch (e) {
      return dateString;
    }
  }
}

class _SeverityConfig {
  final Color backgroundColor;
  final Color textColor;
  final String text;

  _SeverityConfig({
    required this.backgroundColor,
    required this.textColor,
    required this.text,
  });
}

class _StatusBadgeConfig {
  final Color backgroundColor;
  final String text;

  _StatusBadgeConfig({
    required this.backgroundColor,
    required this.text,
  });
}
