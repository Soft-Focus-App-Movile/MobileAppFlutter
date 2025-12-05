import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../library/data/services/content_search_service.dart';
import '../../../../library/data/models/request/content_search_request_dto.dart';
import 'general_home_event.dart';
import 'general_home_state.dart';

class GeneralHomeBloc extends Bloc<GeneralHomeEvent, GeneralHomeState> {
  final ContentSearchService _contentSearchService;

  static const int resultsPerSearch = 15;
  static const List<String> movieKeywords = [
    'inspirational',
    'feel-good',
    'hope',
    'friendship',
    'family',
    'uplifting'
  ];
  static const List<String> musicKeywords = [
    'meditation',
    'relaxing',
    'peaceful',
    'healing',
    'soothing',
    'calming'
  ];

  int _currentKeywordIndex = 0;

  GeneralHomeBloc({
    required ContentSearchService contentSearchService,
  })  : _contentSearchService = contentSearchService,
        super(GeneralHomeInitial()) {
    on<LoadGeneralHomeData>(_onLoadGeneralHomeData);
    on<RefreshGeneralRecommendations>(_onRefreshGeneralRecommendations);
  }

  Future<void> _onLoadGeneralHomeData(
    LoadGeneralHomeData event,
    Emitter<GeneralHomeState> emit,
  ) async {
    emit(GeneralHomeLoading());
    await _loadRecommendations(emit);
  }

  Future<void> _onRefreshGeneralRecommendations(
    RefreshGeneralRecommendations event,
    Emitter<GeneralHomeState> emit,
  ) async {
    emit(GeneralHomeLoading());
    await _loadRecommendations(emit);
  }

  Future<void> _loadRecommendations(Emitter<GeneralHomeState> emit) async {
    try {
      final allContent = [];

      // Search for movies and music
      final movieKeyword = _getNextKeyword(movieKeywords);
      final musicKeyword = _getNextKeyword(musicKeywords);

      // Search movies
      try {
        final movieRequest = ContentSearchRequestDto(
          query: movieKeyword,
          contentType: 'Movie',
          limit: resultsPerSearch,
        );
        final movieResponse =
            await _contentSearchService.searchContent(movieRequest);
        final movieContent = movieResponse.results.map((dto) => dto.toDomain()).toList();
        allContent.addAll(movieContent);
      } catch (e) {
        // Logging framework would be better
      }

      // Search music
      try {
        final musicRequest = ContentSearchRequestDto(
          query: musicKeyword,
          contentType: 'Music',
          limit: resultsPerSearch,
        );
        final musicResponse =
            await _contentSearchService.searchContent(musicRequest);
        final musicContent = musicResponse.results.map((dto) => dto.toDomain()).toList();
        allContent.addAll(musicContent);
      } catch (e) {
        // Logging framework would be better
      }

      // Filter content with valid images and shuffle
      final contentWithImages = allContent.where((item) {
        return item.posterUrl != null && item.posterUrl!.isNotEmpty ||
            item.backdropUrl != null && item.backdropUrl!.isNotEmpty ||
            item.thumbnailUrl != null && item.thumbnailUrl!.isNotEmpty ||
            item.photoUrl != null && item.photoUrl!.isNotEmpty;
      }).toList()
        ..shuffle();

      if (contentWithImages.isEmpty) {
        emit(GeneralHomeEmpty());
      } else {
        emit(GeneralHomeSuccess(contentWithImages));
      }
    } catch (e) {
      emit(GeneralHomeError(e.toString()));
    }
  }

  String _getNextKeyword(List<String> keywords) {
    final keyword = keywords[_currentKeywordIndex % keywords.length];
    _currentKeywordIndex++;
    return keyword;
  }
}
