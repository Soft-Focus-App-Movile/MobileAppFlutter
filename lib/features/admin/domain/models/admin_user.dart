class AdminUser {
  final String id;
  final String email;
  final String fullName;
  final String userType;
  final bool isActive;
  final String? lastLogin;
  final String createdAt;
  final bool? isVerified;

  const AdminUser({
    required this.id,
    required this.email,
    required this.fullName,
    required this.userType,
    required this.isActive,
    this.lastLogin,
    required this.createdAt,
    this.isVerified,
  });
}
