class VerifyPsychologistRequestDto {
  final bool isApproved;
  final String? notes;

  const VerifyPsychologistRequestDto({
    required this.isApproved,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'isApproved': isApproved,
      'notes': notes,
    };
  }
}
