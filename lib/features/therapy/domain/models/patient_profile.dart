class PatientProfile {
  final String id;
  final String fullName;
  final String profilePhotoUrl;
  final String? dateOfBirth;
  // Puedes agregar más campos aquí si tu UI los necesita (ej. bio, email, etc.)

  const PatientProfile({
    required this.id,
    required this.fullName,
    required this.profilePhotoUrl,
    this.dateOfBirth,
  });
}