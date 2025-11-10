import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/models/user.dart';
import '../../../domain/models/user_type.dart';
import '../../../../../core/common/result.dart';
import 'login_event.dart';
import 'login_state.dart';

/// BLoC for managing login state and logic
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository repository;

  LoginBloc({required this.repository}) : super(const LoginInitial()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
    on<GoogleSignInResultReceived>(_onGoogleSignInResultReceived);
    on<ClearErrorRequested>(_onClearErrorRequested);
    on<ClearOAuthDataRequested>(_onClearOAuthDataRequested);
    on<ClearPendingVerificationRequested>(_onClearPendingVerificationRequested);
    on<SetUserFromOAuthRegistration>(_onSetUserFromOAuthRegistration);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(LoginFormUpdated(
      email: event.email,
      password: state.password,
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(LoginFormUpdated(
      email: state.email,
      password: event.password,
    ));
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading(
      email: state.email,
      password: state.password,
    ));

    final result = await repository.login(state.email, state.password);

    if (result is Success<User>) {
      emit(LoginSuccess(
        user: result.data,
        email: state.email,
        password: state.password,
      ));
    } else if (result is Error<User>) {
      final errorMsg = result.message;

      // Check if it's a psychologist pending verification error
      if (errorMsg.toLowerCase().contains('pending verification') ||
          errorMsg.toLowerCase().contains('wait for admin approval')) {
        emit(LoginPsychologistPendingVerification(
          email: state.email,
          password: state.password,
        ));
      } else {
        emit(LoginError(
          message: errorMsg,
          email: state.email,
          password: state.password,
        ));
      }
    }
  }

  Future<void> _onGoogleSignInRequested(
    GoogleSignInRequested event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(LoginLoading(
        email: state.email,
        password: state.password,
      ));

      // Initialize Google Sign-In
      final googleSignIn = GoogleSignIn(
        serverClientId: event.serverClientId,
        scopes: ['email', 'profile'],
      );

      // Sign out first to force account selection
      await googleSignIn.signOut();

      // Trigger sign-in flow
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled the sign-in
        emit(LoginFormUpdated(
          email: state.email,
          password: state.password,
        ));
        return;
      }

      // Get authentication details
      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        emit(LoginError(
          message: 'Error al obtener token de Google',
          email: state.email,
          password: state.password,
        ));
        return;
      }

      // Verify with backend and login
      await _verifyAndLoginWithGoogle(idToken, emit);
    } catch (e) {
      emit(LoginError(
        message: 'Error al iniciar sesión con Google: $e',
        email: state.email,
        password: state.password,
      ));
    }
  }

  Future<void> _onGoogleSignInResultReceived(
    GoogleSignInResultReceived event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading(
      email: state.email,
      password: state.password,
    ));

    await _verifyAndLoginWithGoogle(event.idToken, emit);
  }

  Future<void> _verifyAndLoginWithGoogle(
    String idToken,
    Emitter<LoginState> emit,
  ) async {
    final result = await repository.verifyOAuth('Google', idToken);

    if (result is Success<OAuthVerificationData>) {
      final verificationData = result.data;

      if (verificationData.needsRegistration) {
        // User needs to register - navigate to registration
        emit(LoginOAuthRegistrationRequired(
          oauthData: verificationData,
          email: state.email,
          password: state.password,
        ));
      } else {
        // User already exists - JWT token is in tempToken field
        try {
          final userId = _extractUserIdFromJwt(verificationData.tempToken);

          final user = User(
            id: userId,
            email: verificationData.email,
            fullName: verificationData.fullName,
            token: verificationData.tempToken,
            userType: _mapStringToUserType(verificationData.existingUserType ?? 'General'),
            isVerified: true, // Existing users are already verified
          );

          emit(LoginSuccess(
            user: user,
            email: state.email,
            password: state.password,
          ));
        } catch (e) {
          emit(LoginError(
            message: 'Error al procesar la autenticación',
            email: state.email,
            password: state.password,
          ));
        }
      }
    } else if (result is Error<OAuthVerificationData>) {
      final errorMsg = result.message;

      // Check if it's a psychologist pending verification error
      if (errorMsg.toLowerCase().contains('pending verification') ||
          errorMsg.toLowerCase().contains('wait for admin approval')) {
        emit(LoginPsychologistPendingVerification(
          email: state.email,
          password: state.password,
        ));
      } else {
        emit(LoginError(
          message: errorMsg,
          email: state.email,
          password: state.password,
        ));
      }
    }
  }

  /// Extracts the user ID from a JWT token by decoding the payload
  String _extractUserIdFromJwt(String token) {
    try {
      // JWT structure: header.payload.signature
      final parts = token.split('.');
      if (parts.length != 3) {
        throw Exception('Invalid JWT token format');
      }

      // Decode the payload (second part)
      final payload = parts[1];

      // Add padding if necessary for base64 decoding
      String normalizedPayload = payload;
      switch (payload.length % 4) {
        case 2:
          normalizedPayload += '==';
          break;
        case 3:
          normalizedPayload += '=';
          break;
      }

      final decodedBytes = base64Url.decode(normalizedPayload);
      final decodedString = utf8.decode(decodedBytes);

      // Parse JSON payload
      final jsonPayload = jsonDecode(decodedString);

      // Extract user ID from the "sub" claim (standard JWT claim for user ID)
      return jsonPayload['sub'] ?? jsonPayload['user_id'] ?? '';
    } catch (e) {
      print('Error extracting user ID from JWT: $e');
      rethrow;
    }
  }

  UserType _mapStringToUserType(String role) {
    switch (role.toUpperCase()) {
      case 'GENERAL':
        return UserType.GENERAL;
      case 'PSYCHOLOGIST':
        return UserType.PSYCHOLOGIST;
      case 'PATIENT':
        return UserType.PATIENT;
      case 'ADMIN':
        return UserType.ADMIN;
      default:
        return UserType.GENERAL;
    }
  }

  void _onClearErrorRequested(
    ClearErrorRequested event,
    Emitter<LoginState> emit,
  ) {
    emit(LoginFormUpdated(
      email: state.email,
      password: state.password,
    ));
  }

  void _onClearOAuthDataRequested(
    ClearOAuthDataRequested event,
    Emitter<LoginState> emit,
  ) {
    emit(LoginFormUpdated(
      email: state.email,
      password: state.password,
    ));
  }

  void _onClearPendingVerificationRequested(
    ClearPendingVerificationRequested event,
    Emitter<LoginState> emit,
  ) {
    emit(LoginFormUpdated(
      email: state.email,
      password: state.password,
    ));
  }

  void _onSetUserFromOAuthRegistration(
    SetUserFromOAuthRegistration event,
    Emitter<LoginState> emit,
  ) {
    emit(LoginSuccess(
      user: event.user,
      email: state.email,
      password: state.password,
    ));
  }
}
