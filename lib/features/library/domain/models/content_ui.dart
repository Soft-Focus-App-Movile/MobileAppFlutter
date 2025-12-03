import 'content.dart';

class ContentUi {
  final Content content;
  final bool isFavorite;

  const ContentUi({
    required this.content,
    required this.isFavorite,
  });

  ContentUi copyWith({
    Content? content,
    bool? isFavorite,
  }) {
    return ContentUi(
      content: content ?? this.content,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
