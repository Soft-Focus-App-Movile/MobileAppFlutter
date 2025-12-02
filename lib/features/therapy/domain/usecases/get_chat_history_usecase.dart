import '../../../../core/common/result.dart';
import '../models/chat_message.dart';
import '../repositories/therapy_repository.dart';

class GetChatHistoryUseCase {
  final TherapyRepository _repository;

  GetChatHistoryUseCase(this._repository);

  Future<Result<List<ChatMessage>>> call(String relationshipId, {int page = 1, int size = 20}) async {
    return await _repository.getChatHistory(relationshipId, page, size);
  }
}