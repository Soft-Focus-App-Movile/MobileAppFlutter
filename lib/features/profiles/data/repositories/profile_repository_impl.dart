import 'dart:convert';
import 'dart:io';
import '../../../../core/common/result.dart';
import '../../../../features/auth/data/local/user_session.dart';
import '../../../../features/auth/domain/models/user.dart';
import '../../../therapy/domain/repositories/therapy_repository.dart';
import '../../../therapy/domain/models/therapeutic_relationship.dart';
import '../../domain/models/assigned_psychologist.dart';
import '../../domain/models/psychologist_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../remote/profile_service.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileService _profileService;
  final TherapyRepository _therapyRepository;
  final UserSession _userSession;

  ProfileRepositoryImpl({
    required ProfileService service,
    required TherapyRepository therapyRepository,
    required UserSession userSession,
  })  : _profileService = service,
        _therapyRepository = therapyRepository,
        _userSession = userSession;

  @override
  Future<User> getProfile() async {
    try {
      final response = await _profileService.getProfile();
      final currentUser = await _userSession.getUser();
      final currentToken = currentUser?.token;
      final user = response.toDomain(currentToken);
      await _userSession.saveUser(user);
      return user;
    } catch (e) {
      throw Exception('Error al obtener perfil: ${_extractErrorMessage(e)}');
    }
  }

  @override
  Future<PsychologistProfile> getPsychologistCompleteProfile() async {
    try {
      final response = await _profileService.getPsychologistCompleteProfile();
      final psychologistProfile = response.toDomain();
      return psychologistProfile;
    } catch (e) {
      throw Exception(
          'Error al obtener perfil de psicólogo: ${_extractErrorMessage(e)}');
    }
  }

  @override
  Future<AssignedPsychologist?> getAssignedPsychologist() async {
    try {
      final relationshipResult = await _therapyRepository.getMyRelationship();

      print('🔍 getAssignedPsychologist - relationshipResult type: ${relationshipResult.runtimeType}');

      if (relationshipResult is Success) {
        final relationship = (relationshipResult as Success<TherapeuticRelationship?>).data;

        print('🔍 relationship: $relationship');
        print('🔍 relationship?.isActive: ${relationship?.isActive}');

        if (relationship != null && relationship.isActive) {
          final psychologistId = relationship.psychologistId;
          print('🔍 psychologistId: $psychologistId');

          print('🔍 About to fetch psychologist by ID...');
          final psychologistProfileDto =
              await _profileService.getPsychologistById(psychologistId);

          print('🔍 psychologistProfileDto obtained: ${psychologistProfileDto.id}');
          print('🔍 DTO fields check:');
          print('  - fullName: ${psychologistProfileDto.fullName}');
          print('  - email: ${psychologistProfileDto.email}');
          print('  - userType: ${psychologistProfileDto.userType}');
          print('  - licenseNumber: ${psychologistProfileDto.licenseNumber}');
          print('  - professionalCollege: ${psychologistProfileDto.professionalCollege}');
          print('  - specialties: ${psychologistProfileDto.specialties}');
          print('  - yearsOfExperience: ${psychologistProfileDto.yearsOfExperience}');
          print('🔍 Converting DTO to domain...');

          final psychologistProfile = psychologistProfileDto.toDomain();

          print('🔍 psychologistProfile converted successfully');
          print('🔍 id: ${psychologistProfile.id}');
          print('🔍 fullName: ${psychologistProfile.fullName}');
          print('🔍 profileImageUrl: ${psychologistProfile.profileImageUrl}');
          print('🔍 professionalBio: ${psychologistProfile.professionalBio}');
          print('🔍 specialties: ${psychologistProfile.specialties}');

          final assignedPsychologist = AssignedPsychologist(
            id: psychologistProfile.id,
            fullName: psychologistProfile.fullName,
            profileImageUrl: psychologistProfile.profileImageUrl,
            professionalBio: psychologistProfile.professionalBio,
            specialties: psychologistProfile.specialties,
          );

          print('✅ assignedPsychologist created: ${assignedPsychologist.fullName}');
          return assignedPsychologist;
        } else {
          print('❌ No active relationship found');
          return null;
        }
      } else {
        print('❌ relationshipResult is not Success');
        return null;
      }
    } catch (e) {
      print('❌ ERROR in getAssignedPsychologist: $e');
      return null;
    }
  }

  @override
  Future<User> updateProfile({
    String? firstName,
    String? lastName,
    String? dateOfBirth,
    String? gender,
    String? phone,
    String? bio,
    String? country,
    String? city,
    List<String>? interests,
    List<String>? mentalHealthGoals,
    bool? emailNotifications,
    bool? pushNotifications,
    bool? isProfilePublic,
    File? profileImageFile,
  }) async {
    try {
      final response = await _profileService.updateProfileWithImage(
        firstName: firstName,
        lastName: lastName,
        dateOfBirth: dateOfBirth,
        gender: gender,
        phone: phone,
        bio: bio,
        country: country,
        city: city,
        interests: interests,
        mentalHealthGoals: mentalHealthGoals,
        emailNotifications: emailNotifications,
        pushNotifications: pushNotifications,
        isProfilePublic: isProfilePublic,
        profileImageFile: profileImageFile,
      );

      final currentUser = await _userSession.getUser();
      final currentToken = currentUser?.token;
      final user = response.toDomain(currentToken);
      await _userSession.saveUser(user);
      return user;
    } catch (e) {
      throw Exception(
          'Error al actualizar perfil: ${_extractErrorMessage(e)}');
    }
  }

  @override
  Future<void> updateProfessionalProfile({
    String? professionalBio,
    bool? isAcceptingNewPatients,
    int? maxPatientsCapacity,
    List<String>? targetAudience,
    List<String>? languages,
    String? businessName,
    String? businessAddress,
    String? bankAccount,
    String? paymentMethods,
    bool? isProfileVisibleInDirectory,
    bool? allowsDirectMessages,
  }) async {
    try {
      final professionalData = <String, dynamic>{};

      if (professionalBio != null) {
        professionalData['professionalBio'] = professionalBio;
      }
      if (isAcceptingNewPatients != null) {
        professionalData['isAcceptingNewPatients'] = isAcceptingNewPatients;
      }
      if (maxPatientsCapacity != null) {
        professionalData['maxPatientsCapacity'] = maxPatientsCapacity;
      }
      if (targetAudience != null) {
        professionalData['targetAudience'] = targetAudience;
      }
      if (languages != null) {
        professionalData['languages'] = languages;
      }
      if (businessName != null) {
        professionalData['businessName'] = businessName;
      }
      if (businessAddress != null) {
        professionalData['businessAddress'] = businessAddress;
      }
      if (bankAccount != null) {
        professionalData['bankAccount'] = bankAccount;
      }
      if (paymentMethods != null) {
        professionalData['paymentMethods'] = paymentMethods;
      }
      if (isProfileVisibleInDirectory != null) {
        professionalData['isProfileVisibleInDirectory'] =
            isProfileVisibleInDirectory;
      }
      if (allowsDirectMessages != null) {
        professionalData['allowsDirectMessages'] = allowsDirectMessages;
      }

      await _profileService.updateProfessionalProfile(professionalData);
    } catch (e) {
      throw Exception(
          'Error al actualizar perfil profesional: ${_extractErrorMessage(e)}');
    }
  }

  String _extractErrorMessage(dynamic error) {
    final errorString = error.toString();

    try {
      if (errorString.contains('{') && errorString.contains('}')) {
        final jsonStart = errorString.indexOf('{');
        final jsonEnd = errorString.lastIndexOf('}') + 1;
        final jsonString = errorString.substring(jsonStart, jsonEnd);
        final jsonMap = jsonDecode(jsonString);

        if (jsonMap['message'] != null) {
          return jsonMap['message'];
        }
      }
    } catch (e) {
    }

    if (errorString.contains('Exception: ')) {
      return errorString.split('Exception: ').last;
    } else if (errorString.contains('failed: ')) {
      return errorString.split('failed: ').last;
    }

    return 'An error occurred: $errorString';
  }
}
