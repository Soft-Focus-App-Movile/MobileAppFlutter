enum NotificationType {
  info,
  alert,
  warning,
  emergency,
  checkinReminder,
  crisisAlert,
  messageReceived,
  assignmentDue,
  appointmentReminder,
  systemUpdate;

  String toJson() {
    switch (this) {
      case NotificationType.checkinReminder:
        return 'CHECKIN_REMINDER';
      case NotificationType.crisisAlert:
        return 'CRISIS_ALERT';
      case NotificationType.messageReceived:
        return 'MESSAGE_RECEIVED';
      case NotificationType.assignmentDue:
        return 'ASSIGNMENT_DUE';
      case NotificationType.appointmentReminder:
        return 'APPOINTMENT_REMINDER';
      case NotificationType.systemUpdate:
        return 'SYSTEM_UPDATE';
      default:
        return name.toUpperCase();
    }
  }

  static NotificationType fromJson(String value) {
    final normalized = value.toUpperCase().replaceAll('-', '_');
    switch (normalized) {
      case 'CHECKIN_REMINDER':
        return NotificationType.checkinReminder;
      case 'CRISIS_ALERT':
        return NotificationType.crisisAlert;
      case 'MESSAGE_RECEIVED':
        return NotificationType.messageReceived;
      case 'ASSIGNMENT_DUE':
        return NotificationType.assignmentDue;
      case 'APPOINTMENT_REMINDER':
        return NotificationType.appointmentReminder;
      case 'SYSTEM_UPDATE':
        return NotificationType.systemUpdate;
      case 'INFO':
        return NotificationType.info;
      case 'ALERT':
        return NotificationType.alert;
      case 'WARNING':
        return NotificationType.warning;
      case 'EMERGENCY':
        return NotificationType.emergency;
      default:
        return NotificationType.info;
    }
  }
}