import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../auth/data/local/user_session.dart';
import '../../../domain/repositories/profile_repository.dart';
import 'psychologist_profile_event.dart';
import 'psychologist_profile_state.dart';

class PsychologistProfileBloc
    extends Bloc<PsychologistProfileEvent, PsychologistProfileState> {
  final ProfileRepository profileRepository;
  final UserSession userSession;

  PsychologistProfileBloc({
    required this.profileRepository,
    required this.userSession,
  }) : super(const PsychologistProfileLoading()) {
    on<LoadPsychologistProfile>(_onLoadPsychologistProfile);
    on<UpdatePsychologistProfile>(_onUpdatePsychologistProfile);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoadPsychologistProfile(
    LoadPsychologistProfile event,
    Emitter<PsychologistProfileState> emit,
  ) async {
    emit(PsychologistProfileLoading(profile: state.profile));

    try {
      final profile = await profileRepository.getPsychologistCompleteProfile();
      emit(PsychologistProfileSuccess(profile: profile));
    } catch (e) {
      emit(PsychologistProfileError(
        message: e.toString(),
        profile: state.profile,
      ));
    }
  }

  Future<void> _onUpdatePsychologistProfile(
    UpdatePsychologistProfile event,
    Emitter<PsychologistProfileState> emit,
  ) async {
    emit(PsychologistProfileLoading(profile: state.profile));

    try {
      // Determinar si hay cambios personales
      final hasPersonalChanges = event.firstName != null ||
          event.lastName != null ||
          event.dateOfBirth != null;

      // Determinar si hay cambios profesionales
      final hasProfessionalChanges = event.professionalBio != null ||
          event.businessName != null ||
          event.businessAddress != null ||
          event.bankAccount != null ||
          event.paymentMethods != null ||
          event.maxPatientsCapacity != null ||
          event.languages != null ||
          event.targetAudience != null ||
          event.isAcceptingNewPatients != null ||
          event.isProfileVisibleInDirectory != null ||
          event.allowsDirectMessages != null;

      // Actualizar información personal si hay cambios
      if (hasPersonalChanges) {
        await profileRepository.updateProfile(
          firstName: event.firstName,
          lastName: event.lastName,
          dateOfBirth: event.dateOfBirth,
        );
      }

      // Actualizar información profesional si hay cambios
      if (hasProfessionalChanges) {
        await profileRepository.updateProfessionalProfile(
          professionalBio: event.professionalBio,
          isAcceptingNewPatients: event.isAcceptingNewPatients,
          maxPatientsCapacity: event.maxPatientsCapacity,
          targetAudience: event.targetAudience,
          languages: event.languages,
          businessName: event.businessName,
          businessAddress: event.businessAddress,
          bankAccount: event.bankAccount,
          paymentMethods: event.paymentMethods,
          isProfileVisibleInDirectory: event.isProfileVisibleInDirectory,
          allowsDirectMessages: event.allowsDirectMessages,
        );
      }

      // Recargar el perfil después de actualizar
      final profile = await profileRepository.getPsychologistCompleteProfile();
      emit(PsychologistProfileSuccess(profile: profile));
    } catch (e) {
      emit(PsychologistProfileError(
        message: e.toString(),
        profile: state.profile,
      ));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<PsychologistProfileState> emit,
  ) async {
    await userSession.clear();
  }
}
