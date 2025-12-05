import '../../../../../core/common/status.dart';
import '../../../domain/models/content_ui.dart';
import '../../widgets/video_category_selector.dart';

class LibraryState {
  final Status status;
  final String selectedType;
  final Map<String, String?> selectedEmotionByType;
  final Map<String, bool> showOnlyFavoritesByType;
  final VideoCategory? selectedVideoCategory;
  final List<ContentUi> contents;
  final Set<String> favoriteIds;
  final Map<String, String> favoriteIdMap;
  final Set<String> selectedContentIds;
  final String? message;
  final int currentPage;
  final int totalPages;
  final bool hasMorePages;

  const LibraryState({
    this.status = Status.initial,
    this.selectedType = 'movie',
    this.selectedEmotionByType = const {'movie': null, 'music': null, 'video': null},
    this.showOnlyFavoritesByType = const {'movie': false, 'music': false, 'video': false},
    this.selectedVideoCategory,
    this.contents = const [],
    this.favoriteIds = const {},
    this.favoriteIdMap = const {},
    this.selectedContentIds = const {},
    this.message,
    this.currentPage = 1,
    this.totalPages = 1,
    this.hasMorePages = false,
  });

  String? get selectedEmotion => selectedEmotionByType[selectedType];
  bool get showOnlyFavorites => showOnlyFavoritesByType[selectedType] ?? false;

  LibraryState copyWith({
    Status? status,
    String? selectedType,
    Map<String, String?>? selectedEmotionByType,
    Map<String, bool>? showOnlyFavoritesByType,
    VideoCategory? selectedVideoCategory,
    List<ContentUi>? contents,
    Set<String>? favoriteIds,
    Map<String, String>? favoriteIdMap,
    Set<String>? selectedContentIds,
    String? message,
    int? currentPage,
    int? totalPages,
    bool? hasMorePages,
  }) {
    return LibraryState(
      status: status ?? this.status,
      selectedType: selectedType ?? this.selectedType,
      selectedEmotionByType: selectedEmotionByType ?? this.selectedEmotionByType,
      showOnlyFavoritesByType: showOnlyFavoritesByType ?? this.showOnlyFavoritesByType,
      selectedVideoCategory: selectedVideoCategory ?? this.selectedVideoCategory,
      contents: contents ?? this.contents,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      favoriteIdMap: favoriteIdMap ?? this.favoriteIdMap,
      selectedContentIds: selectedContentIds ?? this.selectedContentIds,
      message: message ?? this.message,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasMorePages: hasMorePages ?? this.hasMorePages,
    );
  }
}
