import '../../domain/models/admin_user.dart';
import '../../domain/models/pagination_info.dart';
import '../../domain/models/psychologist_detail.dart';
import '../../domain/repositories/admin_repository.dart';
import '../models/request/change_user_status_request_dto.dart';
import '../models/request/verify_psychologist_request_dto.dart';
import '../remote/admin_service.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminService _adminService;

  const AdminRepositoryImpl(this._adminService);

  @override
  Future<(List<AdminUser>, PaginationInfo)> getAllUsers({
    required int page,
    required int pageSize,
    String? userType,
    bool? isActive,
    bool? isVerified,
    String? searchTerm,
    String? sortBy,
    required bool sortDescending,
  }) async {
    try {
      final response = await _adminService.getAllUsers(
        page: page,
        pageSize: pageSize,
        userType: userType,
        isActive: isActive,
        isVerified: isVerified,
        searchTerm: searchTerm,
        sortBy: sortBy,
        sortDescending: sortDescending,
      );
      return response.toDomain();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PsychologistDetail> getPsychologistDetail(String userId) async {
    try {
      final response = await _adminService.getUserDetail(userId);
      return response.toDomain();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> verifyPsychologist({
    required String userId,
    required bool isApproved,
    String? notes,
  }) async {
    try {
      final request = VerifyPsychologistRequestDto(
        isApproved: isApproved,
        notes: notes,
      );
      await _adminService.verifyPsychologist(userId, request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> changeUserStatus({
    required String userId,
    required bool isActive,
    String? reason,
  }) async {
    try {
      final request = ChangeUserStatusRequestDto(
        isActive: isActive,
        reason: reason,
      );
      await _adminService.changeUserStatus(userId, request);
    } catch (e) {
      rethrow;
    }
  }
}
