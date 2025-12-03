import 'dart:io';

abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final String? firstName;
  final String? lastName;
  final String? dateOfBirth;
  final String? gender;
  final String? phone;
  final String? bio;
  final String? country;
  final String? city;
  final List<String>? interests;
  final List<String>? mentalHealthGoals;
  final bool? emailNotifications;
  final bool? pushNotifications;
  final bool? isProfilePublic;
  final File? profileImageFile;

  UpdateProfile({
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.gender,
    this.phone,
    this.bio,
    this.country,
    this.city,
    this.interests,
    this.mentalHealthGoals,
    this.emailNotifications,
    this.pushNotifications,
    this.isProfilePublic,
    this.profileImageFile,
  });
}

class UpdateProfessionalProfile extends ProfileEvent {
  final String? professionalBio;
  final bool? isAcceptingNewPatients;
  final int? maxPatientsCapacity;
  final List<String>? targetAudience;
  final List<String>? languages;
  final String? businessName;
  final String? businessAddress;
  final String? bankAccount;
  final String? paymentMethods;
  final bool? isProfileVisibleInDirectory;
  final bool? allowsDirectMessages;

  UpdateProfessionalProfile({
    this.professionalBio,
    this.isAcceptingNewPatients,
    this.maxPatientsCapacity,
    this.targetAudience,
    this.languages,
    this.businessName,
    this.businessAddress,
    this.bankAccount,
    this.paymentMethods,
    this.isProfileVisibleInDirectory,
    this.allowsDirectMessages,
  });
}

class DisconnectPsychologist extends ProfileEvent {
  final Function() onSuccess;

  DisconnectPsychologist({required this.onSuccess});
}
