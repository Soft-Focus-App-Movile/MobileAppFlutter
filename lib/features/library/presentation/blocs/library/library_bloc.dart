import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common/status.dart';
import '../../../data/services/content_search_service.dart';
import '../../../data/services/recommendations_service.dart';
import '../../../data/services/favorites_service.dart';
import '../../../data/services/videos_search_service.dart';
import '../../../data/models/request/content_search_request_dto.dart';
import '../../../data/models/request/favorite_request_dto.dart';
import '../../../data/mappers/content_mapper.dart';
import '../../../domain/models/content_ui.dart';
import 'library_event.dart';
import 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final ContentSearchService _contentSearchService;
  final RecommendationsService _recommendationsService;
  final FavoritesService _favoritesService;
  final VideosSearchService _videosSearchService;

  LibraryBloc({
    required ContentSearchService contentSearchService,
    required RecommendationsService recommendationsService,
    required FavoritesService favoritesService,
    required VideosSearchService videosSearchService,
  })  : _contentSearchService = contentSearchService,
        _recommendationsService = recommendationsService,
        _favoritesService = favoritesService,
        _videosSearchService = videosSearchService,
        super(const LibraryState()) {
    on<SearchContent>(_onSearchContent);
    on<ToggleFavorite>(_onToggleFavorite);
    on<LoadFavoritesIds>(_onLoadFavoritesIds);
    on<ToggleFavoritesFilter>(_onToggleFavoritesFilter);
    on<SelectVideoCategory>(_onSelectVideoCategory);
    on<LoadRecommendations>(_onLoadRecommendations);
  }

  Future<void> _onSearchContent(
    SearchContent event,
    Emitter<LibraryState> emit,
  ) async {
    final updatedEmotionByType = Map<String, String?>.from(state.selectedEmotionByType);
    updatedEmotionByType[event.type] = event.emotion;

    final updatedFavoritesByType = Map<String, bool>.from(state.showOnlyFavoritesByType);
    if (event.showOnlyFavorites != null) {
      updatedFavoritesByType[event.type] = event.showOnlyFavorites!;
    }

    if (event.page == 1) {
      emit(state.copyWith(
        status: Status.loading,
        selectedType: event.type,
        selectedEmotionByType: updatedEmotionByType,
        showOnlyFavoritesByType: updatedFavoritesByType,
      ));
    }

    try {
      final showFavorites = event.showOnlyFavorites ?? updatedFavoritesByType[event.type] ?? false;
      final hasQuery = event.query != null && event.query!.isNotEmpty;
      final hasEmotion = event.emotion != null && event.emotion!.isNotEmpty;

      final contentList = <ContentUi>[];

      if (showFavorites && (event.type == 'movie' || event.type == 'music')) {
        final response = await _favoritesService.getFavorites();
        final filteredFavorites = response.favorites
            .where((fav) => fav.content != null && fav.content!.type?.toLowerCase() == event.type.toLowerCase())
            .toList();

        contentList.addAll(filteredFavorites
            .map((fav) => ContentUi(
                  content: ContentMapper.fromDto(fav.content!),
                  isFavorite: true,
                ))
            .toList());
      } else if (hasQuery) {
        final request = ContentSearchRequestDto(
          query: event.query!,
          contentType: event.type,
          emotionFilter: event.emotion,
          limit: 20,
        );

        final response = await _contentSearchService.searchContent(request);

        contentList.addAll(response.results
            .map((dto) {
              final content = ContentMapper.fromDto(dto);
              return ContentUi(
                content: content,
                isFavorite: state.favoriteIds.contains(content.externalId),
              );
            })
            .toList());
      } else if (hasEmotion) {
        final response = await _recommendationsService.getRecommendedByEmotion(
          emotion: event.emotion!,
          contentType: event.type,
          limit: 20,
        );

        contentList.addAll(response.content
            .map((dto) {
              final content = ContentMapper.fromDto(dto);
              return ContentUi(
                content: content,
                isFavorite: state.favoriteIds.contains(content.externalId),
              );
            })
            .toList());
      } else {
        final response = await _recommendationsService.getRecommendedContent(
          contentType: event.type,
          limit: 20,
        );

        contentList.addAll(response.content
            .map((dto) {
              final content = ContentMapper.fromDto(dto);
              return ContentUi(
                content: content,
                isFavorite: state.favoriteIds.contains(content.externalId),
              );
            })
            .toList());
      }

      emit(state.copyWith(
        status: Status.success,
        contents: contentList,
        currentPage: 1,
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
    final contentUi = state.contents.firstWhere(
      (item) => item.content.externalId == event.content.externalId,
      orElse: () => ContentUi(content: event.content, isFavorite: false),
    );

    final isFavorite = contentUi.isFavorite;

    final updatedContents = state.contents.map((item) {
      if (item.content.externalId == event.content.externalId) {
        return item.copyWith(isFavorite: !isFavorite);
      }
      return item;
    }).toList();

    emit(state.copyWith(contents: updatedContents));

    try {
      final updatedFavoriteIds = Set<String>.from(state.favoriteIds);
      final updatedFavoriteIdMap = Map<String, String>.from(state.favoriteIdMap);

      if (isFavorite) {
        final favoriteId = state.favoriteIdMap[event.content.externalId];
        if (favoriteId != null) {
          await _favoritesService.removeFavorite(favoriteId);
          updatedFavoriteIds.remove(event.content.externalId);
          updatedFavoriteIdMap.remove(event.content.externalId);
        }
      } else {
        final request = FavoriteRequestDto(
          contentId: event.content.externalId,
          contentType: event.content.type,
        );
        await _favoritesService.addFavorite(request);
        updatedFavoriteIds.add(event.content.externalId);

        add(const LoadFavoritesIds());
      }

      emit(state.copyWith(
        favoriteIds: updatedFavoriteIds,
        favoriteIdMap: updatedFavoriteIdMap,
      ));
    } catch (e) {
      final revertedContents = state.contents.map((item) {
        if (item.content.externalId == event.content.externalId) {
          return item.copyWith(isFavorite: isFavorite);
        }
        return item;
      }).toList();

      emit(state.copyWith(
        contents: revertedContents,
        message: 'Error al actualizar favorito: ${e.toString()}',
      ));
    }
  }

  Future<void> _onLoadFavoritesIds(
    LoadFavoritesIds event,
    Emitter<LibraryState> emit,
  ) async {
    try {
      final response = await _favoritesService.getFavorites();
      final favoriteIds = <String>{};
      final favoriteIdMap = <String, String>{};

      for (final fav in response.favorites) {
        if (fav.content != null && fav.id != null) {
          favoriteIds.add(fav.content!.externalId);
          favoriteIdMap[fav.content!.externalId] = fav.id!;
        }
      }

      emit(state.copyWith(
        favoriteIds: favoriteIds,
        favoriteIdMap: favoriteIdMap,
      ));
    } catch (e) {
      emit(state.copyWith(
        message: 'Error al cargar favoritos: ${e.toString()}',
      ));
    }
  }

  Future<void> _onToggleFavoritesFilter(
    ToggleFavoritesFilter event,
    Emitter<LibraryState> emit,
  ) async {
    final updatedFavoritesByType = Map<String, bool>.from(state.showOnlyFavoritesByType);
    updatedFavoritesByType[state.selectedType] = event.showOnlyFavorites;

    emit(state.copyWith(
      showOnlyFavoritesByType: updatedFavoritesByType,
    ));

    add(SearchContent(
      type: state.selectedType,
      emotion: state.selectedEmotion,
      showOnlyFavorites: event.showOnlyFavorites,
    ));
  }

  Future<void> _onSelectVideoCategory(
    SelectVideoCategory event,
    Emitter<LibraryState> emit,
  ) async {
    emit(state.copyWith(
      selectedVideoCategory: event.category,
      status: Status.loading,
    ));

    try {
      final response = await _videosSearchService.searchVideos(event.category.queryText);

      final contentList = response.results
          .map((dto) {
            final content = ContentMapper.fromDto(dto);
            return ContentUi(
              content: content,
              isFavorite: false,
            );
          })
          .toList();

      emit(state.copyWith(
        status: Status.success,
        contents: contentList,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.failure,
        message: e.toString(),
      ));
    }
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
