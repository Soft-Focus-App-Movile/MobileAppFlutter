import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common/status.dart';
import '../../../data/services/favorites_service.dart';
import '../../../data/models/request/favorite_request_dto.dart';
import '../../../data/mappers/content_mapper.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesService _favoritesService;

  FavoritesBloc({
    required FavoritesService favoritesService,
  })  : _favoritesService = favoritesService,
        super(const FavoritesState()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<AddFavorite>(_onAddFavorite);
    on<RemoveFavorite>(_onRemoveFavorite);
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    try {
      final response = await _favoritesService.getFavorites();
      final favorites =
          response.results.map((dto) => ContentMapper.fromDto(dto)).toList();

      emit(state.copyWith(
        status: Status.success,
        favorites: favorites,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onAddFavorite(
    AddFavorite event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      final request = FavoriteRequestDto(
        contentId: event.content.externalId,
        contentType: event.content.type,
      );

      await _favoritesService.addFavorite(request);

      final updatedFavorites = [...state.favorites, event.content];
      emit(state.copyWith(favorites: updatedFavorites));
    } catch (e) {
      emit(state.copyWith(
        status: Status.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onRemoveFavorite(
    RemoveFavorite event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await _favoritesService.removeFavorite(event.favoriteId);

      final updatedFavorites =
          state.favorites.where((c) => c.id != event.favoriteId).toList();

      emit(state.copyWith(favorites: updatedFavorites));
    } catch (e) {
      emit(state.copyWith(
        status: Status.failure,
        message: e.toString(),
      ));
    }
  }
}
