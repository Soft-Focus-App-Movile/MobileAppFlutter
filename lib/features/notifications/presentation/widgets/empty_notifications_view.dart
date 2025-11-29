import 'package:flutter/material.dart';
import 'package:flutter_app_softfocus/core/ui/text_styles.dart' as AppTextStyles;


class EmptyNotificationsView extends StatelessWidget {
  const EmptyNotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_outlined,
              size: 80,
              color: Colors.grey.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'No hay notificaciones',
              style: AppTextStyles.sourceSansRegular.copyWith(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Cuando recibas notificaciones aparecerán aquí',
              style: AppTextStyles.sourceSansRegular.copyWith(
                fontSize: 14,
                color: Colors.grey.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}