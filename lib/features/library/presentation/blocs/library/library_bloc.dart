import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common/status.dart';
import '../../../data/services/content_search_service.dart';
import '../../../data/models/request/content_search_request_dto.dart';
import '../../../data/mappers/content_mapper.dart';
import '../../../domain/models/content_ui.dart';
import 'library_event.dart';
import 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final ContentSearchService _contentSearchService;

  LibraryBloc({
    required ContentSearchService contentSearchService,
  })  : _contentSearchService = contentSearchService,
        super(const LibraryState()) {
    on<SearchContent>(_onSearchContent);
    on<ToggleFavorite>(_onToggleFavorite);
    on<LoadRecommendations>(_onLoadRecommendations);
  }

  Future<void> _onSearchContent(
    SearchContent event,
    Emitter<LibraryState> emit,
  ) async {
    if (event.page == 1) {
      emit(state.copyWith(
        status: Status.loading,
        selectedType: event.type,
      ));
    }

    try {
      final request = ContentSearchRequestDto(
        query: event.query != null && event.query!.isNotEmpty ? event.query! : '*',
        contentType: event.type,
        emotionFilter: event.emotion,
        limit: 20,
      );

      final response = await _contentSearchService.searchContent(request);

      final contentList = response.results
          .map((dto) => ContentUi(
                content: ContentMapper.fromDto(dto),
                isFavorite: false,
              ))
          .toList();

      emit(state.copyWith(
        status: Status.success,
        contents: contentList,
        currentPage: response.page,
        totalPages: 1,
        hasMorePages: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<LibraryState> emit,
  ) async {
    final updatedContents = state.contents.map((item) {
      if (item.content.externalId == event.content.externalId) {
        return item.copyWith(isFavorite: !item.isFavorite);
      }
      return item;
    }).toList();

    emit(state.copyWith(contents: updatedContents));
  }

  Future<void> _onLoadRecommendations(
    LoadRecommendations event,
    Emitter<LibraryState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    try {
      emit(state.copyWith(
        status: Status.success,
        contents: [],
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.failure,
        message: e.toString(),
      ));
    }
  }
}
