import '../../../../core/common/result.dart';
import '../models/chat_message.dart';
import '../repositories/therapy_repository.dart';

class GetLastReceivedMessageUseCase {
  final TherapyRepository _repository;

  GetLastReceivedMessageUseCase(this._repository);

  Future<Result<ChatMessage?>> call() async {
    return await _repository.getLastReceivedMessage();
  }
}