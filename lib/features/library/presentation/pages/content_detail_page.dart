import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/ui/colors.dart';
import '../../../../core/ui/text_styles.dart';
import '../../domain/models/content.dart';
import '../blocs/content_detail/content_detail_bloc.dart';
import '../blocs/content_detail/content_detail_event.dart';
import '../blocs/content_detail/content_detail_state.dart';
import '../../data/services/assignments_service.dart';

class ContentDetailPage extends StatelessWidget {
  final Content content;

  const ContentDetailPage({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContentDetailBloc(
        assignmentsService: AssignmentsService(),
      )..add(LoadContentDetail(content: content)),
      child: Scaffold(
        backgroundColor: black,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              backgroundColor: black,
              iconTheme: const IconThemeData(color: white),
              flexibleSpace: FlexibleSpaceBar(
                background: content.displayImage.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: content.displayImage,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: gray2C,
                          child: const Center(
                            child: CircularProgressIndicator(color: green49),
                          ),
                        ),
                        errorWidget: (context, error, stackTrace) {
                          return Container(
                            color: gray2C,
                            child: const Icon(
                              Icons.image_not_supported,
                              size: 80,
                              color: gray808,
                            ),
                          );
                        },
                      )
                    : Container(
                        color: gray2C,
                        child: const Icon(
                          Icons.movie,
                          size: 80,
                          color: gray808,
                        ),
                      ),
              ),
              actions: [
                BlocBuilder<ContentDetailBloc, ContentDetailState>(
                  builder: (context, state) {
                    if (content.isMovie || content.isMusic) {
                      return IconButton(
                        icon: Icon(
                          state.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: state.isFavorite ? Colors.red : white,
                        ),
                        onPressed: () {
                          context.read<ContentDetailBloc>().add(
                                const ToggleContentFavorite(),
                              );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content.title,
                      style: crimsonSemiBold.copyWith(
                        fontSize: 24,
                        color: white,
                      ),
                    ),
                    if (content.displaySubtitle.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        content.displaySubtitle,
                        style: sourceSansRegular.copyWith(
                          fontSize: 16,
                          color: gray828,
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        if (content.rating != null) ...[
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            content.rating!,
                            style: sourceSansRegular.copyWith(
                              fontSize: 16,
                              color: white,
                            ),
                          ),
                          const SizedBox(width: 16),
                        ],
                        if (content.duration != null) ...[
                          const Icon(Icons.access_time, size: 20, color: white),
                          const SizedBox(width: 4),
                          Text(
                            content.duration!,
                            style: sourceSansRegular.copyWith(
                              fontSize: 16,
                              color: white,
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (content.genres != null && content.genres!.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: content.genres!.map((genre) {
                          return Chip(
                            label: Text(genre),
                            backgroundColor: gray2C,
                            labelStyle: sourceSansRegular.copyWith(color: white),
                          );
                        }).toList(),
                      ),
                    ],
                    if (content.overview != null) ...[
                      const SizedBox(height: 24),
                      Text(
                        'Descripción',
                        style: crimsonSemiBold.copyWith(
                          fontSize: 18,
                          color: green49,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        content.overview!,
                        style: sourceSansRegular.copyWith(
                          fontSize: 15,
                          color: white,
                          height: 1.5,
                        ),
                      ),
                    ],
                    if (content.emotionalTags != null &&
                        content.emotionalTags!.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      Text(
                        'Etiquetas emocionales',
                        style: crimsonSemiBold.copyWith(
                          fontSize: 18,
                          color: green49,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: content.emotionalTags!.map((tag) {
                          return Chip(
                            label: Text(tag),
                            backgroundColor: yellowCB9D,
                            labelStyle: sourceSansRegular.copyWith(color: white),
                          );
                        }).toList(),
                      ),
                    ],
                    const SizedBox(height: 24),
                    if (content.externalUrl != null)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => _launchUrl(content.externalUrl!),
                          icon: const Icon(Icons.open_in_new),
                          label: Text(_getButtonLabel(content.type)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: green49,
                            foregroundColor: white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    if (content.trailerUrl != null) ...[
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => _launchUrl(content.trailerUrl!),
                          icon: const Icon(Icons.play_circle_outline),
                          label: const Text('Ver tráiler'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: green49,
                            side: const BorderSide(color: green49),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getButtonLabel(String type) {
    switch (type.toLowerCase()) {
      case 'movie':
        return 'Ver película';
      case 'music':
        return 'Escuchar en Spotify';
      case 'video':
        return 'Ver video';
      default:
        return 'Ver más';
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('No se pudo abrir $url');
    }
  }
}
