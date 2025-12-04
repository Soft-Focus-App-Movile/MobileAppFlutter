import '../../../../../core/common/status.dart';
import '../../../domain/models/content_ui.dart';

class LibraryState {
  final Status status;
  final String selectedType;
  final Map<String, String?> selectedEmotionByType;
  final List<ContentUi> contents;
  final String? message;
  final int currentPage;
  final int totalPages;
  final bool hasMorePages;

  const LibraryState({
    this.status = Status.initial,
    this.selectedType = 'movie',
    this.selectedEmotionByType = const {'movie': null, 'music': null, 'video': null},
    this.contents = const [],
    this.message,
    this.currentPage = 1,
    this.totalPages = 1,
    this.hasMorePages = false,
  });

  String? get selectedEmotion => selectedEmotionByType[selectedType];

  LibraryState copyWith({
    Status? status,
    String? selectedType,
    Map<String, String?>? selectedEmotionByType,
    List<ContentUi>? contents,
    String? message,
    int? currentPage,
    int? totalPages,
    bool? hasMorePages,
  }) {
    return LibraryState(
      status: status ?? this.status,
      selectedType: selectedType ?? this.selectedType,
      selectedEmotionByType: selectedEmotionByType ?? this.selectedEmotionByType,
      contents: contents ?? this.contents,
      message: message ?? this.message,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasMorePages: hasMorePages ?? this.hasMorePages,
    );
  }
}
