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

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<PsychologistProfileState> emit,
  ) async {
    await userSession.clear();
  }
}
