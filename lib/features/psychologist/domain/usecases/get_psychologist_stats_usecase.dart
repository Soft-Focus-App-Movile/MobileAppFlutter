import '../models/psychologist_stats.dart';
import '../repositories/psychologist_repository.dart';

class GetPsychologistStatsUseCase {
  final PsychologistRepository repository;

  GetPsychologistStatsUseCase(this.repository);

  Future<PsychologistStats> call() async {
    return repository.getStats();
  }
}
