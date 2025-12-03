class PsychologistDetail {
  final String id;
  final String email;
  final String fullName;
  final String? firstName;
  final String? lastName;
  final String userType;
  final String? phone;
  final String? profileImageUrl;
  final bool isActive;
  final String createdAt;
  final String licenseNumber;
  final String professionalCollege;
  final String? collegeRegion;
  final String? university;
  final int? graduationYear;
  final List<Specialty> specialties;
  final int yearsOfExperience;
  final bool isVerified;
  final String? verificationDate;
  final String? verifiedBy;
  final String? verificationNotes;
  final String? licenseDocumentUrl;
  final String? diplomaCertificateUrl;
  final String? identityDocumentUrl;
  final List<String>? additionalCertificatesUrls;

  const PsychologistDetail({
    required this.id,
    required this.email,
    required this.fullName,
    this.firstName,
    this.lastName,
    required this.userType,
    this.phone,
    this.profileImageUrl,
    required this.isActive,
    required this.createdAt,
    required this.licenseNumber,
    required this.professionalCollege,
    this.collegeRegion,
    this.university,
    this.graduationYear,
    required this.specialties,
    required this.yearsOfExperience,
    required this.isVerified,
    this.verificationDate,
    this.verifiedBy,
    this.verificationNotes,
    this.licenseDocumentUrl,
    this.diplomaCertificateUrl,
    this.identityDocumentUrl,
    this.additionalCertificatesUrls,
  });
}

class Specialty {
  final String name;

  const Specialty({required this.name});
}
