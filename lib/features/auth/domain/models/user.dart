import 'user_type.dart';

/// Represents a user in the Soft Focus platform.
///
/// This is a domain entity containing only business logic data,
/// without any framework dependencies.
///
/// - [id] Unique identifier for the user
/// - [email] User's email address
/// - [userType] Type of user (GENERAL, PATIENT, PSYCHOLOGIST, ADMIN)
/// - [isVerified] Whether the user's account has been verified by administrators
/// - [token] Authentication token for API requests (nullable for pre-login states)
/// - [fullName] User's full name (nullable until profile completion)
/// - [firstName] User's first name
/// - [lastName] User's last name
/// - [dateOfBirth] User's date of birth (ISO 8601 format)
/// - [gender] User's gender (Male, Female, Other, PreferNotToSay)
/// - [phone] User's phone number
/// - [profileImageUrl] URL to user's profile image
/// - [bio] User's biography/description
/// - [country] User's country
/// - [city] User's city
/// - [interests] List of user's interests
/// - [mentalHealthGoals] List of user's mental health goals
/// - [emailNotifications] Whether email notifications are enabled
/// - [pushNotifications] Whether push notifications are enabled
/// - [isProfilePublic] Whether the profile is public
class User {
  final String id;
  final String email;
  final UserType userType;
  final bool isVerified;
  final String? token;
  final String? fullName;
  final String? firstName;
  final String? lastName;
  final String? dateOfBirth;
  final String? gender;
  final String? phone;
  final String? profileImageUrl;
  final String? bio;
  final String? country;
  final String? city;
  final List<String>? interests;
  final List<String>? mentalHealthGoals;
  final bool emailNotifications;
  final bool pushNotifications;
  final bool isProfilePublic;

  User({
    required this.id,
    required this.email,
    required this.userType,
    this.isVerified = false,
    this.token,
    this.fullName,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.gender,
    this.phone,
    this.profileImageUrl,
    this.bio,
    this.country,
    this.city,
    this.interests,
    this.mentalHealthGoals,
    this.emailNotifications = true,
    this.pushNotifications = true,
    this.isProfilePublic = false,
  });

  /// Create a copy of User with modified fields
  User copyWith({
    String? id,
    String? email,
    UserType? userType,
    bool? isVerified,
    String? token,
    String? fullName,
    String? firstName,
    String? lastName,
    String? dateOfBirth,
    String? gender,
    String? phone,
    String? profileImageUrl,
    String? bio,
    String? country,
    String? city,
    List<String>? interests,
    List<String>? mentalHealthGoals,
    bool? emailNotifications,
    bool? pushNotifications,
    bool? isProfilePublic,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      userType: userType ?? this.userType,
      isVerified: isVerified ?? this.isVerified,
      token: token ?? this.token,
      fullName: fullName ?? this.fullName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      bio: bio ?? this.bio,
      country: country ?? this.country,
      city: city ?? this.city,
      interests: interests ?? this.interests,
      mentalHealthGoals: mentalHealthGoals ?? this.mentalHealthGoals,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      isProfilePublic: isProfilePublic ?? this.isProfilePublic,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          userType == other.userType;

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ userType.hashCode;

  @override
  String toString() {
    return 'User(id: $id, email: $email, userType: $userType, isVerified: $isVerified)';
  }
}
