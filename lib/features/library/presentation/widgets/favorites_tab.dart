import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/status.dart';
import '../../../../core/ui/colors.dart';
import '../../../../core/ui/text_styles.dart';
import '../blocs/favorites/favorites_bloc.dart';
import '../blocs/favorites/favorites_event.dart';
import '../blocs/favorites/favorites_state.dart';
import '../../domain/models/content_ui.dart';
import '../pages/content_detail_page.dart';
import 'content_card.dart';

class FavoritesTab extends StatefulWidget {
  const FavoritesTab({super.key});

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  @override
  void initState() {
    super.initState();
    context.read<FavoritesBloc>().add(const LoadFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        switch (state.status) {
          case Status.loading:
            return const Center(child: CircularProgressIndicator(color: green49));

          case Status.failure:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    state.message ?? 'Error al cargar favoritos',
                    style: sourceSansRegular.copyWith(fontSize: 14, color: white),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<FavoritesBloc>().add(const LoadFavorites());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: green49,
                      foregroundColor: white,
                    ),
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );

          case Status.success:
            if (state.favorites.isEmpty) {
              return Center(
                child: Text(
                  'No tienes favoritos',
                  style: sourceSansRegular.copyWith(
                    fontSize: 14,
                    color: white.withOpacity(0.7),
                  ),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<FavoritesBloc>().add(const LoadFavorites());
              },
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.6,
                ),
                itemCount: state.favorites.length,
                itemBuilder: (context, index) {
                  final content = state.favorites[index];
                  return ContentCard(
                    contentUi: ContentUi(content: content, isFavorite: true),
                    isSelected: false,
                    isSelectionMode: false,
                    onFavoriteClick: () {
                      context.read<FavoritesBloc>().add(
                            RemoveFavorite(favoriteId: content.externalId),
                          );
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContentDetailPage(content: content),
                        ),
                      );
                    },
                    onLongPress: () {},
                  );
                },
              ),
            );

          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
