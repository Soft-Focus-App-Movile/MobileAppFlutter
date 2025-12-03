import '../../../../../core/common/status.dart';
import '../../../domain/models/content.dart';

class FavoritesState {
  final Status status;
  final List<Content> favorites;
  final String? message;

  const FavoritesState({
    this.status = Status.initial,
    this.favorites = const [],
    this.message,
  });

  FavoritesState copyWith({
    Status? status,
    List<Content>? favorites,
    String? message,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      favorites: favorites ?? this.favorites,
      message: message ?? this.message,
    );
  }
}
