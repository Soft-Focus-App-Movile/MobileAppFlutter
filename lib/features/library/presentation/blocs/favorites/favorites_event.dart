import '../../../domain/models/content.dart';

abstract class FavoritesEvent {
  const FavoritesEvent();
}

class LoadFavorites extends FavoritesEvent {
  const LoadFavorites();
}

class AddFavorite extends FavoritesEvent {
  final Content content;

  const AddFavorite({required this.content});
}

class RemoveFavorite extends FavoritesEvent {
  final String favoriteId;

  const RemoveFavorite({required this.favoriteId});
}
