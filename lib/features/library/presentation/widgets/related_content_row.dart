import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/ui/colors.dart';
import '../../../../core/ui/text_styles.dart';
import '../../domain/models/content.dart';

class RelatedContentRow extends StatelessWidget {
  final List<Content> relatedContent;
  final Function(Content) onContentClick;

  const RelatedContentRow({
    super.key,
    required this.relatedContent,
    required this.onContentClick,
  });

  @override
  Widget build(BuildContext context) {
    if (relatedContent.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Otros',
            style: crimsonSemiBold.copyWith(
              fontSize: 18,
              color: white,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 220,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: relatedContent.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final content = relatedContent[index];
              return RelatedContentCard(
                content: content,
                onClick: () => onContentClick(content),
              );
            },
          ),
        ),
      ],
    );
  }
}

class RelatedContentCard extends StatelessWidget {
  final Content content;
  final VoidCallback onClick;

  const RelatedContentCard({
    super.key,
    required this.content,
    required this.onClick,
  });

  Future<void> _handleTap(BuildContext context) async {
    if (content.isMusic) {
      final musicUrl = content.spotifyUrl ?? content.externalUrl;
      if (musicUrl != null) {
        final uri = Uri.parse(musicUrl);
        if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No se pudo abrir Spotify')),
            );
          }
        }
      }
    } else {
      onClick();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleTap(context),
      child: SizedBox(
        width: 129,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 129,
                height: 134,
                color: gray2C,
                child: content.posterImage.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: content.posterImage,
                        width: 129,
                        height: 134,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(color: green49),
                        ),
                        errorWidget: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              size: 40,
                              color: gray808,
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Icon(
                          Icons.movie,
                          size: 40,
                          color: gray808,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content.title,
              style: crimsonSemiBold.copyWith(
                fontSize: 13,
                color: white,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (content.formattedDuration != null) ...[
              const SizedBox(height: 4),
              Text(
                'Duración  ${content.formattedDuration}',
                style: sourceSansRegular.copyWith(
                  fontSize: 11,
                  color: gray828,
                ),
              ),
            ],
            if (content.emotionalTags != null && content.emotionalTags!.isNotEmpty) ...[
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: yellowCB9D,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  content.emotionalTags!.first,
                  style: sourceSansRegular.copyWith(
                    fontSize: 9,
                    color: white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
