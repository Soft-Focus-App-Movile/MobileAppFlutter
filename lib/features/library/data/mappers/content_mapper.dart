import '../../domain/models/content.dart';
import '../../domain/models/assignment.dart';
import '../models/response/content_item_response_dto.dart';
import '../models/response/assignment_response_dto.dart';

class ContentMapper {
  /// Parsea la duración desde el formato del backend
  /// Ejemplos: "148min" -> 148, "2 temporadas" -> 2
  static int? _parseDuration(String? durationString) {
    if (durationString == null || durationString.isEmpty) return null;

    // Extraer el primer número de la cadena
    final numberMatch = RegExp(r'\d+').firstMatch(durationString);
    if (numberMatch == null) return null;

    return int.tryParse(numberMatch.group(0)!);
  }

  static Content fromDto(ContentItemResponseDto dto) {
    String? finalYoutubeUrl = dto.youtubeUrl;
    String? finalThumbnailUrl = dto.thumbnailUrl;

    // Construir URLs de YouTube si el externalId es un video de YouTube
    if (dto.externalId.startsWith('youtube-video-')) {
      final videoId = dto.externalId.replaceFirst('youtube-video-', '');

      if (videoId.isNotEmpty) {
        // Construir youtubeUrl si no existe
        if (finalYoutubeUrl == null || finalYoutubeUrl.isEmpty) {
          finalYoutubeUrl = 'https://www.youtube.com/watch?v=$videoId';
        }

        // Construir thumbnailUrl si no existe
        if (finalThumbnailUrl == null || finalThumbnailUrl.isEmpty) {
          finalThumbnailUrl = 'https://i.ytimg.com/vi/$videoId/hqdefault.jpg';
        }
      }
    }

    return Content(
      externalId: dto.externalId,
      id: dto.id,
      type: dto.type,
      title: dto.title,
      overview: dto.overview,
      posterUrl: dto.posterUrl,
      backdropUrl: dto.backdropUrl,
      rating: dto.rating != null ? double.tryParse(dto.rating!) : null,
      duration: _parseDuration(dto.duration),
      releaseDate: dto.releaseDate,
      genres: dto.genres,
      trailerUrl: dto.trailerUrl,
      emotionalTags: dto.emotionalTags,
      externalUrl: dto.externalUrl,
      artist: dto.artist,
      album: dto.album,
      previewUrl: dto.previewUrl,
      spotifyUrl: dto.spotifyUrl,
      channelName: dto.channelName,
      youtubeUrl: finalYoutubeUrl,
      thumbnailUrl: finalThumbnailUrl,
    );
  }

  static Assignment fromAssignmentDto(AssignmentResponseDto dto) {
    return Assignment(
      id: dto.assignmentId,
      content: fromDto(dto.content),
      psychologistId: dto.psychologistId,
      notes: dto.notes,
      assignedDate: DateTime.parse(dto.assignedAt),
      isCompleted: dto.isCompleted,
      completedDate: dto.completedAt != null
          ? DateTime.parse(dto.completedAt!)
          : null,
    );
  }
}
