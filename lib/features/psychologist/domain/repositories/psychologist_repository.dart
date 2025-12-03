import '../models/invitation_code.dart';
import '../models/psychologist_stats.dart';

abstract class PsychologistRepository {
  Future<InvitationCode> getInvitationCode();
  Future<PsychologistStats> getStats({String? fromDate, String? toDate});
}
