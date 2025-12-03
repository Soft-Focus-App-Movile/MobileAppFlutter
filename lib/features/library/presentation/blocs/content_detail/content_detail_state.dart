import '../../../../../core/common/status.dart';
import '../../../domain/models/content.dart';

class ContentDetailState {
  final Status status;
  final Content? content;
  final bool isFavorite;
  final String? message;

  const ContentDetailState({
    this.status = Status.initial,
    this.content,
    this.isFavorite = false,
    this.message,
  });

  ContentDetailState copyWith({
    Status? status,
    Content? content,
    bool? isFavorite,
    String? message,
  }) {
    return ContentDetailState(
      status: status ?? this.status,
      content: content ?? this.content,
      isFavorite: isFavorite ?? this.isFavorite,
      message: message ?? this.message,
    );
  }
}
