import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/status.dart';
import '../../../auth/data/local/user_session.dart';
import '../../../auth/domain/models/user_type.dart';
import '../../data/services/content_search_service.dart';
import '../../data/services/favorites_service.dart';
import '../../data/services/assignments_service.dart';
import '../blocs/library/library_bloc.dart';
import '../blocs/library/library_event.dart';
import '../blocs/library/library_state.dart';
import '../blocs/favorites/favorites_bloc.dart';
import '../blocs/assignments/assignments_bloc.dart';
import '../widgets/content_card.dart';
import '../widgets/favorites_tab.dart';
import '../widgets/assignments_tab.dart';
import 'content_detail_page.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  UserType? _userType;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserType();
  }

  Future<void> _loadUserType() async {
    final userSession = UserSession();
    final user = await userSession.getUser();
    setState(() {
      _userType = user?.userType ?? UserType.GENERAL;
      _isLoading = false;
    });

    final tabCount = _getTabCount();
    _tabController = TabController(length: tabCount, vsync: this);
  }

  int _getTabCount() {
    if (_userType == UserType.PATIENT) return 3;
    return 2;
  }

  @override
  void dispose() {
    if (!_isLoading) {
      _tabController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LibraryBloc(
            contentSearchService: ContentSearchService(),
          )..add(const SearchContent(type: 'movie')),
        ),
        BlocProvider(
          create: (context) => FavoritesBloc(
            favoritesService: FavoritesService(),
          ),
        ),
        if (_userType == UserType.PATIENT)
          BlocProvider(
            create: (context) => AssignmentsBloc(
              assignmentsService: AssignmentsService(),
            ),
          ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Biblioteca'),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              const Tab(text: 'Explorar', icon: Icon(Icons.explore)),
              const Tab(text: 'Favoritos', icon: Icon(Icons.favorite)),
              if (_userType == UserType.PATIENT)
                const Tab(text: 'Asignado', icon: Icon(Icons.assignment)),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildExploreTab(),
            const FavoritesTab(),
            if (_userType == UserType.PATIENT) const AssignmentsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildExploreTab() {
    return Column(
      children: [
        BlocBuilder<LibraryBloc, LibraryState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    _buildTypeChip(context, 'movie', 'Películas', state.selectedType),
                    const SizedBox(width: 8),
                    _buildTypeChip(context, 'music', 'Música', state.selectedType),
                    const SizedBox(width: 8),
                    _buildTypeChip(context, 'video', 'Videos', state.selectedType),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
            );
          },
        ),
        Expanded(
          child: BlocBuilder<LibraryBloc, LibraryState>(
            builder: (context, state) {
              switch (state.status) {
                case Status.loading:
                  return const Center(child: CircularProgressIndicator());

                case Status.failure:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 48, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(state.message ?? 'Error al cargar contenido'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<LibraryBloc>().add(
                                  SearchContent(type: state.selectedType),
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
                      child: Text('No se encontró contenido'),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<LibraryBloc>().add(
                            SearchContent(type: state.selectedType),
                          );
                    },
                    child: ListView.builder(
                      itemCount: state.contents.length,
                      itemBuilder: (context, index) {
                        final contentUi = state.contents[index];
                        return ContentCard(
                          contentUi: contentUi,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContentDetailPage(
                                  content: contentUi.content,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );

                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTypeChip(
    BuildContext context,
    String type,
    String label,
    String selectedType,
  ) {
    final isSelected = type == selectedType;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          context.read<LibraryBloc>().add(SearchContent(type: type));
        }
      },
    );
  }
}
