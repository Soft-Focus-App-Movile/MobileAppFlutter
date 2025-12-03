import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common/status.dart';
import '../../../data/services/assignments_service.dart';
import '../../../data/mappers/content_mapper.dart';
import 'assignments_event.dart';
import 'assignments_state.dart';

class AssignmentsBloc extends Bloc<AssignmentsEvent, AssignmentsState> {
  final AssignmentsService _assignmentsService;

  AssignmentsBloc({
    required AssignmentsService assignmentsService,
  })  : _assignmentsService = assignmentsService,
        super(const AssignmentsState()) {
    on<LoadAssignments>(_onLoadAssignments);
    on<CompleteAssignment>(_onCompleteAssignment);
  }

  Future<void> _onLoadAssignments(
    LoadAssignments event,
    Emitter<AssignmentsState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    try {
      final response = await _assignmentsService.getAssignedContent();

      final assignments = response.assignments
          .map((dto) => ContentMapper.fromAssignmentDto(dto))
          .toList();

      emit(state.copyWith(
        status: Status.success,
        assignments: assignments,
        totalAssignments: response.total,
        completedCount: response.completed,
        pendingCount: response.pending,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onCompleteAssignment(
    CompleteAssignment event,
    Emitter<AssignmentsState> emit,
  ) async {
    try {
      await _assignmentsService.completeAssignment(event.assignmentId);

      final updatedAssignments = state.assignments.map((assignment) {
        if (assignment.id == event.assignmentId) {
          return Assignment(
            id: assignment.id,
            content: assignment.content,
            psychologistId: assignment.psychologistId,
            notes: assignment.notes,
            assignedDate: assignment.assignedDate,
            isCompleted: true,
            completedDate: DateTime.now(),
          );
        }
        return assignment;
      }).toList() as List<Assignment>;

      emit(state.copyWith(
        assignments: updatedAssignments,
        completedCount: state.completedCount + 1,
        pendingCount: state.pendingCount - 1,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.failure,
        message: e.toString(),
      ));
    }
  }
}
