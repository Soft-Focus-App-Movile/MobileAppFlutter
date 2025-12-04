class PsychologistProfile {
  final String id;
  final String email;
  final String fullName;
  final String? firstName;
  final String? lastName;
  final String? userType;
  final String? dateOfBirth;
  final String? gender;
  final String? phone;
  final String? profileImageUrl;
  final String? bio;
  final String? country;
  final String? city;
  final List<String>? interests;
  final List<String>? mentalHealthGoals;
  final bool emailNotifications;
  final bool pushNotifications;
  final bool isProfilePublic;
  final bool isActive;
  final String? lastLogin;
  final String? createdAt;
  final String? updatedAt;

  final String? licenseNumber;
  final String? professionalCollege;
  final String? collegeRegion;
  final List<String>? specialties;
  final int? yearsOfExperience;
  final String? university;
  final int? graduationYear;
  final String? degree;
  final String? licenseDocumentUrl;
  final String? diplomaCertificateUrl;
  final String? identityDocumentUrl;
  final List<String>? additionalCertificatesUrls;
  final bool isVerified;
  final String? verificationDate;
  final String? verifiedBy;
  final String? verificationNotes;

  final String? professionalBio;
  final bool isAcceptingNewPatients;
  final int? maxPatientsCapacity;
  final int? currentPatientsCount;
  final List<String>? targetAudience;
  final List<String>? languages;
  final String? businessName;
  final String? businessAddress;
  final String? bankAccount;
  final String? paymentMethods;
  final String? currency;
  final bool isProfileVisibleInDirectory;
  final bool allowsDirectMessages;
  final double? averageRating;
  final int? totalReviews;

  PsychologistProfile({
    required this.id,
    required this.email,
    required this.fullName,
    this.firstName,
    this.lastName,
    this.userType,
    this.dateOfBirth,
    this.gender,
    this.phone,
    this.profileImageUrl,
    this.bio,
    this.country,
    this.city,
    this.interests,
    this.mentalHealthGoals,
    this.emailNotifications = true,
    this.pushNotifications = true,
    this.isProfilePublic = false,
    this.isActive = true,
    this.lastLogin,
    this.createdAt,
    this.updatedAt,
    this.licenseNumber,
    this.professionalCollege,
    this.collegeRegion,
    this.specialties,
    this.yearsOfExperience,
    this.university,
    this.graduationYear,
    this.degree,
    this.licenseDocumentUrl,
    this.diplomaCertificateUrl,
    this.identityDocumentUrl,
    this.additionalCertificatesUrls,
    this.isVerified = false,
    this.verificationDate,
    this.verifiedBy,
    this.verificationNotes,
    this.professionalBio,
    this.isAcceptingNewPatients = true,
    this.maxPatientsCapacity,
    this.currentPatientsCount,
    this.targetAudience,
    this.languages,
    this.businessName,
    this.businessAddress,
    this.bankAccount,
    this.paymentMethods,
    this.currency,
    this.isProfileVisibleInDirectory = true,
    this.allowsDirectMessages = true,
    this.averageRating,
    this.totalReviews,
  });
}
