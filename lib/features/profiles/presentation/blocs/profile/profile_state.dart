import 'package:equatable/equatable.dart';
import '../../../../auth/domain/models/user.dart';
import '../../../domain/models/assigned_psychologist.dart';

abstract class ProfileState extends Equatable {
  final User? user;
  final AssignedPsychologist? assignedPsychologist;
  final String? relationshipId;
  final PsychologistLoadState psychologistLoadState;

  const ProfileState({
    this.user,
    this.assignedPsychologist,
    this.relationshipId,
    this.psychologistLoadState = PsychologistLoadState.loading,
  });

  @override
  List<Object?> get props =>
      [user, assignedPsychologist, relationshipId, psychologistLoadState];
}

class ProfileLoading extends ProfileState {
  const ProfileLoading({
    super.user,
    super.assignedPsychologist,
    super.relationshipId,
    super.psychologistLoadState,
  });
}

class ProfileSuccess extends ProfileState {
  const ProfileSuccess({
    required User super.user,
    super.assignedPsychologist,
    super.relationshipId,
    super.psychologistLoadState,
  });
}

class ProfileUpdateSuccess extends ProfileState {
  const ProfileUpdateSuccess({
    required User super.user,
    super.assignedPsychologist,
    super.relationshipId,
    super.psychologistLoadState,
  });
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError({
    required this.message,
    super.user,
    super.assignedPsychologist,
    super.relationshipId,
    super.psychologistLoadState,
  });

  @override
  List<Object?> get props => [
        message,
        user,
        assignedPsychologist,
        relationshipId,
        psychologistLoadState
      ];
}

enum PsychologistLoadState {
  loading,
  success,
  noTherapist,
  error,
}
