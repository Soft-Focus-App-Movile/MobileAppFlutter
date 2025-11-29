import 'package:flutter_app_softfocus/features/notifications/domain/entities/notification_type.dart';

class NotificationTemplate {
  final String id;
  final NotificationType type;
  final String title;
  final String body;
  final List<String> variables;

  const NotificationTemplate({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.variables,
  });
}