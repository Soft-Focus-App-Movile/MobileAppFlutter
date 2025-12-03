import 'package:equatable/equatable.dart';
import '../../../domain/models/psychologist_detail.dart';

abstract class VerifyPsychologistState extends Equatable {
  const VerifyPsychologistState();

  @override
  List<Object?> get props => [];
}

class VerifyPsychologistInitial extends VerifyPsychologistState {
  const VerifyPsychologistInitial();
}

class VerifyPsychologistLoading extends VerifyPsychologistState {
  const VerifyPsychologistLoading();
}

class VerifyPsychologistLoaded extends VerifyPsychologistState {
  final PsychologistDetail psychologist;
  final String notes;
  final bool isProcessing;

  const VerifyPsychologistLoaded({
    required this.psychologist,
    this.notes = '',
    this.isProcessing = false,
  });

  VerifyPsychologistLoaded copyWith({
    PsychologistDetail? psychologist,
    String? notes,
    bool? isProcessing,
  }) {
    return VerifyPsychologistLoaded(
      psychologist: psychologist ?? this.psychologist,
      notes: notes ?? this.notes,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }

  @override
  List<Object?> get props => [psychologist, notes, isProcessing];
}

class VerifyPsychologistError extends VerifyPsychologistState {
  final String message;
  final PsychologistDetail? psychologist;
  final String notes;

  const VerifyPsychologistError({
    required this.message,
    this.psychologist,
    this.notes = '',
  });

  @override
  List<Object?> get props => [message, psychologist, notes];
}

class VerifyPsychologistSuccess extends VerifyPsychologistState {
  const VerifyPsychologistSuccess();
}
