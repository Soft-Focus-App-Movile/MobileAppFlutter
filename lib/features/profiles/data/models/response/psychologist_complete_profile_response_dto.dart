import 'package:json_annotation/json_annotation.dart';
import '../../../domain/models/psychologist_profile.dart';

part 'psychologist_complete_profile_response_dto.g.dart';

@JsonSerializable()
class PsychologistCompleteProfileResponseDto {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'fullName')
  final String fullName;

  @JsonKey(name: 'firstName')
  final String? firstName;

  @JsonKey(name: 'lastName')
  final String? lastName;

  @JsonKey(name: 'userType')
  final String? userType;

  @JsonKey(name: 'dateOfBirth')
  final String? dateOfBirth;

  @JsonKey(name: 'gender')
  final String? gender;

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'profileImageUrl')
  final String? profileImageUrl;

  @JsonKey(name: 'bio')
  final String? bio;

  @JsonKey(name: 'country')
  final String? country;

  @JsonKey(name: 'city')
  final String? city;

  @JsonKey(name: 'interests')
  final List<String>? interests;

  @JsonKey(name: 'mentalHealthGoals')
  final List<String>? mentalHealthGoals;

  @JsonKey(name: 'emailNotifications', defaultValue: true)
  final bool emailNotifications;

  @JsonKey(name: 'pushNotifications', defaultValue: true)
  final bool pushNotifications;

  @JsonKey(name: 'isProfilePublic', defaultValue: false)
  final bool isProfilePublic;

  @JsonKey(name: 'isActive', defaultValue: true)
  final bool isActive;

  @JsonKey(name: 'lastLogin')
  final String? lastLogin;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  @JsonKey(name: 'licenseNumber')
  final String? licenseNumber;

  @JsonKey(name: 'professionalCollege')
  final String? professionalCollege;

  @JsonKey(name: 'collegeRegion')
  final String? collegeRegion;

  @JsonKey(name: 'specialties')
  final List<String>? specialties;

  @JsonKey(name: 'yearsOfExperience')
  final int? yearsOfExperience;

  @JsonKey(name: 'university')
  final String? university;

  @JsonKey(name: 'graduationYear')
  final int? graduationYear;

  @JsonKey(name: 'degree')
  final String? degree;

  @JsonKey(name: 'licenseDocumentUrl')
  final String? licenseDocumentUrl;

  @JsonKey(name: 'diplomaCertificateUrl')
  final String? diplomaCertificateUrl;

  @JsonKey(name: 'identityDocumentUrl')
  final String? identityDocumentUrl;

  @JsonKey(name: 'additionalCertificatesUrls')
  final List<String>? additionalCertificatesUrls;

  @JsonKey(name: 'isVerified', defaultValue: false)
  final bool isVerified;

  @JsonKey(name: 'verificationDate')
  final String? verificationDate;

  @JsonKey(name: 'verifiedBy')
  final String? verifiedBy;

  @JsonKey(name: 'verificationNotes')
  final String? verificationNotes;

  @JsonKey(name: 'professionalBio')
  final String? professionalBio;

  @JsonKey(name: 'isAcceptingNewPatients', defaultValue: true)
  final bool isAcceptingNewPatients;

  @JsonKey(name: 'maxPatientsCapacity')
  final int? maxPatientsCapacity;

  @JsonKey(name: 'currentPatientsCount')
  final int? currentPatientsCount;

  @JsonKey(name: 'targetAudience')
  final List<String>? targetAudience;

  @JsonKey(name: 'languages')
  final List<String>? languages;

  @JsonKey(name: 'businessName')
  final String? businessName;

  @JsonKey(name: 'businessAddress')
  final String? businessAddress;

  @JsonKey(name: 'bankAccount')
  final String? bankAccount;

  @JsonKey(name: 'paymentMethods')
  final String? paymentMethods;

  @JsonKey(name: 'currency')
  final String? currency;

  @JsonKey(name: 'isProfileVisibleInDirectory', defaultValue: true)
  final bool isProfileVisibleInDirectory;

  @JsonKey(name: 'allowsDirectMessages', defaultValue: true)
  final bool allowsDirectMessages;

  @JsonKey(name: 'averageRating')
  final double? averageRating;

  @JsonKey(name: 'totalReviews')
  final int? totalReviews;

  PsychologistCompleteProfileResponseDto({
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

  factory PsychologistCompleteProfileResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PsychologistCompleteProfileResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PsychologistCompleteProfileResponseDtoToJson(this);

  PsychologistProfile toDomain() {
    return PsychologistProfile(
      id: id,
      email: email,
      fullName: fullName,
      firstName: firstName,
      lastName: lastName,
      userType: userType,
      dateOfBirth: dateOfBirth,
      gender: gender,
      phone: phone,
      profileImageUrl: profileImageUrl,
      bio: bio,
      country: country,
      city: city,
      interests: interests,
      mentalHealthGoals: mentalHealthGoals,
      emailNotifications: emailNotifications,
      pushNotifications: pushNotifications,
      isProfilePublic: isProfilePublic,
      isActive: isActive,
      lastLogin: lastLogin,
      createdAt: createdAt,
      updatedAt: updatedAt,
      licenseNumber: licenseNumber,
      professionalCollege: professionalCollege,
      collegeRegion: collegeRegion,
      specialties: specialties,
      yearsOfExperience: yearsOfExperience,
      university: university,
      graduationYear: graduationYear,
      degree: degree,
      licenseDocumentUrl: licenseDocumentUrl,
      diplomaCertificateUrl: diplomaCertificateUrl,
      identityDocumentUrl: identityDocumentUrl,
      additionalCertificatesUrls: additionalCertificatesUrls,
      isVerified: isVerified,
      verificationDate: verificationDate,
      verifiedBy: verifiedBy,
      verificationNotes: verificationNotes,
      professionalBio: professionalBio,
      isAcceptingNewPatients: isAcceptingNewPatients,
      maxPatientsCapacity: maxPatientsCapacity,
      currentPatientsCount: currentPatientsCount,
      targetAudience: targetAudience,
      languages: languages,
      businessName: businessName,
      businessAddress: businessAddress,
      bankAccount: bankAccount,
      paymentMethods: paymentMethods,
      currency: currency,
      isProfileVisibleInDirectory: isProfileVisibleInDirectory,
      allowsDirectMessages: allowsDirectMessages,
      averageRating: averageRating,
      totalReviews: totalReviews,
    );
  }
}
