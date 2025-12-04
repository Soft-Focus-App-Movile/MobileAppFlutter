import '../../features/auth/data/local/user_session.dart';
import '../../features/auth/domain/models/user.dart';

/// Utility class to manage user sessions.
/// Handles login persistence and logout cleanup.
/// Singleton pattern (like Kotlin object SessionManager).
class SessionManager {
  SessionManager._(); // Private constructor
  static final SessionManager _instance = SessionManager._();
  static SessionManager get instance => _instance;

  final UserSession _userSession = UserSession();

  /// Clears all user session data from local storage.
  /// This should be called when user explicitly logs out or session expires.
  Future<void> logout() async {
    // Clear UserSession (user info, token, etc.)
    await _userSession.clear();

    // TODO: Clear LocalUserDataSource (therapeutic relationship status)
    // final localUserDataSource = LocalUserDataSource();
    // await localUserDataSource.clear();

    // TODO: Clear auth tokens from presentation modules
    // AdminPresentationModule.clearAuthToken();
    // NotificationPresentationModule.clearAuthToken();
    // PsychologistPresentationModule.clearAuthToken();

    // TODO: Clear library repository singleton
    // LibraryDataModule.clearRepository();

    // TODO: Clear image cache
    // clearImageCache();
  }

  /// Checks if there's an active session (user logged in).
  /// Used for auto-login functionality.
  Future<bool> hasActiveSession() async {
    final user = await _userSession.getUser();
    if (user == null) return false;

    // Check if token is expired
    final isExpired = await _userSession.isTokenExpired();
    return !isExpired;
  }

  /// Gets the current logged-in user, if any.
  Future<User?> getCurrentUser() async {
    return await _userSession.getUser();
  }
  
  // NUEVO: Método requerido por NotificationsBloc
  /// Alias para getCurrentUser() - requerido por feature de notificaciones
  Future<User?> getUser() async {
    return await getCurrentUser();
  }
}