import '../../domain/models/invitation_code.dart';
import '../../domain/models/psychologist_stats.dart';
import '../../domain/repositories/psychologist_repository.dart';
import '../remote/psychologist_service.dart';

class PsychologistRepositoryImpl implements PsychologistRepository {
  final PsychologistService psychologistService;

  PsychologistRepositoryImpl({required this.psychologistService});

  @override
  Future<InvitationCode> getInvitationCode() async {
    try {
      final response = await psychologistService.getInvitationCode();
      return response.toDomain();
    } catch (e) {
      throw Exception('Error al obtener código de invitación: $e');
    }
  }

  @override
  Future<PsychologistStats> getStats({String? fromDate, String? toDate}) async {
    try {
      final response = await psychologistService.getStats(
        fromDate: fromDate,
        toDate: toDate,
      );
      return response.toDomain();
    } catch (e) {
      throw Exception('Error al obtener estadísticas: $e');
    }
  }
}
