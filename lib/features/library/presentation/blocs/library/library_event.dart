import '../../../domain/models/content.dart';
import '../../widgets/video_category_selector.dart';

abstract class LibraryEvent {
  const LibraryEvent();
}

class SearchContent extends LibraryEvent {
  final String type;
  final String? query;
  final String? emotion;
  final bool? showOnlyFavorites;
  final int page;

  const SearchContent({
    required this.type,
    this.query,
    this.emotion,
    this.showOnlyFavorites,
    this.page = 1,
  });
}

class ToggleFavorite extends LibraryEvent {
  final Content content;

  const ToggleFavorite({required this.content});
}

class LoadFavoritesIds extends LibraryEvent {
  const LoadFavoritesIds();
}

class ToggleFavoritesFilter extends LibraryEvent {
  final bool showOnlyFavorites;

  const ToggleFavoritesFilter({required this.showOnlyFavorites});
}

class SelectVideoCategory extends LibraryEvent {
  final VideoCategory category;

  const SelectVideoCategory({required this.category});
}

class LoadRecommendations extends LibraryEvent {
  const LoadRecommendations();
}
