import 'package:equatable/equatable.dart';
import '../../../domain/models/user.dart';
import '../../../domain/repositories/auth_repository.dart';

/// States for RegisterBloc
abstract class RegisterState extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;
  final String? userType; // "GENERAL" or "PSYCHOLOGIST"
  final String? oauthTempToken;

  // Validation errors
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;

  // University suggestions (for psychologist registration)
  final List<dynamic>? universitySuggestions;

  const RegisterState({
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.userType = 'GENERAL',
    this.oauthTempToken,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
    this.universitySuggestions,
  });

  @override
  List<Object?> get props => [
        email,
        password,
        confirmPassword,
        userType,
        oauthTempToken,
        emailError,
        passwordError,
        confirmPasswordError,
        universitySuggestions,
      ];
}

/// Initial idle state
class RegisterInitial extends RegisterState {
  const RegisterInitial() : super();
}

/// Loading state while registration request is in progress
class RegisterLoading extends RegisterState {
  const RegisterLoading({
    required super.email,
    required super.password,
    required super.confirmPassword,
    super.userType = null,
    super.oauthTempToken,
    super.emailError,
    super.passwordError,
    super.confirmPasswordError,
    super.universitySuggestions,
  });
}

/// Success state for regular registration (needs login after)
class RegisterSuccessRegular extends RegisterState {
  final RegisterResult result;

  const RegisterSuccessRegular({
    required this.result,
    required super.email,
    required super.password,
    required super.confirmPassword,
    super.userType = null,
    super.oauthTempToken,
    super.emailError,
    super.passwordError,
    super.confirmPasswordError,
    super.universitySuggestions,
  });

  @override
  List<Object?> get props => [
        result,
        email,
        password,
        confirmPassword,
        userType,
        oauthTempToken,
        emailError,
        passwordError,
        confirmPasswordError,
        universitySuggestions,
      ];
}

/// Success state for OAuth registration (auto-login with User+JWT)
class RegisterSuccessOAuth extends RegisterState {
  final User user;

  const RegisterSuccessOAuth({
    required this.user,
    required super.email,
    required super.password,
    required super.confirmPassword,
    super.userType = null,
    super.oauthTempToken,
    super.emailError,
    super.passwordError,
    super.confirmPasswordError,
    super.universitySuggestions,
  });

  @override
  List<Object?> get props => [
        user,
        email,
        password,
        confirmPassword,
        userType,
        oauthTempToken,
        emailError,
        passwordError,
        confirmPasswordError,
        universitySuggestions,
      ];
}

/// State when psychologist registration is pending verification
class RegisterPsychologistPendingVerification extends RegisterState {
  const RegisterPsychologistPendingVerification({
    required super.email,
    required super.password,
    required super.confirmPassword,
    super.userType = null,
    super.oauthTempToken,
    super.emailError,
    super.passwordError,
    super.confirmPasswordError,
    super.universitySuggestions,
  });
}

/// Error state with error message
class RegisterError extends RegisterState {
  final String message;

  const RegisterError({
    required this.message,
    required super.email,
    required super.password,
    required super.confirmPassword,
    super.userType = null,
    super.oauthTempToken,
    super.emailError,
    super.passwordError,
    super.confirmPasswordError,
    super.universitySuggestions,
  });

  @override
  List<Object?> get props => [
        message,
        email,
        password,
        confirmPassword,
        userType,
        oauthTempToken,
        emailError,
        passwordError,
        confirmPasswordError,
        universitySuggestions,
      ];
}

/// State with updated form fields (for reactive UI)
class RegisterFormUpdated extends RegisterState {
  const RegisterFormUpdated({
    required super.email,
    required super.password,
    required super.confirmPassword,
    super.userType = null,
    super.oauthTempToken,
    super.emailError,
    super.passwordError,
    super.confirmPasswordError,
    super.universitySuggestions,
  });
}
