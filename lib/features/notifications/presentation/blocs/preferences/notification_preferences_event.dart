import 'package:flutter/material.dart';

abstract class NotificationPreferencesEvent {
  const NotificationPreferencesEvent();
}

class LoadPreferences extends NotificationPreferencesEvent {
  const LoadPreferences();
}

class ToggleMasterPreference extends NotificationPreferencesEvent {
  const ToggleMasterPreference();
}

class UpdateSchedule extends NotificationPreferencesEvent {
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  const UpdateSchedule({
    required this.startTime,
    required this.endTime,
  });
}