import 'package:equatable/equatable.dart';
import '../../../domain/models/admin_user.dart';
import '../../../domain/models/pagination_info.dart';

abstract class AdminUsersState extends Equatable {
  const AdminUsersState();

  @override
  List<Object?> get props => [];
}

class AdminUsersInitial extends AdminUsersState {
  const AdminUsersInitial();
}

class AdminUsersLoading extends AdminUsersState {
  const AdminUsersLoading();
}

class AdminUsersLoaded extends AdminUsersState {
  final List<AdminUser> users;
  final PaginationInfo? paginationInfo;
  final String searchTerm;
  final String? filterUserType;
  final bool? filterIsVerified;

  const AdminUsersLoaded({
    required this.users,
    this.paginationInfo,
    this.searchTerm = '',
    this.filterUserType,
    this.filterIsVerified,
  });

  AdminUsersLoaded copyWith({
    List<AdminUser>? users,
    PaginationInfo? paginationInfo,
    String? searchTerm,
    String? filterUserType,
    bool? filterIsVerified,
  }) {
    return AdminUsersLoaded(
      users: users ?? this.users,
      paginationInfo: paginationInfo ?? this.paginationInfo,
      searchTerm: searchTerm ?? this.searchTerm,
      filterUserType: filterUserType ?? this.filterUserType,
      filterIsVerified: filterIsVerified ?? this.filterIsVerified,
    );
  }

  @override
  List<Object?> get props => [
        users,
        paginationInfo,
        searchTerm,
        filterUserType,
        filterIsVerified,
      ];
}

class AdminUsersError extends AdminUsersState {
  final String message;

  const AdminUsersError(this.message);

  @override
  List<Object?> get props => [message];
}
