import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../core/ui/colors.dart';
import '../../../../core/ui/text_styles.dart';
import '../../../../core/networking/http_client.dart';
import '../../../auth/data/local/user_session.dart';
import '../../domain/models/content.dart';
import '../blocs/content_detail/content_detail_bloc.dart';
import '../blocs/content_detail/content_detail_event.dart';
import '../blocs/content_detail/content_detail_state.dart';
import '../../data/services/assignments_service.dart';

class ContentDetailPage extends StatefulWidget {
  final Content content;

  const ContentDetailPage({super.key, required this.content});

  @override
  State<ContentDetailPage> createState() => _ContentDetailPageState();
}

class _ContentDetailPageState extends State<ContentDetailPage> {
  HttpClient? _httpClient;
  bool _isLoading = true;
  bool _showTrailer = false;
  WebViewController? _webViewController;

  @override
  void initState() {
    super.initState();
    _initializeHttpClient();
    _initializeWebView();
  }

  Future<void> _initializeHttpClient() async {
    final userSession = UserSession();
    final user = await userSession.getUser();
    setState(() {
      _httpClient = HttpClient(token: user?.token);
      _isLoading = false;
    });
  }

  void _initializeWebView() {
    if (widget.content.trailerUrl != null) {
      final videoId = _extractYoutubeVideoId(widget.content.trailerUrl!);
      if (videoId != null) {
        final html = '''
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * {
            margin: 0;
            padding: 0;
            overflow: hidden;
        }
        body, html {
            height: 100%;
            background-color: #000;
        }
        iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border: none;
        }
    </style>
</head>
<body>
    <iframe
        src="https://www.youtube.com/embed/$videoId?autoplay=1&rel=0&controls=1&showinfo=0&modestbranding=1&playsinline=1&fs=0"
        frameborder="0"
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
        allowfullscreen>
    </iframe>
</body>
</html>
        ''';

        _webViewController = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(Colors.black)
          ..loadHtmlString(html);
      }
    }
  }

  String? _extractYoutubeVideoId(String url) {
    final regExp1 = RegExp(r'(?:youtube\.com\/watch\?v=)([a-zA-Z0-9_-]+)');
    final match1 = regExp1.firstMatch(url);
    if (match1 != null) return match1.group(1);

    final regExp2 = RegExp(r'(?:youtu\.be\/)([a-zA-Z0-9_-]+)');
    final match2 = regExp2.firstMatch(url);
    if (match2 != null) return match2.group(1);

    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: black,
        body: Center(child: CircularProgressIndicator(color: green49)),
      );
    }

    return BlocProvider(
      create: (context) => ContentDetailBloc(
        assignmentsService: AssignmentsService(httpClient: _httpClient),
      )..add(LoadContentDetail(content: widget.content)),
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
                background: _showTrailer && _webViewController != null
                    ? WebViewWidget(controller: _webViewController!)
                    : widget.content.displayImage.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: widget.content.displayImage,
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
                    if (widget.content.isMovie || widget.content.isMusic) {
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
                      widget.content.title,
                      style: crimsonSemiBold.copyWith(
                        fontSize: 24,
                        color: white,
                      ),
                    ),
                    if (widget.content.displaySubtitle.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        widget.content.displaySubtitle,
                        style: sourceSansRegular.copyWith(
                          fontSize: 16,
                          color: gray828,
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        if (widget.content.rating != null) ...[
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            widget.content.formattedRating!,
                            style: sourceSansRegular.copyWith(
                              fontSize: 16,
                              color: white,
                            ),
                          ),
                          const SizedBox(width: 16),
                        ],
                        if (widget.content.duration != null) ...[
                          const Icon(Icons.access_time, size: 20, color: white),
                          const SizedBox(width: 4),
                          Text(
                            widget.content.formattedDuration!,
                            style: sourceSansRegular.copyWith(
                              fontSize: 16,
                              color: white,
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (widget.content.genres != null && widget.content.genres!.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.content.genres!.map((genre) {
                          return Chip(
                            label: Text(genre),
                            backgroundColor: gray2C,
                            labelStyle: sourceSansRegular.copyWith(color: white),
                          );
                        }).toList(),
                      ),
                    ],
                    if (widget.content.overview != null) ...[
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
                        widget.content.overview!,
                        style: sourceSansRegular.copyWith(
                          fontSize: 15,
                          color: white,
                          height: 1.5,
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    if (widget.content.trailerUrl != null && _webViewController != null)
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            setState(() {
                              _showTrailer = true;
                            });
                          },
                          icon: const Icon(Icons.play_circle_outline),
                          label: const Text('Ver tráiler'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: green49,
                            side: const BorderSide(color: green49),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    if (widget.content.trailerUrl != null && _webViewController != null)
                      const SizedBox(height: 12),
                    if (widget.content.externalUrl != null)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => _launchUrl(widget.content.externalUrl!),
                          icon: const Icon(Icons.open_in_new),
                          label: Text(_getButtonLabel(widget.content.type)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: green49,
                            foregroundColor: white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    if (widget.content.emotionalTags != null &&
                        widget.content.emotionalTags!.isNotEmpty) ...[
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
                        children: widget.content.emotionalTags!.map((tag) {
                          return Chip(
                            label: Text(tag),
                            backgroundColor: yellowCB9D,
                            labelStyle: sourceSansRegular.copyWith(color: white),
                          );
                        }).toList(),
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
