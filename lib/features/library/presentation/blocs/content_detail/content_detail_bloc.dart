import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common/status.dart';
import '../../../data/services/assignments_service.dart';
import '../../../data/models/request/assignment_request_dto.dart';
import 'content_detail_event.dart';
import 'content_detail_state.dart';

class ContentDetailBloc extends Bloc<ContentDetailEvent, ContentDetailState> {
  final AssignmentsService _assignmentsService;

  ContentDetailBloc({
    required AssignmentsService assignmentsService,
  })  : _assignmentsService = assignmentsService,
        super(const ContentDetailState()) {
    on<LoadContentDetail>(_onLoadContentDetail);
    on<ToggleContentFavorite>(_onToggleContentFavorite);
    on<AssignContentToPatient>(_onAssignContentToPatient);
  }

  Future<void> _onLoadContentDetail(
    LoadContentDetail event,
    Emitter<ContentDetailState> emit,
  ) async {
    emit(state.copyWith(
      status: Status.success,
      content: event.content,
    ));
  }

  Future<void> _onToggleContentFavorite(
    ToggleContentFavorite event,
    Emitter<ContentDetailState> emit,
  ) async {
    emit(state.copyWith(isFavorite: !state.isFavorite));
  }

  Future<void> _onAssignContentToPatient(
    AssignContentToPatient event,
    Emitter<ContentDetailState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    try {
      if (state.content == null) {
        throw Exception('No content loaded');
      }

      final request = AssignmentRequestDto(
        patientIds: [event.patientId],
        contentId: state.content!.externalId,
        contentType: state.content!.type,
        notes: event.notes,
      );

      await _assignmentsService.assignContent(request);

      emit(state.copyWith(
        status: Status.success,
        message: 'Content assigned successfully',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.failure,
        message: e.toString(),
      ));
    }
  }
}
