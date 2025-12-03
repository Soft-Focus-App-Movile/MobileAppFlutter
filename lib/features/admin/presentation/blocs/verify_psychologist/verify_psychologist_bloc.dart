import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/admin_repository.dart';
import 'verify_psychologist_event.dart';
import 'verify_psychologist_state.dart';

class VerifyPsychologistBloc
    extends Bloc<VerifyPsychologistEvent, VerifyPsychologistState> {
  final AdminRepository _repository;

  String _notes = '';

  VerifyPsychologistBloc(this._repository)
      : super(const VerifyPsychologistInitial()) {
    on<LoadPsychologistDetail>(_onLoadPsychologistDetail);
    on<UpdateNotes>(_onUpdateNotes);
    on<ApprovePsychologist>(_onApprovePsychologist);
    on<RejectPsychologist>(_onRejectPsychologist);
    on<ClearError>(_onClearError);
    on<ResetVerificationSuccess>(_onResetVerificationSuccess);
  }

  Future<void> _onLoadPsychologistDetail(
    LoadPsychologistDetail event,
    Emitter<VerifyPsychologistState> emit,
  ) async {
    emit(const VerifyPsychologistLoading());

    try {
      final psychologist = await _repository.getPsychologistDetail(event.userId);
      emit(VerifyPsychologistLoaded(
        psychologist: psychologist,
        notes: _notes,
      ));
    } catch (e) {
      emit(VerifyPsychologistError(
        message: e.toString(),
        notes: _notes,
      ));
    }
  }

  void _onUpdateNotes(
    UpdateNotes event,
    Emitter<VerifyPsychologistState> emit,
  ) {
    _notes = event.notes;
    if (state is VerifyPsychologistLoaded) {
      final currentState = state as VerifyPsychologistLoaded;
      emit(currentState.copyWith(notes: _notes));
    }
  }

  Future<void> _onApprovePsychologist(
    ApprovePsychologist event,
    Emitter<VerifyPsychologistState> emit,
  ) async {
    if (state is VerifyPsychologistLoaded) {
      final currentState = state as VerifyPsychologistLoaded;
      emit(currentState.copyWith(isProcessing: true));

      try {
        await _repository.verifyPsychologist(
          userId: currentState.psychologist.id,
          isApproved: true,
          notes: _notes.isEmpty ? null : _notes,
        );
        emit(const VerifyPsychologistSuccess());
      } catch (e) {
        emit(VerifyPsychologistError(
          message: e.toString(),
          psychologist: currentState.psychologist,
          notes: _notes,
        ));
      }
    }
  }

  Future<void> _onRejectPsychologist(
    RejectPsychologist event,
    Emitter<VerifyPsychologistState> emit,
  ) async {
    if (state is VerifyPsychologistLoaded) {
      final currentState = state as VerifyPsychologistLoaded;
      emit(currentState.copyWith(isProcessing: true));

      try {
        await _repository.verifyPsychologist(
          userId: currentState.psychologist.id,
          isApproved: false,
          notes: _notes.isEmpty ? null : _notes,
        );
        emit(const VerifyPsychologistSuccess());
      } catch (e) {
        emit(VerifyPsychologistError(
          message: e.toString(),
          psychologist: currentState.psychologist,
          notes: _notes,
        ));
      }
    }
  }

  void _onClearError(
    ClearError event,
    Emitter<VerifyPsychologistState> emit,
  ) {
    if (state is VerifyPsychologistError) {
      final errorState = state as VerifyPsychologistError;
      if (errorState.psychologist != null) {
        emit(VerifyPsychologistLoaded(
          psychologist: errorState.psychologist!,
          notes: errorState.notes,
        ));
      } else {
        emit(const VerifyPsychologistInitial());
      }
    }
  }

  void _onResetVerificationSuccess(
    ResetVerificationSuccess event,
    Emitter<VerifyPsychologistState> emit,
  ) {
    emit(const VerifyPsychologistInitial());
  }
}
