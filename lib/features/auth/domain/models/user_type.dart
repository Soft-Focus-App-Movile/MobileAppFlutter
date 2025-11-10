/// Represents the different types of users in the Soft Focus platform.
///
/// - GENERAL: Basic user without an assigned psychologist
/// - PATIENT: User with an assigned psychologist for therapy sessions
/// - PSYCHOLOGIST: Mental health professional providing therapy
/// - ADMIN: System administrator with full platform access
enum UserType {
  GENERAL,
  PATIENT,
  PSYCHOLOGIST,
  ADMIN;

  /// Convert from string to UserType
  static UserType fromString(String value) {
    switch (value.toUpperCase()) {
      case 'GENERAL':
        return UserType.GENERAL;
      case 'PATIENT':
        return UserType.PATIENT;
      case 'PSYCHOLOGIST':
        return UserType.PSYCHOLOGIST;
      case 'ADMIN':
        return UserType.ADMIN;
      default:
        return UserType.GENERAL;
    }
  }

  /// Convert UserType to string
  String toApiString() {
    return name;
  }
}
