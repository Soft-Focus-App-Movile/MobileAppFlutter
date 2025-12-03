class InvitationCode {
  final String code;
  final String expiresAt;
  final String timeUntilExpiration;

  InvitationCode({
    required this.code,
    required this.expiresAt,
    required this.timeUntilExpiration,
  });
}
