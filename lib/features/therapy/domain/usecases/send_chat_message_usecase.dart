import '../../../../core/common/result.dart';
import '../models/chat_message.dart';
import '../repositories/therapy_repository.dart';

class SendChatMessageUseCase {
  final TherapyRepository _repository;

  SendChatMessageUseCase(this._repository);

  Future<Result<ChatMessage>> call({
    required String relationshipId,
    required String receiverId,
    required String content,
    String messageType = 'text',
  }) async {
    return await _repository.sendMessage(relationshipId, receiverId, content, messageType);
  }
}