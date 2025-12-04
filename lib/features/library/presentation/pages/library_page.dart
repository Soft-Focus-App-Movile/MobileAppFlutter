import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/ui/colors.dart';
import '../../../../core/common/status.dart';
import '../../../../core/networking/http_client.dart';
import '../../../auth/data/local/user_session.dart';
import '../../../auth/domain/models/user_type.dart';
import '../../data/services/content_search_service.dart';
import '../../data/services/recommendations_service.dart';
import '../../data/services/favorites_service.dart';
import '../../data/services/assignments_service.dart';
import '../blocs/library/library_bloc.dart';
import '../blocs/library/library_event.dart';
import '../blocs/library/library_state.dart';
import '../blocs/favorites/favorites_bloc.dart';
import '../blocs/assignments/assignments_bloc.dart';
import '../widgets/library_top_bar.dart';
import '../widgets/library_tabs.dart';
import '../widgets/search_bar_with_filter.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../widgets/content_card.dart';
import '../widgets/assignments_tab.dart';
import 'content_detail_page.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  UserType? _userType;
  bool _isLoading = true;
  String _currentTab = 'content';
  ContentType _selectedType = ContentType.movie;
  String _searchQuery = '';
  HttpClient? _httpClient;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _loadUserType();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadUserType() async {
    final userSession = UserSession();
    final user = await userSession.getUser();
    setState(() {
      _userType = user?.userType ?? UserType.GENERAL;
      _httpClient = HttpClient(token: user?.token);
      _isLoading = false;
      if (_userType == UserType.PATIENT) {
        _currentTab = 'assignments';
      }
    });
  }

  List<ContentType> get _availableTabs {
    if (_userType == UserType.PSYCHOLOGIST) {
      return [ContentType.movie, ContentType.music, ContentType.video];
    }
    return [ContentType.movie, ContentType.music, ContentType.video];
  }

  bool get _isPatient => _userType == UserType.PATIENT;

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: black,
        body: Center(child: CircularProgressIndicator(color: green49)),
      );
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LibraryBloc(
            contentSearchService: ContentSearchService(httpClient: _httpClient),
            recommendationsService: RecommendationsService(httpClient: _httpClient),
          )..add(SearchContent(type: _selectedType.name)),
        ),
        BlocProvider(
          create: (context) => FavoritesBloc(
            favoritesService: FavoritesService(httpClient: _httpClient),
          ),
        ),
        if (_isPatient)
          BlocProvider(
            create: (context) => AssignmentsBloc(
              assignmentsService: AssignmentsService(httpClient: _httpClient),
            ),
          ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: black,
            appBar: LibraryTopBar(
              isPsychologist: _userType == UserType.PSYCHOLOGIST,
              isSelectionMode: false,
              onCancelSelection: () {},
            ),
            body: Column(
              children: [
                LibraryTabs(
                  isPatient: _isPatient,
                  currentTab: _currentTab,
                  onTabChange: (tab) {
                    setState(() {
                      _currentTab = tab;
                    });
                  },
                  selectedType: _selectedType,
                  availableTabs: _availableTabs,
                  onContentTypeSelected: (type) {
                    setState(() {
                      _selectedType = type;
                      _searchQuery = '';
                    });
                    final libraryBloc = context.read<LibraryBloc>();
                    final emotionForType = libraryBloc.state.selectedEmotionByType[type.name];
                    libraryBloc.add(SearchContent(
                      type: type.name,
                      emotion: emotionForType,
                    ));
                  },
                ),
                if (_currentTab == 'content' &&
                    (_selectedType == ContentType.movie || _selectedType == ContentType.music))
                  SearchBarWithFilter(
                    searchQuery: _searchQuery,
                    onSearchQueryChange: (query) {
                      setState(() {
                        _searchQuery = query;
                      });

                      _debounceTimer?.cancel();
                      _debounceTimer = Timer(const Duration(milliseconds: 500), () {
                        final libraryBloc = context.read<LibraryBloc>();
                        final emotionForType = libraryBloc.state.selectedEmotionByType[_selectedType.name];

                        if (query.isEmpty) {
                          libraryBloc.add(
                            SearchContent(
                              type: _selectedType.name,
                              emotion: emotionForType,
                            ),
                          );
                        } else {
                          libraryBloc.add(
                            SearchContent(
                              type: _selectedType.name,
                              query: query,
                              emotion: emotionForType,
                            ),
                          );
                        }
                      });
                    },
                    onFilterClick: () {
                      final libraryBloc = context.read<LibraryBloc>();
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (_) => FilterBottomSheet(
                          selectedEmotion: libraryBloc.state.selectedEmotion,
                          onEmotionSelected: (emotion) {
                            libraryBloc.add(
                              SearchContent(
                                type: _selectedType.name,
                                emotion: emotion,
                                query: _searchQuery.isNotEmpty ? _searchQuery : null,
                              ),
                            );
                          },
                          onClearFilters: () {
                            libraryBloc.add(
                              SearchContent(type: _selectedType.name),
                            );
                          },
                        ),
                      );
                    },
                  ),
                const SizedBox(height: 16),
                Expanded(
                  child: _currentTab == 'assignments'
                      ? const AssignmentsTab()
                      : _buildContentGrid(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContentGrid() {
    return BlocBuilder<LibraryBloc, LibraryState>(
      builder: (context, state) {
        switch (state.status) {
          case Status.loading:
            return const Center(
              child: CircularProgressIndicator(color: green49),
            );

          case Status.failure:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    state.message ?? 'Error al cargar contenido',
                    style: const TextStyle(color: white),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<LibraryBloc>().add(
                            SearchContent(type: _selectedType.name),
                          );
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );

          case Status.success:
            if (state.contents.isEmpty) {
              return const Center(
                child: Text(
                  'No se encontró contenido',
                  style: TextStyle(color: gray828, fontSize: 16),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<LibraryBloc>().add(
                      SearchContent(type: _selectedType.name),
                    );
              },
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.6,
                ),
                itemCount: state.contents.length,
                itemBuilder: (context, index) {
                  final contentUi = state.contents[index];
                  return ContentCard(
                    contentUi: contentUi,
                    isSelected: false,
                    isSelectionMode: false,
                    onFavoriteClick: () {
                      context.read<LibraryBloc>().add(
                            ToggleFavorite(content: contentUi.content),
                          );
                    },
                    onTap: () async {
                      final content = contentUi.content;

                      if (content.isMusic) {
                        final musicUrl = content.spotifyUrl ?? content.externalUrl;

                        if (musicUrl != null && musicUrl.isNotEmpty) {
                          final uri = Uri.parse(musicUrl);
                          if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('No se pudo abrir Spotify')),
                              );
                            }
                          }
                        } else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Esta música no tiene URL de Spotify')),
                            );
                          }
                        }
                      } else {
                        if (context.mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContentDetailPage(
                                content: content,
                              ),
                            ),
                          );
                        }
                      }
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
