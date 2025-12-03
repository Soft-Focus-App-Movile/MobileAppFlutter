import 'package:flutter/material.dart';
import '../../../../../core/ui/colors.dart';
import '../../../../../core/ui/text_styles.dart';

RoundedRectangleBorder RoundedCornerShape(double radius) {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(radius),
  );
}

class PrivacyPolicyPage extends StatelessWidget {
  final VoidCallback onNavigateBack;

  const PrivacyPolicyPage({
    super.key,
    required this.onNavigateBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text(
          'Política de Privacidad',
          style: crimsonSemiBold.copyWith(
            fontSize: 24,
            color: green37,
          ),
        ),
        backgroundColor: white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: green37),
          onPressed: onNavigateBack,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Última actualización: Noviembre 2025',
              style: sourceSansRegular.copyWith(
                fontSize: 14,
                color: gray828,
              ),
            ),
            const SizedBox(height: 20),
            _PrivacyCard(
              icon: Icons.verified_user,
              title: 'Compromiso con tu Privacidad',
              content:
                  'En SoftFocus, tu privacidad y seguridad son nuestra máxima prioridad. '
                  'Nos comprometemos a proteger toda tu información personal y de salud mental '
                  'con los más altos estándares de seguridad y confidencialidad.',
            ),
            const SizedBox(height: 20),
            _PrivacyCard(
              icon: Icons.chat_outlined,
              title: 'Chat de Inteligencia Artificial',
              content:
                  'Todas las conversaciones con nuestro asistente de IA están completamente encriptadas '
                  'de extremo a extremo. Tu información nunca es compartida con terceros y se utiliza '
                  'únicamente para brindarte apoyo personalizado.',
            ),
            const SizedBox(height: 20),
            _PrivacyCard(
              icon: Icons.camera_alt_outlined,
              title: 'Análisis de Emociones por Imagen',
              content:
                  'Las imágenes son procesadas de forma segura y encriptada. No almacenamos las fotografías originales, '
                  'solo los resultados del análisis emocional. Puedes eliminar estos datos en cualquier momento.',
            ),
            const SizedBox(height: 20),
            _PrivacyCard(
              icon: Icons.psychology_outlined,
              title: 'Comunicación con tu Psicólogo',
              content:
                  'Todos los mensajes y registros compartidos con tu psicólogo están protegidos '
                  'por encriptación de grado médico. Solo tú y tu psicólogo asignado tienen acceso. '
                  'Cumplimos con la confidencialidad profesional establecida por ley.',
            ),
            const SizedBox(height: 20),
            _PrivacyCard(
              icon: Icons.calendar_month_outlined,
              title: 'Diario y Seguimiento Emocional',
              content:
                  'Tus registros diarios y estados de ánimo están almacenados de forma segura y privada. '
                  'Esta información es visible únicamente para ti y, si lo autorizas, para tu psicólogo asignado.',
            ),
            const SizedBox(height: 20),
            _PrivacyCard(
              icon: Icons.security,
              title: 'Seguridad de la Información',
              content:
                  'Utilizamos encriptación AES-256 para proteger toda tu información. Nuestros servidores '
                  'están certificados y cumplen con estándares internacionales de seguridad (ISO 27001).',
            ),
            const SizedBox(height: 20),
            _PrivacyCard(
              icon: Icons.gavel_outlined,
              title: 'Tus Derechos',
              content:
                  'Tienes derecho a acceder, corregir y eliminar tu información personal en cualquier momento. '
                  'Puedes descargar una copia de tus datos y revocar permisos cuando lo desees.',
            ),
            const SizedBox(height: 20),
            Card(
              shape: RoundedCornerShape(12),
              color: green37.withOpacity(0.1),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.contact_support_outlined, color: green37, size: 40),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '¿Dudas sobre privacidad?',
                            style: sourceSansBold.copyWith(
                              fontSize: 16,
                              color: black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'softfocusorg@gmail.com',
                            style: sourceSansRegular.copyWith(
                              fontSize: 14,
                              color: blue77,
                            ),
                          ),
                          Text(
                            '952 280 745 (24/7)',
                            style: sourceSansRegular.copyWith(
                              fontSize: 14,
                              color: blue77,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _PrivacyCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _PrivacyCard({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedCornerShape(12),
      color: const Color(0xFFF5F5F5),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: green37, size: 32),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: sourceSansBold.copyWith(
                      fontSize: 16,
                      color: black,
                      height: 1.375,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    content,
                    style: sourceSansRegular.copyWith(
                      fontSize: 14,
                      color: gray828,
                      height: 1.43,
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
