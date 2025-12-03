import 'package:equatable/equatable.dart';
import '../../../domain/models/psychologist_profile.dart';

abstract class PsychologistProfileState extends Equatable {
  final PsychologistProfile? profile;

  const PsychologistProfileState({this.profile});

  @override
  List<Object?> get props => [profile];
}

class PsychologistProfileLoading extends PsychologistProfileState {
  const PsychologistProfileLoading({PsychologistProfile? profile})
      : super(profile: profile);
}

class PsychologistProfileSuccess extends PsychologistProfileState {
  const PsychologistProfileSuccess({required PsychologistProfile profile})
      : super(profile: profile);
}

class PsychologistProfileError extends PsychologistProfileState {
  final String message;

  const PsychologistProfileError({
    required this.message,
    PsychologistProfile? profile,
  }) : super(profile: profile);

  @override
  List<Object?> get props => [message, profile];
}
