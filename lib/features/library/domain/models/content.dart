class Content {
  final String externalId;
  final String? id;
  final String type;
  final String title;
  final String? overview;
  final String? posterUrl;
  final String? backdropUrl;
  final String? rating;
  final String? duration;
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
}
