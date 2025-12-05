class PatientProfile {
  final String id;
  final String fullName;
  final String profilePhotoUrl;
  final String? dateOfBirth;
  final String createdAt;

  const PatientProfile({
    required this.id,
    required this.fullName,
    required this.profilePhotoUrl,
    this.dateOfBirth,
    required this.createdAt
  });
}