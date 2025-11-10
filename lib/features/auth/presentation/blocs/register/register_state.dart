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
    required String email,
    required String password,
    required String confirmPassword,
    String? userType,
    String? oauthTempToken,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    List<dynamic>? universitySuggestions,
  }) : super(
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          userType: userType,
          oauthTempToken: oauthTempToken,
          emailError: emailError,
          passwordError: passwordError,
          confirmPasswordError: confirmPasswordError,
          universitySuggestions: universitySuggestions,
        );
}

/// Success state for regular registration (needs login after)
class RegisterSuccessRegular extends RegisterState {
  final RegisterResult result;

  const RegisterSuccessRegular({
    required this.result,
    required String email,
    required String password,
    required String confirmPassword,
    String? userType,
    String? oauthTempToken,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    List<dynamic>? universitySuggestions,
  }) : super(
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          userType: userType,
          oauthTempToken: oauthTempToken,
          emailError: emailError,
          passwordError: passwordError,
          confirmPasswordError: confirmPasswordError,
          universitySuggestions: universitySuggestions,
        );

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
    required String email,
    required String password,
    required String confirmPassword,
    String? userType,
    String? oauthTempToken,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    List<dynamic>? universitySuggestions,
  }) : super(
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          userType: userType,
          oauthTempToken: oauthTempToken,
          emailError: emailError,
          passwordError: passwordError,
          confirmPasswordError: confirmPasswordError,
          universitySuggestions: universitySuggestions,
        );

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
    required String email,
    required String password,
    required String confirmPassword,
    String? userType,
    String? oauthTempToken,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    List<dynamic>? universitySuggestions,
  }) : super(
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          userType: userType,
          oauthTempToken: oauthTempToken,
          emailError: emailError,
          passwordError: passwordError,
          confirmPasswordError: confirmPasswordError,
          universitySuggestions: universitySuggestions,
        );
}

/// Error state with error message
class RegisterError extends RegisterState {
  final String message;

  const RegisterError({
    required this.message,
    required String email,
    required String password,
    required String confirmPassword,
    String? userType,
    String? oauthTempToken,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    List<dynamic>? universitySuggestions,
  }) : super(
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          userType: userType,
          oauthTempToken: oauthTempToken,
          emailError: emailError,
          passwordError: passwordError,
          confirmPasswordError: confirmPasswordError,
          universitySuggestions: universitySuggestions,
        );

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
    required String email,
    required String password,
    required String confirmPassword,
    String? userType,
    String? oauthTempToken,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    List<dynamic>? universitySuggestions,
  }) : super(
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          userType: userType,
          oauthTempToken: oauthTempToken,
          emailError: emailError,
          passwordError: passwordError,
          confirmPasswordError: confirmPasswordError,
          universitySuggestions: universitySuggestions,
        );
}
