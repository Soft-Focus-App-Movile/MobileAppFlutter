import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/admin_repository.dart';
import 'admin_users_event.dart';
import 'admin_users_state.dart';

class AdminUsersBloc extends Bloc<AdminUsersEvent, AdminUsersState> {
  final AdminRepository _repository;

  int _currentPage = 1;
  String? _filterUserType;
  bool? _filterIsVerified;
  String _searchTerm = '';

  AdminUsersBloc(this._repository) : super(const AdminUsersInitial()) {
    on<LoadUsers>(_onLoadUsers);
    on<SetFilterUserType>(_onSetFilterUserType);
    on<SetFilterIsVerified>(_onSetFilterIsVerified);
    on<UpdateSearchTerm>(_onUpdateSearchTerm);
    on<SearchUsers>(_onSearchUsers);
    on<NextPage>(_onNextPage);
    on<PreviousPage>(_onPreviousPage);
    on<ClearError>(_onClearError);

    // Load initial users
    add(const LoadUsers());
  }

  Future<void> _onLoadUsers(
    LoadUsers event,
    Emitter<AdminUsersState> emit,
  ) async {
    emit(const AdminUsersLoading());

    try {
      final (users, pagination) = await _repository.getAllUsers(
        page: _currentPage,
        pageSize: 20,
        userType: _filterUserType,
        isActive: null,
        isVerified: _filterIsVerified,
        searchTerm: _searchTerm.isEmpty ? null : _searchTerm,
        sortBy: null,
        sortDescending: false,
      );

      emit(AdminUsersLoaded(
        users: users,
        paginationInfo: pagination,
        searchTerm: _searchTerm,
        filterUserType: _filterUserType,
        filterIsVerified: _filterIsVerified,
      ));
    } catch (e) {
      emit(AdminUsersError(e.toString()));
    }
  }

  Future<void> _onSetFilterUserType(
    SetFilterUserType event,
    Emitter<AdminUsersState> emit,
  ) async {
    _filterUserType = event.userType;
    _currentPage = 1;
    add(const LoadUsers());
  }

  Future<void> _onSetFilterIsVerified(
    SetFilterIsVerified event,
    Emitter<AdminUsersState> emit,
  ) async {
    _filterIsVerified = event.isVerified;
    _currentPage = 1;
    add(const LoadUsers());
  }

  void _onUpdateSearchTerm(
    UpdateSearchTerm event,
    Emitter<AdminUsersState> emit,
  ) {
    _searchTerm = event.searchTerm;
  }

  Future<void> _onSearchUsers(
    SearchUsers event,
    Emitter<AdminUsersState> emit,
  ) async {
    _currentPage = 1;
    add(const LoadUsers());
  }

  Future<void> _onNextPage(
    NextPage event,
    Emitter<AdminUsersState> emit,
  ) async {
    if (state is AdminUsersLoaded) {
      final currentState = state as AdminUsersLoaded;
      if (currentState.paginationInfo?.hasNextPage == true) {
        _currentPage++;
        add(const LoadUsers());
      }
    }
  }

  Future<void> _onPreviousPage(
    PreviousPage event,
    Emitter<AdminUsersState> emit,
  ) async {
    if (state is AdminUsersLoaded) {
      final currentState = state as AdminUsersLoaded;
      if (currentState.paginationInfo?.hasPreviousPage == true) {
        _currentPage--;
        add(const LoadUsers());
      }
    }
  }

  void _onClearError(
    ClearError event,
    Emitter<AdminUsersState> emit,
  ) {
    emit(const AdminUsersInitial());
  }
}
