import '../models/admin_user.dart';
import '../models/pagination_info.dart';
import '../models/psychologist_detail.dart';

abstract class AdminRepository {
  Future<(List<AdminUser>, PaginationInfo)> getAllUsers({
    required int page,
    required int pageSize,
    String? userType,
    bool? isActive,
    bool? isVerified,
    String? searchTerm,
    String? sortBy,
    required bool sortDescending,
  });

  Future<PsychologistDetail> getPsychologistDetail(String userId);

  Future<void> verifyPsychologist({
    required String userId,
    required bool isApproved,
    String? notes,
  });

  Future<void> changeUserStatus({
    required String userId,
    required bool isActive,
    String? reason,
  });
}
