abstract class PsychologistProfileEvent {}

class LoadPsychologistProfile extends PsychologistProfileEvent {}

class UpdatePsychologistProfile extends PsychologistProfileEvent {
  final String? firstName;
  final String? lastName;
  final String? dateOfBirth;
  final String? professionalBio;
  final String? businessName;
  final String? businessAddress;
  final String? bankAccount;
  final String? paymentMethods;
  final int? maxPatientsCapacity;
  final List<String>? languages;
  final List<String>? targetAudience;
  final bool? isAcceptingNewPatients;
  final bool? isProfileVisibleInDirectory;
  final bool? allowsDirectMessages;

  UpdatePsychologistProfile({
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.professionalBio,
    this.businessName,
    this.businessAddress,
    this.bankAccount,
    this.paymentMethods,
    this.maxPatientsCapacity,
    this.languages,
    this.targetAudience,
    this.isAcceptingNewPatients,
    this.isProfileVisibleInDirectory,
    this.allowsDirectMessages,
  });
}

class LogoutRequested extends PsychologistProfileEvent {}