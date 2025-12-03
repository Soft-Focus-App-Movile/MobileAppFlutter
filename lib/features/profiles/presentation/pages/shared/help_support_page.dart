import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/ui/colors.dart';
import '../../../../../core/ui/text_styles.dart';

RoundedRectangleBorder RoundedCornerShape(double radius) {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(radius),
  );
}

class HelpSupportPage extends StatelessWidget {
  final VoidCallback onNavigateBack;

  const HelpSupportPage({
    super.key,
    required this.onNavigateBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text(
          'Ayuda y Soporte',
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
              '¿Necesitas ayuda? Estamos aquí para ti',
              style: crimsonSemiBold.copyWith(
                fontSize: 20,
                color: black,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Contacta con nuestro equipo de soporte según tu necesidad. Estamos disponibles 24/7 para asistirte.',
              style: sourceSansRegular.copyWith(
                fontSize: 16,
                color: Colors.grey,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            _ContactCard(
              icon: Icons.email_outlined,
              title: 'Contacto General',
              contact: 'softfocusorg@gmail.com',
              description: 'Para consultas generales, sugerencias o información sobre SoftFocus',
              onTap: () => _launchEmail('softfocusorg@gmail.com'),
            ),
            const SizedBox(height: 16),
            _WebCard(
              onTap: () => _launchUrl('https://soft-focus-61053.web.app'),
            ),
            const SizedBox(height: 24),
            Text(
              'Soporte Especializado',
              style: sourceSansBold.copyWith(
                fontSize: 18,
                color: black,
                height: 1.33,
              ),
            ),
            const SizedBox(height: 16),
            _SupportNumberCard(
              icon: Icons.notifications_outlined,
              category: 'Notificaciones',
              phone: '952 280 745',
              description: 'Problemas con notificaciones, alertas o avisos de la app',
            ),
            const SizedBox(height: 16),
            _SupportNumberCard(
              icon: Icons.folder_outlined,
              category: 'Datos y Contenido',
              phone: '974 341 019',
              description: 'Gestión de datos, biblioteca de contenido y recursos',
            ),
            const SizedBox(height: 16),
            _SupportNumberCard(
              icon: Icons.security_outlined,
              category: 'Servidor y Seguridad',
              phone: '982 757 892',
              description: 'Problemas de conexión, seguridad y privacidad de datos',
            ),
            const SizedBox(height: 16),
            _SupportNumberCard(
              icon: Icons.psychology_outlined,
              category: 'Chat y Psicólogo',
              phone: '981 936 328',
              description: 'Comunicación con psicólogos, mensajes y sesiones',
            ),
            const SizedBox(height: 16),
            _SupportNumberCard(
              icon: Icons.calendar_month_outlined,
              category: 'Calendario y Seguimiento',
              phone: '933 372 489',
              description: 'Diario emocional, check-ins y progreso personal',
            ),
            const SizedBox(height: 24),
            Card(
              shape: RoundedCornerShape(12),
              color: green37.withOpacity(0.1),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.support_agent_outlined, color: green37, size: 28),
                        const SizedBox(width: 8),
                        Text(
                          'Atención Prioritaria 24/7',
                          style: sourceSansBold.copyWith(
                            fontSize: 18,
                            color: green37,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Para dudas específicas o atención urgente:',
                      style: sourceSansRegular.copyWith(
                        fontSize: 14,
                        color: black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () => _launchPhone('952280745'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        width: double.infinity,
                        child: Text(
                          '952 280 745',
                          style: sourceSansBold.copyWith(
                            fontSize: 20,
                            color: blue77,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Toca el número para llamar directamente',
                      style: sourceSansRegular.copyWith(
                        fontSize: 12,
                        color: gray828,
                      ),
                      textAlign: TextAlign.center,
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

  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  Future<void> _launchPhone(String phone) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String contact;
  final String description;
  final VoidCallback onTap;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.contact,
    required this.description,
    required this.onTap,
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
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      contact,
                      style: sourceSansBold.copyWith(
                        fontSize: 16,
                        color: blue77,
                        height: 1.375,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
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

class _WebCard extends StatelessWidget {
  final VoidCallback onTap;

  const _WebCard({required this.onTap});

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
            Icon(Icons.language_outlined, color: green37, size: 32),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sitio Web',
                    style: sourceSansBold.copyWith(
                      fontSize: 16,
                      color: black,
                      height: 1.375,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      'soft-focus-61053.web.app',
                      style: sourceSansBold.copyWith(
                        fontSize: 16,
                        color: blue77,
                        height: 1.375,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Visita nuestra página web oficial para más información sobre SoftFocus',
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

class _SupportNumberCard extends StatelessWidget {
  final IconData icon;
  final String category;
  final String phone;
  final String description;

  const _SupportNumberCard({
    required this.icon,
    required this.category,
    required this.phone,
    required this.description,
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
                    category,
                    style: sourceSansBold.copyWith(
                      fontSize: 16,
                      color: black,
                      height: 1.375,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () async {
                      final cleanPhone = phone.replaceAll(' ', '');
                      final Uri phoneUri = Uri(scheme: 'tel', path: cleanPhone);
                      if (await canLaunchUrl(phoneUri)) {
                        await launchUrl(phoneUri);
                      }
                    },
                    child: Text(
                      phone,
                      style: sourceSansBold.copyWith(
                        fontSize: 16,
                        color: blue77,
                        height: 1.375,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
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
