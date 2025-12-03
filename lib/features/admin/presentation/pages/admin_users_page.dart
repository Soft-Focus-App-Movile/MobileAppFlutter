import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/ui/colors.dart';
import '../../../../core/ui/text_styles.dart';
import '../../domain/models/admin_user.dart';
import '../blocs/admin_users/admin_users_bloc.dart';
import '../blocs/admin_users/admin_users_event.dart';
import '../blocs/admin_users/admin_users_state.dart';

class AdminUsersPage extends StatefulWidget {
  final Function(String userId) onNavigateToVerify;
  final VoidCallback onLogout;

  const AdminUsersPage({
    super.key,
    required this.onNavigateToVerify,
    required this.onLogout,
  });

  @override
  State<AdminUsersPage> createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Gestión de Usuarios',
                    style: crimsonSemiBold.copyWith(
                      fontSize: 28,
                      color: green49,
                    ),
                  ),
                  IconButton(
                    onPressed: widget.onLogout,
                    icon: const Icon(Icons.logout, color: green49),
                    tooltip: 'Cerrar sesión',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              BlocBuilder<AdminUsersBloc, AdminUsersState>(
                builder: (context, state) {
                  return TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar por nombre o email',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search, color: green37),
                        onPressed: () {
                          context.read<AdminUsersBloc>().add(
                                UpdateSearchTerm(_searchController.text),
                              );
                          context.read<AdminUsersBloc>().add(const SearchUsers());
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: grayE0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: green37),
                      ),
                    ),
                    onSubmitted: (value) {
                      context.read<AdminUsersBloc>().add(
                            UpdateSearchTerm(value),
                          );
                      context.read<AdminUsersBloc>().add(const SearchUsers());
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              BlocBuilder<AdminUsersBloc, AdminUsersState>(
                builder: (context, state) {
                  final filterUserType = state is AdminUsersLoaded
                      ? state.filterUserType
                      : null;
                  return Wrap(
                    spacing: 8,
                    children: [
                      FilterChip(
                        label: const Text('Todos'),
                        selected: filterUserType == null,
                        onSelected: (_) {
                          context
                              .read<AdminUsersBloc>()
                              .add(const SetFilterUserType(null));
                        },
                      ),
                      FilterChip(
                        label: const Text('Psicólogos'),
                        selected: filterUserType == 'Psychologist',
                        onSelected: (_) {
                          context
                              .read<AdminUsersBloc>()
                              .add(const SetFilterUserType('Psychologist'));
                        },
                      ),
                      FilterChip(
                        label: const Text('Generales'),
                        selected: filterUserType == 'General',
                        onSelected: (_) {
                          context
                              .read<AdminUsersBloc>()
                              .add(const SetFilterUserType('General'));
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 8),
              BlocBuilder<AdminUsersBloc, AdminUsersState>(
                builder: (context, state) {
                  final filterIsVerified = state is AdminUsersLoaded
                      ? state.filterIsVerified
                      : null;
                  return Wrap(
                    spacing: 8,
                    children: [
                      FilterChip(
                        label: const Text('Todos'),
                        selected: filterIsVerified == null,
                        onSelected: (_) {
                          context
                              .read<AdminUsersBloc>()
                              .add(const SetFilterIsVerified(null));
                        },
                      ),
                      FilterChip(
                        label: const Text('No verificados'),
                        selected: filterIsVerified == false,
                        onSelected: (_) {
                          context
                              .read<AdminUsersBloc>()
                              .add(const SetFilterIsVerified(false));
                        },
                      ),
                      FilterChip(
                        label: const Text('Verificados'),
                        selected: filterIsVerified == true,
                        onSelected: (_) {
                          context
                              .read<AdminUsersBloc>()
                              .add(const SetFilterIsVerified(true));
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<AdminUsersBloc, AdminUsersState>(
                  builder: (context, state) {
                    if (state is AdminUsersLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: green49),
                      );
                    }

                    if (state is AdminUsersError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: sourceSansRegular.copyWith(color: Colors.red),
                        ),
                      );
                    }

                    if (state is AdminUsersLoaded) {
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.users.length,
                              itemBuilder: (context, index) {
                                return _UserItem(
                                  user: state.users[index],
                                  onTap: () {
                                    if (state.users[index].userType ==
                                            'Psychologist' &&
                                        state.users[index].isVerified == false) {
                                      widget.onNavigateToVerify(
                                          state.users[index].id);
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                          if (state.paginationInfo != null)
                            _PaginationControls(
                              paginationInfo: state.paginationInfo!,
                            ),
                        ],
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserItem extends StatelessWidget {
  final AdminUser user;
  final VoidCallback onTap;

  const _UserItem({
    required this.user,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName,
                      style: sourceSansBold.copyWith(
                        fontSize: 16,
                        color: black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.email,
                      style: sourceSansRegular.copyWith(
                        fontSize: 14,
                        color: gray828,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: user.userType == 'Psychologist'
                          ? green37.withOpacity(0.2)
                          : grayE0,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      user.userType == 'Psychologist'
                          ? 'Psicólogo'
                          : user.userType == 'General'
                              ? 'General'
                              : user.userType,
                      style: sourceSansRegular.copyWith(
                        fontSize: 12,
                        color: user.userType == 'Psychologist'
                            ? green49
                            : gray828,
                      ),
                    ),
                  ),
                  if (user.userType == 'Psychologist' &&
                      user.isVerified != null) ...[
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: user.isVerified == true
                            ? green37.withOpacity(0.2)
                            : yellowEB.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        user.isVerified == true ? 'Verificado' : 'Pendiente',
                        style: sourceSansRegular.copyWith(
                          fontSize: 12,
                          color: user.isVerified == true ? green49 : black,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaginationControls extends StatelessWidget {
  final dynamic paginationInfo;

  const _PaginationControls({required this.paginationInfo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: paginationInfo.hasPreviousPage
                ? () {
                    context.read<AdminUsersBloc>().add(const PreviousPage());
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: green49,
              disabledBackgroundColor: grayE0,
            ),
            child: Text(
              'Anterior',
              style: sourceSansRegular.copyWith(color: Colors.white),
            ),
          ),
          Text(
            'Página ${paginationInfo.page} de ${paginationInfo.totalPages}',
            style: sourceSansRegular.copyWith(fontSize: 14),
          ),
          ElevatedButton(
            onPressed: paginationInfo.hasNextPage
                ? () {
                    context.read<AdminUsersBloc>().add(const NextPage());
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: green49,
              disabledBackgroundColor: grayE0,
            ),
            child: Text(
              'Siguiente',
              style: sourceSansRegular.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
