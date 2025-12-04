import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/ui/colors.dart';
import '../../../../core/ui/text_styles.dart';
import '../../../../core/networking/http_client.dart';
import '../../../auth/data/local/user_session.dart';
import '../../domain/models/content.dart';
import '../blocs/content_detail/content_detail_bloc.dart';
import '../blocs/content_detail/content_detail_event.dart';
import '../blocs/content_detail/content_detail_state.dart';
import '../../data/services/assignments_service.dart';
import '../../data/services/recommendations_service.dart';
import '../widgets/related_content_row.dart';

class ContentDetailPage extends StatefulWidget {
  final Content content;

  const ContentDetailPage({super.key, required this.content});

  @override
  State<ContentDetailPage> createState() => _ContentDetailPageState();
}

class _ContentDetailPageState extends State<ContentDetailPage> {
  HttpClient? _httpClient;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeHttpClient();
  }

  Future<void> _initializeHttpClient() async {
    final userSession = UserSession();
    final user = await userSession.getUser();
    setState(() {
      _httpClient = HttpClient(token: user?.token);
      _isLoading = false;
    });
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
        recommendationsService: RecommendationsService(httpClient: _httpClient),
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
                background: widget.content.backdropImage.isNotEmpty
                    ? CachedNetworkImage(
                            imageUrl: widget.content.backdropImage,
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
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        if (widget.content.releaseYear != null) ...[
                          Text(
                            widget.content.releaseYear!,
                            style: sourceSansRegular.copyWith(
                              fontSize: 16,
                              color: white,
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                        if (widget.content.rating != null) ...[
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            widget.content.formattedRating!,
                            style: sourceSansRegular.copyWith(
                              fontSize: 16,
                              color: white,
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                        if (widget.content.duration != null) ...[
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
                    if (widget.content.overview != null) ...[
                      const SizedBox(height: 24),
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
                    if (widget.content.trailerUrl != null)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => _launchUrl(widget.content.trailerUrl!),
                          icon: const Icon(Icons.play_circle_outline),
                          label: const Text('Ver tráiler'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: green49,
                            foregroundColor: white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    const SizedBox(height: 32),
                    BlocBuilder<ContentDetailBloc, ContentDetailState>(
                      builder: (context, state) {
                        return RelatedContentRow(
                          relatedContent: state.relatedContent,
                          onContentClick: (content) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContentDetailPage(content: content),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('No se pudo abrir $url');
    }
  }
}
