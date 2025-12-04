import '../../../../../core/common/status.dart';
import '../../../domain/models/content.dart';

class ContentDetailState {
  final Status status;
  final Content? content;
  final List<Content> relatedContent;
  final bool isFavorite;
  final String? message;

  const ContentDetailState({
    this.status = Status.initial,
    this.content,
    this.relatedContent = const [],
    this.isFavorite = false,
    this.message,
  });

  ContentDetailState copyWith({
    Status? status,
    Content? content,
    List<Content>? relatedContent,
    bool? isFavorite,
    String? message,
  }) {
    return ContentDetailState(
      status: status ?? this.status,
      content: content ?? this.content,
      relatedContent: relatedContent ?? this.relatedContent,
      isFavorite: isFavorite ?? this.isFavorite,
      message: message ?? this.message,
    );
  }
}
