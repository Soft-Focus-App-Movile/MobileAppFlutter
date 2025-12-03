class ChangeUserStatusRequestDto {
  final bool isActive;
  final String? reason;

  const ChangeUserStatusRequestDto({
    required this.isActive,
    this.reason,
  });

  Map<String, dynamic> toJson() {
    return {
      'isActive': isActive,
      'reason': reason,
    };
  }
}
