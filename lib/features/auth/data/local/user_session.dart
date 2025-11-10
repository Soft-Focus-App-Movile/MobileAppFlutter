import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/user.dart';
import '../../domain/models/user_type.dart';

/// Manages user session data in local storage
class UserSession {
  // Keys for SharedPreferences
  static const String _keyUserId = "user_id";
  static const String _keyEmail = "user_email";
  static const String _keyUserType = "user_type";
  static const String _keyIsVerified = "user_is_verified";
  static const String _keyToken = "user_token";
  static const String _keyTokenExpiration = "user_token_expiration";
  static const String _keyFullName = "user_full_name";
  static const String _keyFirstName = "user_first_name";
  static const String _keyLastName = "user_last_name";
  static const String _keyDateOfBirth = "user_date_of_birth";
  static const String _keyGender = "user_gender";
  static const String _keyPhone = "user_phone";
  static const String _keyProfileImageUrl = "user_profile_image_url";
  static const String _keyBio = "user_bio";
  static const String _keyCountry = "user_country";
  static const String _keyCity = "user_city";
  static const String _keyInterests = "user_interests";
  static const String _keyMentalHealthGoals = "user_mental_health_goals";
  static const String _keyEmailNotifications = "user_email_notifications";
  static const String _keyPushNotifications = "user_push_notifications";
  static const String _keyIsProfilePublic = "user_is_profile_public";

  /// Save user to local storage
  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();

    // Calculate token expiration time (7 days from now)
    final expirationTime = DateTime.now().millisecondsSinceEpoch + (7 * 24 * 60 * 60 * 1000);

    await prefs.setString(_keyUserId, user.id);
    await prefs.setString(_keyEmail, user.email);
    await prefs.setString(_keyUserType, user.userType.name);
    await prefs.setBool(_keyIsVerified, user.isVerified);

    if (user.token != null) {
      await prefs.setString(_keyToken, user.token!);
    }

    await prefs.setInt(_keyTokenExpiration, expirationTime);

    if (user.fullName != null) {
      await prefs.setString(_keyFullName, user.fullName!);
    }
    if (user.firstName != null) {
      await prefs.setString(_keyFirstName, user.firstName!);
    }
    if (user.lastName != null) {
      await prefs.setString(_keyLastName, user.lastName!);
    }
    if (user.dateOfBirth != null) {
      await prefs.setString(_keyDateOfBirth, user.dateOfBirth!);
    }
    if (user.gender != null) {
      await prefs.setString(_keyGender, user.gender!);
    }
    if (user.phone != null) {
      await prefs.setString(_keyPhone, user.phone!);
    }
    if (user.profileImageUrl != null) {
      await prefs.setString(_keyProfileImageUrl, user.profileImageUrl!);
    }
    if (user.bio != null) {
      await prefs.setString(_keyBio, user.bio!);
    }
    if (user.country != null) {
      await prefs.setString(_keyCountry, user.country!);
    }
    if (user.city != null) {
      await prefs.setString(_keyCity, user.city!);
    }
    if (user.interests != null) {
      await prefs.setStringList(_keyInterests, user.interests!);
    }
    if (user.mentalHealthGoals != null) {
      await prefs.setStringList(_keyMentalHealthGoals, user.mentalHealthGoals!);
    }

    await prefs.setBool(_keyEmailNotifications, user.emailNotifications);
    await prefs.setBool(_keyPushNotifications, user.pushNotifications);
    await prefs.setBool(_keyIsProfilePublic, user.isProfilePublic);
  }

  /// Get user from local storage
  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    final id = prefs.getString(_keyUserId);
    final email = prefs.getString(_keyEmail);
    final userTypeString = prefs.getString(_keyUserType);

    if (id == null || email == null || userTypeString == null) {
      return null;
    }

    final userType = UserType.fromString(userTypeString);

    return User(
      id: id,
      email: email,
      userType: userType,
      isVerified: prefs.getBool(_keyIsVerified) ?? false,
      token: prefs.getString(_keyToken),
      fullName: prefs.getString(_keyFullName),
      firstName: prefs.getString(_keyFirstName),
      lastName: prefs.getString(_keyLastName),
      dateOfBirth: prefs.getString(_keyDateOfBirth),
      gender: prefs.getString(_keyGender),
      phone: prefs.getString(_keyPhone),
      profileImageUrl: prefs.getString(_keyProfileImageUrl),
      bio: prefs.getString(_keyBio),
      country: prefs.getString(_keyCountry),
      city: prefs.getString(_keyCity),
      interests: prefs.getStringList(_keyInterests),
      mentalHealthGoals: prefs.getStringList(_keyMentalHealthGoals),
      emailNotifications: prefs.getBool(_keyEmailNotifications) ?? true,
      pushNotifications: prefs.getBool(_keyPushNotifications) ?? true,
      isProfilePublic: prefs.getBool(_keyIsProfilePublic) ?? false,
    );
  }

  /// Clear all user session data
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  /// Check if the stored token has expired
  /// Returns true if token is expired, false if still valid
  Future<bool> isTokenExpired() async {
    final prefs = await SharedPreferences.getInstance();
    final expirationTime = prefs.getInt(_keyTokenExpiration);

    if (expirationTime == null) {
      // No expiration time stored, consider expired for safety
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch >= expirationTime;
  }
}
