import 'package:flutter/material.dart';
import 'package:flutter_app_softfocus/core/ui/text_styles.dart' as AppTextStyles;

class NotificationsDisabledView extends StatelessWidget {
  const NotificationsDisabledView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_off_outlined,
              size: 80,
              color: Colors.grey.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'Notificaciones desactivadas',
              style: AppTextStyles.sourceSansRegular.copyWith(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Activa las notificaciones en configuración para ver tus nuevos mensajes',
                style: AppTextStyles.sourceSansRegular.copyWith(
                  fontSize: 14,
                  color: Colors.grey.withOpacity(0.7),
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}