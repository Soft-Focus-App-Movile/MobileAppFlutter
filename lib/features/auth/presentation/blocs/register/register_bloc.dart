import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/models/user.dart';
import '../../../../../core/common/result.dart';
import '../../../../../core/data/repositories/university_repository.dart';
import 'register_event.dart';
import 'register_state.dart';

/// BLoC for managing registration state and logic
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository repository;
  final UniversityRepository universityRepository;

  RegisterBloc({
    required this.repository,
    UniversityRepository? universityRepository,
  })  : universityRepository = universityRepository ?? UniversityRepository(),
        super(const RegisterInitial()) {
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<RegisterUserTypeChanged>(_onUserTypeChanged);
    on<SetOAuthTempToken>(_onSetOAuthTempToken);
    on<RegisterGeneralUserSubmitted>(_onRegisterGeneralUserSubmitted);
    on<RegisterPsychologistSubmitted>(_onRegisterPsychologistSubmitted);
    on<SearchUniversities>(_onSearchUniversities);
    on<ClearValidationErrors>(_onClearValidationErrors);
    on<ClearRegisterError>(_onClearRegisterError);
  }

  void _onEmailChanged(RegisterEmailChanged event, Emitter<RegisterState> emit) {
    final emailError = _validateEmail(event.email);
    emit(RegisterFormUpdated(
      email: event.email,
      password: state.password,
      confirmPassword: state.confirmPassword,
      userType: state.userType,
      oauthTempToken: state.oauthTempToken,
      emailError: emailError,
      passwordError: state.passwordError,
      confirmPasswordError: state.confirmPasswordError,
      universitySuggestions: state.universitySuggestions,
    ));
  }

  void _onPasswordChanged(RegisterPasswordChanged event, Emitter<RegisterState> emit) {
    final passwordError = _validatePassword(event.password);
    final confirmPasswordError = state.confirmPassword.isNotEmpty
        ? _validateConfirmPassword(state.confirmPassword, event.password)
        : null;

    emit(RegisterFormUpdated(
      email: state.email,
      password: event.password,
      confirmPassword: state.confirmPassword,
      userType: state.userType,
      oauthTempToken: state.oauthTempToken,
      emailError: state.emailError,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
      universitySuggestions: state.universitySuggestions,
    ));
  }

  void _onConfirmPasswordChanged(
    RegisterConfirmPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final confirmPasswordError = _validateConfirmPassword(event.confirmPassword, state.password);

    emit(RegisterFormUpdated(
      email: state.email,
      password: state.password,
      confirmPassword: event.confirmPassword,
      userType: state.userType,
      oauthTempToken: state.oauthTempToken,
      emailError: state.emailError,
      passwordError: state.passwordError,
      confirmPasswordError: confirmPasswordError,
      universitySuggestions: state.universitySuggestions,
    ));
  }

  void _onUserTypeChanged(RegisterUserTypeChanged event, Emitter<RegisterState> emit) {
    emit(RegisterFormUpdated(
      email: state.email,
      password: state.password,
      confirmPassword: state.confirmPassword,
      userType: event.userType,
      oauthTempToken: state.oauthTempToken,
      emailError: state.emailError,
      passwordError: state.passwordError,
      confirmPasswordError: state.confirmPasswordError,
      universitySuggestions: state.universitySuggestions,
    ));
  }

  void _onSetOAuthTempToken(SetOAuthTempToken event, Emitter<RegisterState> emit) {
    emit(RegisterFormUpdated(
      email: state.email,
      password: state.password,
      confirmPassword: state.confirmPassword,
      userType: state.userType,
      oauthTempToken: event.token,
      emailError: state.emailError,
      passwordError: state.passwordError,
      confirmPasswordError: state.confirmPasswordError,
      universitySuggestions: state.universitySuggestions,
    ));
  }

  Future<void> _onRegisterGeneralUserSubmitted(
    RegisterGeneralUserSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading(
      email: state.email,
      password: state.password,
      confirmPassword: state.confirmPassword,
      userType: state.userType,
      oauthTempToken: state.oauthTempToken,
      emailError: state.emailError,
      passwordError: state.passwordError,
      confirmPasswordError: state.confirmPasswordError,
      universitySuggestions: state.universitySuggestions,
    ));

    final tempToken = state.oauthTempToken;

    if (tempToken != null) {
      // OAuth registration - no password required, returns User with JWT (auto-login)
      await _registerGeneralUserOAuth(
        tempToken: tempToken,
        acceptsPrivacyPolicy: event.acceptsPrivacyPolicy,
        emit: emit,
      );
    } else {
      // Regular registration - requires password, returns userId+email (needs login after)
      await _registerGeneralUserRegular(
        firstName: event.firstName,
        lastName: event.lastName,
        email: state.email,
        password: state.password,
        acceptsPrivacyPolicy: event.acceptsPrivacyPolicy,
        emit: emit,
      );
    }
  }

  Future<void> _registerGeneralUserRegular({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required bool acceptsPrivacyPolicy,
    required Emitter<RegisterState> emit,
  }) async {
    final result = await repository.registerGeneralUser(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      acceptsPrivacyPolicy: acceptsPrivacyPolicy,
    );

    if (result is Success<RegisterResult>) {
      emit(RegisterSuccessRegular(
        result: result.data,
        email: state.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
        userType: state.userType,
        oauthTempToken: state.oauthTempToken,
        emailError: state.emailError,
        passwordError: state.passwordError,
        confirmPasswordError: state.confirmPasswordError,
        universitySuggestions: state.universitySuggestions,
      ));
    } else if (result is Error<RegisterResult>) {
      emit(RegisterError(
        message: result.message,
        email: state.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
        userType: state.userType,
        oauthTempToken: state.oauthTempToken,
        emailError: state.emailError,
        passwordError: state.passwordError,
        confirmPasswordError: state.confirmPasswordError,
        universitySuggestions: state.universitySuggestions,
      ));
    }
  }

  Future<void> _registerGeneralUserOAuth({
    required String tempToken,
    required bool acceptsPrivacyPolicy,
    required Emitter<RegisterState> emit,
  }) async {
    final result = await repository.completeOAuthRegistrationGeneral(
      tempToken: tempToken,
      acceptsPrivacyPolicy: acceptsPrivacyPolicy,
    );

    if (result is Success<User>) {
      emit(RegisterSuccessOAuth(
        user: result.data,
        email: state.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
        userType: state.userType,
        oauthTempToken: state.oauthTempToken,
        emailError: state.emailError,
        passwordError: state.passwordError,
        confirmPasswordError: state.confirmPasswordError,
        universitySuggestions: state.universitySuggestions,
      ));
    } else if (result is Error<User>) {
      emit(RegisterError(
        message: result.message,
        email: state.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
        userType: state.userType,
        oauthTempToken: state.oauthTempToken,
        emailError: state.emailError,
        passwordError: state.passwordError,
        confirmPasswordError: state.confirmPasswordError,
        universitySuggestions: state.universitySuggestions,
      ));
    }
  }

  Future<void> _onRegisterPsychologistSubmitted(
    RegisterPsychologistSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading(
      email: state.email,
      password: state.password,
      confirmPassword: state.confirmPassword,
      userType: state.userType,
      oauthTempToken: state.oauthTempToken,
      emailError: state.emailError,
      passwordError: state.passwordError,
      confirmPasswordError: state.confirmPasswordError,
      universitySuggestions: state.universitySuggestions,
    ));

    final tempToken = state.oauthTempToken;

    if (tempToken != null) {
      // OAuth psychologist registration
      await _registerPsychologistOAuth(
        tempToken: tempToken,
        firstName: event.firstName,
        lastName: event.lastName,
        professionalLicense: event.professionalLicense,
        yearsOfExperience: event.yearsOfExperience,
        collegiateRegion: event.collegiateRegion,
        university: event.university,
        graduationYear: event.graduationYear,
        acceptsPrivacyPolicy: event.acceptsPrivacyPolicy,
        licenseDocumentUri: event.licenseDocumentUri,
        diplomaDocumentUri: event.diplomaDocumentUri,
        dniDocumentUri: event.dniDocumentUri,
        specialties: event.specialties,
        certificationDocumentUris: event.certificationDocumentUris,
        emit: emit,
      );
    } else {
      // Regular psychologist registration
      await _registerPsychologistRegular(
        firstName: event.firstName,
        lastName: event.lastName,
        email: state.email,
        password: state.password,
        professionalLicense: event.professionalLicense,
        yearsOfExperience: event.yearsOfExperience,
        collegiateRegion: event.collegiateRegion,
        university: event.university,
        graduationYear: event.graduationYear,
        acceptsPrivacyPolicy: event.acceptsPrivacyPolicy,
        licenseDocumentUri: event.licenseDocumentUri,
        diplomaDocumentUri: event.diplomaDocumentUri,
        dniDocumentUri: event.dniDocumentUri,
        specialties: event.specialties,
        certificationDocumentUris: event.certificationDocumentUris,
        emit: emit,
      );
    }
  }

  Future<void> _registerPsychologistRegular({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String professionalLicense,
    required int yearsOfExperience,
    required String collegiateRegion,
    required String university,
    required int graduationYear,
    required bool acceptsPrivacyPolicy,
    required String licenseDocumentUri,
    required String diplomaDocumentUri,
    required String dniDocumentUri,
    String? specialties,
    List<String>? certificationDocumentUris,
    required Emitter<RegisterState> emit,
  }) async {
    final result = await repository.registerPsychologist(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      professionalLicense: professionalLicense,
      yearsOfExperience: yearsOfExperience,
      collegiateRegion: collegiateRegion,
      university: university,
      graduationYear: graduationYear,
      acceptsPrivacyPolicy: acceptsPrivacyPolicy,
      licenseDocumentUri: licenseDocumentUri,
      diplomaDocumentUri: diplomaDocumentUri,
      dniDocumentUri: dniDocumentUri,
      specialties: specialties,
      certificationDocumentUris: certificationDocumentUris,
    );

    if (result is Success<RegisterResult>) {
      // Psychologist registered but pending verification
      emit(RegisterPsychologistPendingVerification(
        email: state.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
        userType: state.userType,
        oauthTempToken: state.oauthTempToken,
        emailError: state.emailError,
        passwordError: state.passwordError,
        confirmPasswordError: state.confirmPasswordError,
        universitySuggestions: state.universitySuggestions,
      ));
    } else if (result is Error<RegisterResult>) {
      emit(RegisterError(
        message: result.message,
        email: state.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
        userType: state.userType,
        oauthTempToken: state.oauthTempToken,
        emailError: state.emailError,
        passwordError: state.passwordError,
        confirmPasswordError: state.confirmPasswordError,
        universitySuggestions: state.universitySuggestions,
      ));
    }
  }

  Future<void> _registerPsychologistOAuth({
    required String tempToken,
    required String firstName,
    required String lastName,
    required String professionalLicense,
    required int yearsOfExperience,
    required String collegiateRegion,
    required String university,
    required int graduationYear,
    required bool acceptsPrivacyPolicy,
    required String licenseDocumentUri,
    required String diplomaDocumentUri,
    required String dniDocumentUri,
    String? specialties,
    List<String>? certificationDocumentUris,
    required Emitter<RegisterState> emit,
  }) async {
    final result = await repository.completeOAuthRegistrationPsychologist(
      tempToken: tempToken,
      professionalLicense: professionalLicense,
      yearsOfExperience: yearsOfExperience,
      collegiateRegion: collegiateRegion,
      university: university,
      graduationYear: graduationYear,
      acceptsPrivacyPolicy: acceptsPrivacyPolicy,
      licenseDocumentUri: licenseDocumentUri,
      diplomaDocumentUri: diplomaDocumentUri,
      dniDocumentUri: dniDocumentUri,
      specialties: specialties,
      certificationDocumentUris: certificationDocumentUris,
    );

    if (result is Success<User>) {
      // OAuth psychologist registered but pending verification (returns User+JWT but isVerified=false)
      emit(RegisterPsychologistPendingVerification(
        email: state.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
        userType: state.userType,
        oauthTempToken: state.oauthTempToken,
        emailError: state.emailError,
        passwordError: state.passwordError,
        confirmPasswordError: state.confirmPasswordError,
        universitySuggestions: state.universitySuggestions,
      ));
    } else if (result is Error<User>) {
      emit(RegisterError(
        message: result.message,
        email: state.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
        userType: state.userType,
        oauthTempToken: state.oauthTempToken,
        emailError: state.emailError,
        passwordError: state.passwordError,
        confirmPasswordError: state.confirmPasswordError,
        universitySuggestions: state.universitySuggestions,
      ));
    }
  }

  Future<void> _onSearchUniversities(
    SearchUniversities event,
    Emitter<RegisterState> emit,
  ) async {
    try {
      final universities = await universityRepository.searchUniversities(event.query);

      // Convert UniversityInfo to Map for compatibility with state
      final suggestions = universities.map((uni) => {
        'name': uni.name,
        'region': uni.region,
      }).toList();

      emit(RegisterFormUpdated(
        email: state.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
        userType: state.userType,
        oauthTempToken: state.oauthTempToken,
        emailError: state.emailError,
        passwordError: state.passwordError,
        confirmPasswordError: state.confirmPasswordError,
        universitySuggestions: suggestions,
      ));
    } catch (e) {
      // On error, just return empty list
      emit(RegisterFormUpdated(
        email: state.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
        userType: state.userType,
        oauthTempToken: state.oauthTempToken,
        emailError: state.emailError,
        passwordError: state.passwordError,
        confirmPasswordError: state.confirmPasswordError,
        universitySuggestions: [],
      ));
    }
  }

  void _onClearValidationErrors(ClearValidationErrors event, Emitter<RegisterState> emit) {
    emit(RegisterFormUpdated(
      email: state.email,
      password: state.password,
      confirmPassword: state.confirmPassword,
      userType: state.userType,
      oauthTempToken: state.oauthTempToken,
      emailError: null,
      passwordError: null,
      confirmPasswordError: null,
      universitySuggestions: state.universitySuggestions,
    ));
  }

  void _onClearRegisterError(ClearRegisterError event, Emitter<RegisterState> emit) {
    emit(RegisterFormUpdated(
      email: state.email,
      password: state.password,
      confirmPassword: state.confirmPassword,
      userType: state.userType,
      oauthTempToken: state.oauthTempToken,
      emailError: state.emailError,
      passwordError: state.passwordError,
      confirmPasswordError: state.confirmPasswordError,
      universitySuggestions: state.universitySuggestions,
    ));
  }

  // Validation methods
  String? _validateEmail(String email) {
    if (email.isEmpty) return null; // Don't show error for empty field
    if (!email.contains('@')) return 'El email debe contener @';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) return 'Email inválido';
    if (email.length > 100) return 'El email no puede exceder 100 caracteres';
    return null;
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) return null; // Don't show error for empty field
    if (password.length < 6) return 'La contraseña debe tener al menos 6 caracteres';
    if (password.length > 100) return 'La contraseña no puede exceder 100 caracteres';
    if (!password.contains(RegExp(r'[A-Z]'))) return 'Debe contener al menos una mayúscula';
    if (!password.contains(RegExp(r'[a-z]'))) return 'Debe contener al menos una minúscula';
    if (!password.contains(RegExp(r'[0-9]'))) return 'Debe contener al menos un número';
    if (!password.contains(RegExp(r'[@$!%*?&]'))) {
      return 'Debe contener al menos un carácter especial (@\$!%*?&)';
    }
    return null;
  }

  String? _validateConfirmPassword(String confirmPassword, String password) {
    if (confirmPassword.isEmpty) return null; // Don't show error for empty field
    if (confirmPassword != password) return 'Las contraseñas no coinciden';
    return null;
  }
}
