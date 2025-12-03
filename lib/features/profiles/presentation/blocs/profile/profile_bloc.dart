import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common/result.dart';
import '../../../../auth/data/local/user_session.dart';
import '../../../../therapy/domain/repositories/therapy_repository.dart';
import '../../../domain/repositories/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;
  final TherapyRepository therapyRepository;
  final UserSession userSession;

  ProfileBloc({
    required this.profileRepository,
    required this.therapyRepository,
    required this.userSession,
  }) : super(const ProfileLoading()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
    on<UpdateProfessionalProfile>(_onUpdateProfessionalProfile);
    on<DisconnectPsychologist>(_onDisconnectPsychologist);
  }

  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading(
      user: state.user,
      assignedPsychologist: state.assignedPsychologist,
      relationshipId: state.relationshipId,
      psychologistLoadState: state.psychologistLoadState,
    ));

    final cachedUser = await userSession.getUser();
    if (cachedUser == null) {
      emit(const ProfileError(
        message: 'Sesión expirada. Por favor, inicia sesión nuevamente.',
      ));
      return;
    }

    if (cachedUser.token == null || cachedUser.token!.isEmpty) {
      emit(ProfileError(
        message: 'Token no válido. Por favor, inicia sesión nuevamente.',
        user: cachedUser,
      ));
      return;
    }

    try {
      final user = await profileRepository.getProfile();
      emit(ProfileSuccess(
        user: user,
        assignedPsychologist: state.assignedPsychologist,
        relationshipId: state.relationshipId,
        psychologistLoadState: PsychologistLoadState.loading,
      ));

      await _loadAssignedPsychologist(emit, user);
    } catch (e) {
      emit(ProfileError(
        message: e.toString(),
        user: cachedUser,
      ));
    }
  }

  Future<void> _loadAssignedPsychologist(
    Emitter<ProfileState> emit,
    dynamic user,
  ) async {
    final relationshipResult = await therapyRepository.getMyRelationship();

    if (relationshipResult is Success) {
      final relationship = (relationshipResult as Success).data;

      if (relationship != null && relationship.isActive) {
        final relationshipId = relationship.id;

        try {
          final psychologist =
              await profileRepository.getAssignedPsychologist();

          if (psychologist != null) {
            emit(ProfileSuccess(
              user: user,
              assignedPsychologist: psychologist,
              relationshipId: relationshipId,
              psychologistLoadState: PsychologistLoadState.success,
            ));
          } else {
            emit(ProfileSuccess(
              user: user,
              assignedPsychologist: null,
              relationshipId: null,
              psychologistLoadState: PsychologistLoadState.noTherapist,
            ));
          }
        } catch (e) {
          emit(ProfileSuccess(
            user: user,
            assignedPsychologist: null,
            relationshipId: relationshipId,
            psychologistLoadState: PsychologistLoadState.error,
          ));
        }
      } else {
        emit(ProfileSuccess(
          user: user,
          assignedPsychologist: null,
          relationshipId: null,
          psychologistLoadState: PsychologistLoadState.noTherapist,
        ));
      }
    } else {
      emit(ProfileSuccess(
        user: user,
        assignedPsychologist: null,
        relationshipId: null,
        psychologistLoadState: PsychologistLoadState.error,
      ));
    }
  }

  Future<void> _onUpdateProfile(
    UpdateProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading(
      user: state.user,
      assignedPsychologist: state.assignedPsychologist,
      relationshipId: state.relationshipId,
      psychologistLoadState: state.psychologistLoadState,
    ));

    try {
      final user = await profileRepository.updateProfile(
        firstName: event.firstName,
        lastName: event.lastName,
        dateOfBirth: event.dateOfBirth,
        gender: event.gender,
        phone: event.phone,
        bio: event.bio,
        country: event.country,
        city: event.city,
        interests: event.interests,
        mentalHealthGoals: event.mentalHealthGoals,
        emailNotifications: event.emailNotifications,
        pushNotifications: event.pushNotifications,
        isProfilePublic: event.isProfilePublic,
        profileImageFile: event.profileImageFile,
      );

      emit(ProfileUpdateSuccess(
        user: user,
        assignedPsychologist: state.assignedPsychologist,
        relationshipId: state.relationshipId,
        psychologistLoadState: state.psychologistLoadState,
      ));
    } catch (e) {
      emit(ProfileError(
        message: e.toString(),
        user: state.user,
        assignedPsychologist: state.assignedPsychologist,
        relationshipId: state.relationshipId,
        psychologistLoadState: state.psychologistLoadState,
      ));
    }
  }

  Future<void> _onUpdateProfessionalProfile(
    UpdateProfessionalProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading(
      user: state.user,
      assignedPsychologist: state.assignedPsychologist,
      relationshipId: state.relationshipId,
      psychologistLoadState: state.psychologistLoadState,
    ));

    try {
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

      add(LoadProfile());
    } catch (e) {
      emit(ProfileError(
        message: e.toString(),
        user: state.user,
        assignedPsychologist: state.assignedPsychologist,
        relationshipId: state.relationshipId,
        psychologistLoadState: state.psychologistLoadState,
      ));
    }
  }

  Future<void> _onDisconnectPsychologist(
    DisconnectPsychologist event,
    Emitter<ProfileState> emit,
  ) async {
    final currentRelationshipId = state.relationshipId;
    if (currentRelationshipId == null) {
      emit(ProfileError(
        message: 'No hay una relación terapéutica activa',
        user: state.user,
        assignedPsychologist: state.assignedPsychologist,
        relationshipId: state.relationshipId,
        psychologistLoadState: state.psychologistLoadState,
      ));
      return;
    }

    emit(ProfileLoading(
      user: state.user,
      assignedPsychologist: state.assignedPsychologist,
      relationshipId: state.relationshipId,
      psychologistLoadState: state.psychologistLoadState,
    ));

    emit(ProfileSuccess(
      user: state.user!,
      assignedPsychologist: null,
      relationshipId: null,
      psychologistLoadState: PsychologistLoadState.noTherapist,
    ));

    event.onSuccess();
  }
}
