import '../../../domain/entities/notification_preference.dart';

class NotificationPreferencesState {
  final List<NotificationPreference> preferences;
  final bool isLoading;
  final bool isSaving;
  final String? error;
  final String? successMessage;

  const NotificationPreferencesState({
    this.preferences = const [],
    this.isLoading = false,
    this.isSaving = false,
    this.error,
    this.successMessage,
  });

  NotificationPreferencesState copyWith({
    List<NotificationPreference>? preferences,
    bool? isLoading,
    bool? isSaving,
    String? error,
    String? successMessage,
  }) {
    return NotificationPreferencesState(
      preferences: preferences ?? this.preferences,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      error: error,
      successMessage: successMessage,
    );
  }
}