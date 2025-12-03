import '../../../domain/models/content.dart';

abstract class LibraryEvent {
  const LibraryEvent();
}

class SearchContent extends LibraryEvent {
  final String type;
  final String? query;
  final String? emotion;
  final int page;

  const SearchContent({
    required this.type,
    this.query,
    this.emotion,
    this.page = 1,
  });
}

class ToggleFavorite extends LibraryEvent {
  final Content content;

  const ToggleFavorite({required this.content});
}

class LoadRecommendations extends LibraryEvent {
  const LoadRecommendations();
}
