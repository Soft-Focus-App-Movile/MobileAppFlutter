/// Events for RegisterBloc
abstract class RegisterEvent {}

/// Event to update email field
class RegisterEmailChanged extends RegisterEvent {
  final String email;
  RegisterEmailChanged(this.email);
}

/// Event to update password field
class RegisterPasswordChanged extends RegisterEvent {
  final String password;
  RegisterPasswordChanged(this.password);
}

/// Event to update confirm password field
class RegisterConfirmPasswordChanged extends RegisterEvent {
  final String confirmPassword;
  RegisterConfirmPasswordChanged(this.confirmPassword);
}

/// Event to update user type (GENERAL or PSYCHOLOGIST)
class RegisterUserTypeChanged extends RegisterEvent {
  final String userType; // "GENERAL" or "PSYCHOLOGIST"
  RegisterUserTypeChanged(this.userType);
}

/// Event to set OAuth temp token
class SetOAuthTempToken extends RegisterEvent {
  final String token;
  SetOAuthTempToken(this.token);
}

/// Event to register general user
class RegisterGeneralUserSubmitted extends RegisterEvent {
  final String firstName;
  final String lastName;
  final bool acceptsPrivacyPolicy;

  RegisterGeneralUserSubmitted({
    required this.firstName,
    required this.lastName,
    required this.acceptsPrivacyPolicy,
  });
}

/// Event to register psychologist
class RegisterPsychologistSubmitted extends RegisterEvent {
  final String firstName;
  final String lastName;
  final String professionalLicense;
  final int yearsOfExperience;
  final String collegiateRegion;
  final String university;
  final int graduationYear;
  final bool acceptsPrivacyPolicy;
  final String licenseDocumentUri;
  final String diplomaDocumentUri;
  final String dniDocumentUri;
  final String? specialties;
  final List<String>? certificationDocumentUris;

  RegisterPsychologistSubmitted({
    required this.firstName,
    required this.lastName,
    required this.professionalLicense,
    required this.yearsOfExperience,
    required this.collegiateRegion,
    required this.university,
    required this.graduationYear,
    required this.acceptsPrivacyPolicy,
    required this.licenseDocumentUri,
    required this.diplomaDocumentUri,
    required this.dniDocumentUri,
    this.specialties,
    this.certificationDocumentUris,
  });
}

/// Event to search universities
class SearchUniversities extends RegisterEvent {
  final String query;
  SearchUniversities(this.query);
}

/// Event to clear validation errors
class ClearValidationErrors extends RegisterEvent {}

/// Event to clear error message
class ClearRegisterError extends RegisterEvent {}
