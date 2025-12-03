import '../../../domain/models/admin_user.dart';
import '../../../domain/models/pagination_info.dart';

class UserListResponseDto {
  final List<UserItemDto> users;
  final PaginationDto pagination;
  final FiltersDto filters;

  const UserListResponseDto({
    required this.users,
    required this.pagination,
    required this.filters,
  });

  factory UserListResponseDto.fromJson(Map<String, dynamic> json) {
    return UserListResponseDto(
      users: (json['users'] as List)
          .map((e) => UserItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: PaginationDto.fromJson(json['pagination'] as Map<String, dynamic>),
      filters: FiltersDto.fromJson(json['filters'] as Map<String, dynamic>),
    );
  }

  (List<AdminUser>, PaginationInfo) toDomain() {
    final adminUsers = users.map((e) => e.toDomain()).toList();
    final paginationInfo = pagination.toDomain();
    return (adminUsers, paginationInfo);
  }
}

class UserItemDto {
  final String id;
  final String email;
  final String fullName;
  final String userType;
  final bool isActive;
  final String? lastLogin;
  final String createdAt;
  final bool? isVerified;

  const UserItemDto({
    required this.id,
    required this.email,
    required this.fullName,
    required this.userType,
    required this.isActive,
    this.lastLogin,
    required this.createdAt,
    this.isVerified,
  });

  factory UserItemDto.fromJson(Map<String, dynamic> json) {
    return UserItemDto(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      userType: json['userType'] as String,
      isActive: json['isActive'] as bool,
      lastLogin: json['lastLogin'] as String?,
      createdAt: json['createdAt'] as String,
      isVerified: json['isVerified'] as bool?,
    );
  }

  AdminUser toDomain() {
    return AdminUser(
      id: id,
      email: email,
      fullName: fullName,
      userType: userType,
      isActive: isActive,
      lastLogin: lastLogin,
      createdAt: createdAt,
      isVerified: isVerified,
    );
  }
}

class PaginationDto {
  final int page;
  final int pageSize;
  final int totalCount;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const PaginationDto({
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  factory PaginationDto.fromJson(Map<String, dynamic> json) {
    return PaginationDto(
      page: json['page'] as int,
      pageSize: json['pageSize'] as int,
      totalCount: json['totalCount'] as int,
      totalPages: json['totalPages'] as int,
      hasNextPage: json['hasNextPage'] as bool,
      hasPreviousPage: json['hasPreviousPage'] as bool,
    );
  }

  PaginationInfo toDomain() {
    return PaginationInfo(
      page: page,
      pageSize: pageSize,
      totalCount: totalCount,
      totalPages: totalPages,
      hasNextPage: hasNextPage,
      hasPreviousPage: hasPreviousPage,
    );
  }
}

class FiltersDto {
  final String? userType;
  final bool? isActive;
  final bool? isVerified;
  final String? searchTerm;
  final String? sortBy;
  final bool sortDescending;

  const FiltersDto({
    this.userType,
    this.isActive,
    this.isVerified,
    this.searchTerm,
    this.sortBy,
    required this.sortDescending,
  });

  factory FiltersDto.fromJson(Map<String, dynamic> json) {
    return FiltersDto(
      userType: json['userType'] as String?,
      isActive: json['isActive'] as bool?,
      isVerified: json['isVerified'] as bool?,
      searchTerm: json['searchTerm'] as String?,
      sortBy: json['sortBy'] as String?,
      sortDescending: json['sortDescending'] as bool,
    );
  }
}
