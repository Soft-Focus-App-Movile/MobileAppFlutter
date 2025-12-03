class AssignedPsychologist {
  final String id;
  final String fullName;
  final String? profileImageUrl;
  final String? professionalBio;
  final List<String>? specialties;

  AssignedPsychologist({
    required this.id,
    required this.fullName,
    this.profileImageUrl,
    this.professionalBio,
    this.specialties,
  });
}
