import '../data/local/local_user_data_source.dart';
import '../../features/auth/data/local/user_session.dart';
import '../../features/auth/domain/models/user.dart';

/// Utility class to manage user sessions.
/// Handles login persistence (like Instagram/Facebook) and logout cleanup.
class SessionManager {
  SessionManager._();

  /// Clears all user session data from local storage and memory.
  /// This should be called when user explicitly logs out or session expires.
  static Future<void> logout() async {
    try {
      // Clear UserSession (user info, token, etc.)
      final userSession = UserSession();
      await userSession.clear();

      // Clear LocalUserDataSource (therapeutic relationship status)
      final localUserDataSource = LocalUserDataSource();
      await localUserDataSource.clear();

      // TODO: Clear other module tokens when modules are migrated
      // AdminPresentationModule.clearAuthToken();
      // NotificationPresentationModule.clearAuthToken();
      // PsychologistPresentationModule.clearAuthToken();
      // LibraryDataModule.clearRepository();

      // TODO: Clear image cache when implemented
      await clearImageCache();

      print('✓ Session data cleared successfully');
    } catch (e) {
      print('✗ Error clearing session data: $e');
      rethrow;
    }
  }

  /// Checks if there's an active session (user logged in).
  /// Used for auto-login functionality.
  static Future<bool> hasActiveSession() async {
    final userSession = UserSession();
    final user = await userSession.getUser();
    return user != null;
  }

  /// Gets the current logged-in user, if any.
  static Future<User?> getCurrentUser() async {
    final userSession = UserSession();
    return await userSession.getUser();
  }

  /// Clears image cache from memory and disk.
  /// TODO: Implement when image caching is added (e.g., cached_network_image package)
  static Future<void> clearImageCache() async {
    try {
      // Implementation will depend on the image caching library used
      // For example, with cached_network_image:
      // await DefaultCacheManager().emptyCache();
      print('⚠️ Image cache clearing not implemented yet');
    } catch (e) {
      print('Error clearing image cache: $e');
    }
  }
}
