import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/request/change_user_status_request_dto.dart';
import '../models/request/verify_psychologist_request_dto.dart';
import '../models/response/psychologist_detail_response_dto.dart';
import '../models/response/user_list_response_dto.dart';

class AdminService {
  final Dio dio;

  const AdminService(this.dio);

  Future<UserListResponseDto> getAllUsers({
    int page = 1,
    int pageSize = 20,
    String? userType,
    bool? isActive,
    bool? isVerified,
    String? searchTerm,
    String? sortBy,
    bool sortDescending = false,
  }) async {
    final response = await dio.get(
      UsersEndpoints.base,
      queryParameters: {
        'page': page,
        'pageSize': pageSize,
        if (userType != null) 'userType': userType,
        if (isActive != null) 'isActive': isActive,
        if (isVerified != null) 'isVerified': isVerified,
        if (searchTerm != null) 'searchTerm': searchTerm,
        if (sortBy != null) 'sortBy': sortBy,
        'sortDescending': sortDescending,
      },
    );
    return UserListResponseDto.fromJson(response.data as Map<String, dynamic>);
  }

  Future<PsychologistDetailResponseDto> getUserDetail(String userId) async {
    final response = await dio.get(
      UsersEndpoints.getById(userId),
    );
    return PsychologistDetailResponseDto.fromJson(
        response.data as Map<String, dynamic>);
  }

  Future<void> verifyPsychologist(
    String userId,
    VerifyPsychologistRequestDto request,
  ) async {
    await dio.put(
      UsersEndpoints.verifyPsychologistById(userId),
      data: request.toJson(),
    );
  }

  Future<void> changeUserStatus(
    String userId,
    ChangeUserStatusRequestDto request,
  ) async {
    await dio.put(
      UsersEndpoints.changeStatusById(userId),
      data: request.toJson(),
    );
  }
}
