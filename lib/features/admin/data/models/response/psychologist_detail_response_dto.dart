import '../../../domain/models/psychologist_detail.dart';

class PsychologistDetailResponseDto {
  final UserDetailDto user;
  final PsychologistDataDto psychologistData;

  const PsychologistDetailResponseDto({
    required this.user,
    required this.psychologistData,
  });

  factory PsychologistDetailResponseDto.fromJson(Map<String, dynamic> json) {
    return PsychologistDetailResponseDto(
      user: UserDetailDto.fromJson(json['user'] as Map<String, dynamic>),
      psychologistData: PsychologistDataDto.fromJson(
          json['psychologistData'] as Map<String, dynamic>),
    );
  }

  PsychologistDetail toDomain() {
    return PsychologistDetail(
      id: user.id,
      email: user.email,
      fullName: user.fullName,
      firstName: user.firstName,
      lastName: user.lastName,
      userType: user.userType,
      phone: user.phone,
      profileImageUrl: user.profileImageUrl,
      isActive: user.isActive,
      createdAt: user.createdAt,
      licenseNumber: psychologistData.licenseNumber,
      professionalCollege: psychologistData.professionalCollege,
      collegeRegion: psychologistData.collegeRegion,
      university: psychologistData.university,
      graduationYear: psychologistData.graduationYear,
      specialties: psychologistData.specialties
          .map((e) => Specialty(name: e))
          .toList(),
      yearsOfExperience: psychologistData.yearsOfExperience,
      isVerified: psychologistData.isVerified,
      verificationDate: psychologistData.verificationDate,
      verifiedBy: psychologistData.verifiedBy,
      verificationNotes: psychologistData.verificationNotes,
      licenseDocumentUrl: psychologistData.documents.licenseDocumentUrl,
      diplomaCertificateUrl: psychologistData.documents.diplomaCertificateUrl,
      identityDocumentUrl: psychologistData.documents.identityDocumentUrl,
      additionalCertificatesUrls:
          psychologistData.documents.additionalCertificatesUrls,
    );
  }
}

class UserDetailDto {
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

  const UserDetailDto({
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
  });

  factory UserDetailDto.fromJson(Map<String, dynamic> json) {
    return UserDetailDto(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      userType: json['userType'] as String,
      phone: json['phone'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      isActive: json['isActive'] as bool,
      createdAt: json['createdAt'] as String,
    );
  }
}

class PsychologistDataDto {
  final String licenseNumber;
  final String professionalCollege;
  final String? collegeRegion;
  final String? university;
  final int? graduationYear;
  final List<String> specialties;
  final int yearsOfExperience;
  final bool isVerified;
  final String? verificationDate;
  final String? verifiedBy;
  final String? verificationNotes;
  final DocumentsDto documents;

  const PsychologistDataDto({
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
    required this.documents,
  });

  factory PsychologistDataDto.fromJson(Map<String, dynamic> json) {
    return PsychologistDataDto(
      licenseNumber: json['licenseNumber'] as String,
      professionalCollege: json['professionalCollege'] as String,
      collegeRegion: json['collegeRegion'] as String?,
      university: json['university'] as String?,
      graduationYear: json['graduationYear'] as int?,
      specialties: (json['specialties'] as List).cast<String>(),
      yearsOfExperience: json['yearsOfExperience'] as int,
      isVerified: json['isVerified'] as bool,
      verificationDate: json['verificationDate'] as String?,
      verifiedBy: json['verifiedBy'] as String?,
      verificationNotes: json['verificationNotes'] as String?,
      documents:
          DocumentsDto.fromJson(json['documents'] as Map<String, dynamic>),
    );
  }
}

class DocumentsDto {
  final String? licenseDocumentUrl;
  final String? diplomaCertificateUrl;
  final String? identityDocumentUrl;
  final List<String>? additionalCertificatesUrls;

  const DocumentsDto({
    this.licenseDocumentUrl,
    this.diplomaCertificateUrl,
    this.identityDocumentUrl,
    this.additionalCertificatesUrls,
  });

  factory DocumentsDto.fromJson(Map<String, dynamic> json) {
    return DocumentsDto(
      licenseDocumentUrl: json['licenseDocumentUrl'] as String?,
      diplomaCertificateUrl: json['diplomaCertificateUrl'] as String?,
      identityDocumentUrl: json['identityDocumentUrl'] as String?,
      additionalCertificatesUrls: json['additionalCertificatesUrls'] != null
          ? (json['additionalCertificatesUrls'] as List).cast<String>()
          : null,
    );
  }
}
