import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common/status.dart';
import '../../../data/services/assignments_service.dart';
import '../../../data/services/recommendations_service.dart';
import '../../../data/mappers/content_mapper.dart';
import '../../../data/models/request/assignment_request_dto.dart';
import 'content_detail_event.dart';
import 'content_detail_state.dart';

class ContentDetailBloc extends Bloc<ContentDetailEvent, ContentDetailState> {
  final AssignmentsService _assignmentsService;
  final RecommendationsService _recommendationsService;

  ContentDetailBloc({
    required AssignmentsService assignmentsService,
    required RecommendationsService recommendationsService,
  })  : _assignmentsService = assignmentsService,
        _recommendationsService = recommendationsService,
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
      status: Status.loading,
      content: event.content,
    ));

    try {
      final content = event.content;
      final relatedContent = <dynamic>[];

      if (content.emotionalTags != null && content.emotionalTags!.isNotEmpty) {
        final response = await _recommendationsService.getRecommendedByEmotion(
          emotion: content.emotionalTags!.first,
          contentType: content.type,
          limit: 10,
        );
        relatedContent.addAll(response.content);
      } else {
        final response = await _recommendationsService.getRecommendedContent(
          contentType: content.type,
          limit: 10,
        );
        relatedContent.addAll(response.content);
      }

      final filteredRelated = relatedContent
          .where((item) => item.externalId != content.externalId)
          .take(5)
          .map((dto) => ContentMapper.fromDto(dto))
          .toList();

      emit(state.copyWith(
        status: Status.success,
        content: content,
        relatedContent: filteredRelated,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.success,
        content: event.content,
        relatedContent: [],
      ));
    }
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
