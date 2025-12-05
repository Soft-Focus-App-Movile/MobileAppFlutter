import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/common/result.dart';
import '../../../../core/ui/colors.dart';
import '../../../../core/common/status.dart';
import '../../../../core/networking/http_client.dart';
import '../../../../core/ui/text_styles.dart';
import '../../../auth/data/local/user_session.dart';
import '../../../auth/domain/models/user_type.dart';
import '../../../therapy/data/services/therapy_service.dart';
import '../../../therapy/data/repositories/therapy_repository_impl.dart';
import '../../../therapy/domain/models/patient_directory_item.dart';
import '../../data/models/request/assignment_request_dto.dart';
import '../../data/services/content_search_service.dart';
import '../../data/services/recommendations_service.dart';
import '../../data/services/favorites_service.dart';
import '../../data/services/assignments_service.dart';
import '../../data/services/videos_search_service.dart';
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
import '../widgets/video_category_selector.dart';
import '../widgets/assign_patient_bottom_sheet.dart';
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
  List<PatientDirectoryItem> _patients = [];
  bool _patientsLoading = false;
  String? _patientsError;

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
  bool get _isPsychologist => _userType == UserType.PSYCHOLOGIST;

  Future<void> _loadPatients() async {
    setState(() {
      _patientsLoading = true;
      _patientsError = null;
    });

    try {
      final therapyService = TherapyService(httpClient: _httpClient);
      final therapyRepository = TherapyRepositoryImpl(service: therapyService);
      final result = await therapyRepository.getPatientDirectory();

      switch (result) {
        case Success(data: final patients):
          setState(() {
            _patients = patients;
            _patientsLoading = false;
          });
        case Error(message: final error):
          setState(() {
            _patientsError = error;
            _patientsLoading = false;
          });
      }
    } catch (e) {
      setState(() {
        _patientsError = e.toString();
        _patientsLoading = false;
      });
    }
  }

  Future<void> _assignContent(BuildContext context, LibraryBloc libraryBloc, String patientId, String patientName) async {
    try {
      final selectedIds = libraryBloc.state.selectedContentIds;
      final contents = libraryBloc.state.contents
          .where((contentUi) => selectedIds.contains(contentUi.content.externalId))
          .toList();

      final assignmentsService = AssignmentsService(httpClient: _httpClient);

      int successCount = 0;
      for (final contentUi in contents) {
        try {
          final request = AssignmentRequestDto(
            patientIds: [patientId],
            contentId: contentUi.content.externalId,
            contentType: contentUi.content.type,
            notes: '',
          );

          await assignmentsService.assignContent(request);
          successCount++;
        } catch (e) {
          print('Error asignando ${contentUi.content.title}: $e');
        }
      }

      if (context.mounted) {
        context.read<LibraryBloc>().add(const ClearSelection());
        if (successCount == contents.length) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: green49),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '$successCount contenido(s) asignado(s) a $patientName',
                      style: const TextStyle(color: white),
                    ),
                  ),
                ],
              ),
              backgroundColor: gray2C,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, color: Colors.orange),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Solo $successCount de ${contents.length} contenido(s) asignado(s)',
                      style: const TextStyle(color: white),
                    ),
                  ),
                ],
              ),
              backgroundColor: gray2C,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }
      }
    } catch (e) {
      print('Error general en _assignContent: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.red),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Error: ${e.toString()}',
                    style: const TextStyle(color: white),
                  ),
                ),
              ],
            ),
            backgroundColor: gray2C,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }
  }

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
            favoritesService: FavoritesService(httpClient: _httpClient),
            videosSearchService: VideosSearchService(httpClient: _httpClient),
          )
            ..add(const LoadFavoritesIds())
            ..add(SearchContent(type: _selectedType.name)),
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
          return BlocBuilder<LibraryBloc, LibraryState>(
            builder: (context, libraryState) {
              final isSelectionMode = _isPsychologist && libraryState.selectedContentIds.isNotEmpty;

              return Scaffold(
                backgroundColor: black,
                appBar: LibraryTopBar(
                  isPsychologist: _isPsychologist,
                  isSelectionMode: isSelectionMode,
                  onCancelSelection: () {
                    context.read<LibraryBloc>().add(const ClearSelection());
                  },
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
                if (_currentTab == 'content')
                  if (_selectedType == ContentType.video)
                    BlocBuilder<LibraryBloc, LibraryState>(
                      builder: (context, state) {
                        return VideoCategorySelector(
                          selectedCategory: state.selectedVideoCategory,
                          onCategorySelected: (category) {
                            context.read<LibraryBloc>().add(
                                  SelectVideoCategory(category: category),
                                );
                          },
                        );
                      },
                    )
                  else if (_selectedType == ContentType.movie || _selectedType == ContentType.music)
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
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (modalContext) => BlocProvider.value(
                          value: context.read<LibraryBloc>(),
                          child: BlocBuilder<LibraryBloc, LibraryState>(
                            builder: (context, state) {
                              return FilterBottomSheet(
                                contentType: _selectedType.name,
                                selectedEmotion: state.selectedEmotion,
                                showOnlyFavorites: state.showOnlyFavorites,
                                onEmotionSelected: (emotion) {
                                  context.read<LibraryBloc>().add(
                                        SearchContent(
                                          type: _selectedType.name,
                                          emotion: emotion,
                                          query: _searchQuery.isNotEmpty ? _searchQuery : null,
                                        ),
                                      );
                                },
                                onFavoritesToggled: (showFavorites) {
                                  context.read<LibraryBloc>().add(
                                        ToggleFavoritesFilter(showOnlyFavorites: showFavorites),
                                      );
                                },
                                onClearFilters: () {
                                  context.read<LibraryBloc>().add(
                                        SearchContent(
                                          type: _selectedType.name,
                                          showOnlyFavorites: false,
                                        ),
                                      );
                                },
                              );
                            },
                          ),
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
            floatingActionButton: _buildFloatingActionButton(context, libraryState),
          );
            },
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

            final isSelectionMode = _isPsychologist && state.selectedContentIds.isNotEmpty;

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
                  final isSelected = state.selectedContentIds.contains(contentUi.content.externalId);

                  return ContentCard(
                    contentUi: contentUi,
                    isSelected: isSelected,
                    isSelectionMode: isSelectionMode,
                    isPsychologist: _isPsychologist,
                    onFavoriteClick: () {
                      context.read<LibraryBloc>().add(
                            ToggleFavorite(content: contentUi.content),
                          );
                    },
                    onTap: () async {
                      if (_isPsychologist) {
                        context.read<LibraryBloc>().add(
                              ToggleContentSelection(contentId: contentUi.content.externalId),
                            );
                        return;
                      }

                      if (isSelectionMode) {
                        context.read<LibraryBloc>().add(
                              ToggleContentSelection(contentId: contentUi.content.externalId),
                            );
                        return;
                      }

                      final content = contentUi.content;

                      if (content.isVideo) {
                        final youtubeUrl = content.youtubeUrl;

                        if (youtubeUrl != null && youtubeUrl.isNotEmpty) {
                          final uri = Uri.parse(youtubeUrl);
                          if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('No se pudo abrir YouTube')),
                              );
                            }
                          }
                        } else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Este video no tiene URL de YouTube')),
                            );
                          }
                        }
                      } else if (content.isMusic) {
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
                    onLongPress: () {
                      if (_isPsychologist) {
                        context.read<LibraryBloc>().add(
                              ToggleContentSelection(contentId: contentUi.content.externalId),
                            );
                      }
                    },
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

  Widget _buildFloatingActionButton(BuildContext context, LibraryState libraryState) {
    if (!_isPsychologist || libraryState.selectedContentIds.isEmpty) {
      return const SizedBox.shrink();
    }

    return FloatingActionButton.extended(
      onPressed: () async {
        await _loadPatients();
        if (context.mounted) {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (bottomSheetContext) => AssignPatientBottomSheet(
            selectedCount: libraryState.selectedContentIds.length,
            patients: _patients,
            isLoading: _patientsLoading,
            errorMessage: _patientsError,
            onPatientSelected: (patientId, patientName) {
              _assignContent(context, context.read<LibraryBloc>(), patientId, patientName);
            },
            onDismiss: () {
              Navigator.pop(bottomSheetContext);
            },
            onRetry: _loadPatients,
          ),
        );
        }
      },
      backgroundColor: green49,
      icon: const Icon(Icons.assignment, color: black),
      label: Text(
        'Asignar (${libraryState.selectedContentIds.length})',
        style: sourceSansSemiBold.copyWith(color: black, fontSize: 15),
      ),
    );
  }
}
