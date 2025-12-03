class Content {
  final String externalId;
  final String? id;
  final String type;
  final String title;
  final String? overview;
  final String? posterUrl;
  final String? backdropUrl;
  final double? rating;
  final int? duration;
  final String? releaseDate;
  final List<String>? genres;
  final String? trailerUrl;
  final List<String>? emotionalTags;
  final String? externalUrl;
  final String? artist;
  final String? album;
  final String? previewUrl;
  final String? spotifyUrl;
  final String? channelName;
  final String? youtubeUrl;
  final String? thumbnailUrl;

  const Content({
    required this.externalId,
    this.id,
    required this.type,
    required this.title,
    this.overview,
    this.posterUrl,
    this.backdropUrl,
    this.rating,
    this.duration,
    this.releaseDate,
    this.genres,
    this.trailerUrl,
    this.emotionalTags,
    this.externalUrl,
    this.artist,
    this.album,
    this.previewUrl,
    this.spotifyUrl,
    this.channelName,
    this.youtubeUrl,
    this.thumbnailUrl,
  });

  bool get isMovie => type == 'movie';
  bool get isMusic => type == 'music';
  bool get isVideo => type == 'video';

  String get displayImage => posterUrl ?? thumbnailUrl ?? backdropUrl ?? '';

  String get displaySubtitle {
    if (isMusic && artist != null) return artist!;
    if (isVideo && channelName != null) return channelName!;
    if (releaseDate != null) return releaseDate!;
    return '';
  }

  /// Formatea la duración en minutos a formato legible
  /// Ejemplos: 148 -> "2h 28min", 45 -> "45min"
  String? get formattedDuration {
    if (duration == null) return null;
    final hours = duration! ~/ 60;
    final minutes = duration! % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}min';
    } else {
      return '${minutes}min';
    }
  }

  /// Formatea el rating a una cadena con un decimal
  /// Ejemplo: 7.5 -> "7.5/10"
  String? get formattedRating {
    if (rating == null) return null;
    return '${rating!.toStringAsFixed(1)}/10';
  }

  /// Obtiene el año de lanzamiento desde releaseDate
  /// Ejemplo: "2023-05-12" -> "2023"
  String? get releaseYear {
    if (releaseDate == null || releaseDate!.length < 4) return null;
    return releaseDate!.substring(0, 4);
  }
}
