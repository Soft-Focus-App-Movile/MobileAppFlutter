import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/ui/colors.dart';
import '../../../../core/ui/text_styles.dart';
import '../../domain/models/content_ui.dart';

class ContentCard extends StatelessWidget {
  final ContentUi contentUi;
  final bool isSelected;
  final bool isSelectionMode;
  final bool isPsychologist;
  final VoidCallback onFavoriteClick;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const ContentCard({
    super.key,
    required this.contentUi,
    this.isSelected = false,
    this.isSelectionMode = false,
    this.isPsychologist = false,
    required this.onFavoriteClick,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final content = contentUi.content;
    final canFavorite = !isPsychologist && (content.isMovie || content.isMusic);

    return GestureDetector(
      onTap: onTap,
      onLongPress: isPsychologist ? onLongPress : null,
      child: SizedBox(
        width: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: content.posterImage,
                    width: 160,
                    height: 180,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 160,
                      height: 180,
                      color: gray2C,
                      child: const Center(
                        child: CircularProgressIndicator(color: green49),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 160,
                      height: 180,
                      color: gray2C,
                      child: Icon(
                        _getIconForType(content.type),
                        size: 50,
                        color: gray808,
                      ),
                    ),
                  ),
                ),
                if (isSelectionMode && isSelected)
                  Container(
                    width: 160,
                    height: 180,
                    decoration: BoxDecoration(
                      color: green49.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.check_circle,
                        color: green49,
                        size: 48,
                      ),
                    ),
                  ),
                if (!isSelectionMode && canFavorite)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 20,
                        onPressed: onFavoriteClick,
                        icon: Icon(
                          Icons.favorite,
                          color: contentUi.isFavorite ? Colors.red : white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content.title,
              style: sourceSansRegular.copyWith(
                fontSize: 14,
                color: white,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (content.duration != null) ...[
              const SizedBox(height: 6),
              Text(
                'Duración  ${content.formattedDuration}',
                style: sourceSansLight.copyWith(
                  fontSize: 12,
                  color: white.withOpacity(0.7),
                ),
              ),
            ],
            if (content.emotionalTags != null && content.emotionalTags!.isNotEmpty) ...[
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                children: content.emotionalTags!.take(1).map((tag) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: yellowCB9D,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Text(
                      tag,
                      style: sourceSansRegular.copyWith(
                        fontSize: 11,
                        color: white,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
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
}
