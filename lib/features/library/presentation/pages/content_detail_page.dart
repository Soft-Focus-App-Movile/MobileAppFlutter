import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/models/content.dart';
import '../blocs/content_detail/content_detail_bloc.dart';
import '../blocs/content_detail/content_detail_event.dart';
import '../blocs/content_detail/content_detail_state.dart';

class ContentDetailPage extends StatelessWidget {
  final Content content;

  const ContentDetailPage({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContentDetailBloc(
        assignmentsService: context.read(),
      )..add(LoadContentDetail(content: content)),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: content.displayImage.isNotEmpty
                    ? Image.network(
                        content.displayImage,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.image_not_supported, size: 80),
                          );
                        },
                      )
                    : Container(
                        color: Colors.grey[300],
                        child: Icon(
                          _getIconForType(content.type),
                          size: 80,
                          color: Colors.grey[600],
                        ),
                      ),
              ),
              actions: [
                BlocBuilder<ContentDetailBloc, ContentDetailState>(
                  builder: (context, state) {
                    return IconButton(
                      icon: Icon(
                        state.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: state.isFavorite ? Colors.red : Colors.white,
                      ),
                      onPressed: () {
                        context.read<ContentDetailBloc>().add(
                              const ToggleContentFavorite(),
                            );
                      },
                    );
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
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (content.displaySubtitle.isNotEmpty)
                      Text(
                        content.displaySubtitle,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    const SizedBox(height: 16),
                    if (content.rating != null || content.duration != null)
                      Row(
                        children: [
                          if (content.rating != null) ...[
                            const Icon(Icons.star, color: Colors.amber, size: 20),
                            const SizedBox(width: 4),
                            Text(content.rating!, style: const TextStyle(fontSize: 16)),
                            const SizedBox(width: 16),
                          ],
                          if (content.duration != null) ...[
                            const Icon(Icons.access_time, size: 20),
                            const SizedBox(width: 4),
                            Text(content.duration!, style: const TextStyle(fontSize: 16)),
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
                            backgroundColor: Colors.grey[200],
                          );
                        }).toList(),
                      ),
                    ],
                    if (content.overview != null) ...[
                      const SizedBox(height: 24),
                      const Text(
                        'Descripción',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        content.overview!,
                        style: const TextStyle(fontSize: 15, height: 1.5),
                      ),
                    ],
                    if (content.emotionalTags != null && content.emotionalTags!.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      const Text(
                        'Etiquetas emocionales',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: content.emotionalTags!.map((tag) {
                          return Chip(
                            label: Text(tag),
                            backgroundColor: Colors.blue[100],
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

  IconData _getIconForType(String type) {
    switch (type.toLowerCase()) {
      case 'movie':
        return Icons.movie;
      case 'music':
        return Icons.music_note;
      case 'video':
        return Icons.videocam;
      default:
        return Icons.description;
    }
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
