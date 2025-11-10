/// Events for LoginBloc
abstract class LoginEvent {}

/// Event to update email field
class EmailChanged extends LoginEvent {
  final String email;
  EmailChanged(this.email);
}

/// Event to update password field
class PasswordChanged extends LoginEvent {
  final String password;
  PasswordChanged(this.password);
}

/// Event to submit login with email and password
class LoginSubmitted extends LoginEvent {}

/// Event to initiate Google Sign-In
class GoogleSignInRequested extends LoginEvent {
  final String serverClientId;
  GoogleSignInRequested(this.serverClientId);
}

/// Event to handle Google Sign-In result (after activity result)
class GoogleSignInResultReceived extends LoginEvent {
  final String idToken;
  GoogleSignInResultReceived(this.idToken);
}

/// Event to clear error message
class ClearErrorRequested extends LoginEvent {}

/// Event to clear OAuth data
class ClearOAuthDataRequested extends LoginEvent {}

/// Event to clear pending verification flag
class ClearPendingVerificationRequested extends LoginEvent {}

/// Event to set user from OAuth registration (auto-login)
class SetUserFromOAuthRegistration extends LoginEvent {
  final dynamic user; // User object
  SetUserFromOAuthRegistration(this.user);
}
