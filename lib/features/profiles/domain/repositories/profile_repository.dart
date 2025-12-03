import 'dart:io';
import '../../../../features/auth/domain/models/user.dart';
import '../models/assigned_psychologist.dart';
import '../models/psychologist_profile.dart';

abstract class ProfileRepository {
  Future<User> getProfile();
  Future<PsychologistProfile> getPsychologistCompleteProfile();
  Future<AssignedPsychologist?> getAssignedPsychologist();
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
  });
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
  });
}
