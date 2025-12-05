import 'package:equatable/equatable.dart';
import '../../../domain/models/user.dart';
import '../../../domain/repositories/auth_repository.dart';

/// States for LoginBloc
abstract class LoginState extends Equatable {
  final String email;
  final String password;

  const LoginState({
    this.email = '',
    this.password = '',
  });

  @override
  List<Object?> get props => [email, password];
}

/// Initial idle state
class LoginInitial extends LoginState {
  const LoginInitial() : super();
}

/// Loading state while login request is in progress
class LoginLoading extends LoginState {
  const LoginLoading({
    required super.email,
    required super.password,
  });
}

/// Success state with authenticated user
class LoginSuccess extends LoginState {
  final User user;

  const LoginSuccess({
    required this.user,
    required super.email,
    required super.password,
  });

  @override
  List<Object?> get props => [user, email, password];
}

/// Error state with error message
class LoginError extends LoginState {
  final String message;

  const LoginError({
    required this.message,
    required super.email,
    required super.password,
  });

  @override
  List<Object?> get props => [message, email, password];
}

/// State when psychologist account is pending verification
class LoginPsychologistPendingVerification extends LoginState {
  const LoginPsychologistPendingVerification({
    required super.email,
    required super.password,
  });
}

/// State when OAuth verification indicates user needs to register
class LoginOAuthRegistrationRequired extends LoginState {
  final OAuthVerificationData oauthData;

  const LoginOAuthRegistrationRequired({
    required this.oauthData,
    required super.email,
    required super.password,
  });

  @override
  List<Object?> get props => [oauthData, email, password];
}

/// State with updated form fields (for reactive UI)
class LoginFormUpdated extends LoginState {
  const LoginFormUpdated({
    required super.email,
    required super.password,
  });
}
