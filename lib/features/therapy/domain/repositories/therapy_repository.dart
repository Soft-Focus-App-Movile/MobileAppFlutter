import '../../../../core/common/result.dart';
import '../models/therapeutic_relationship.dart';
import '../models/patient_directory_item.dart';
import '../models/chat_message.dart';

abstract class TherapyRepository {
  Future<Result<TherapeuticRelationship?>> getMyRelationship();
  Future<Result<String>> getRelationshipWithPatient(String patientId);
  Future<Result<String>> connectWithPsychologist(String connectionCode);
  Future<Result<List<PatientDirectoryItem>>> getPatientDirectory();
  Future<Result<List<ChatMessage>>> getChatHistory(String relationshipId, int page, int size);
  Future<Result<ChatMessage?>> getLastReceivedMessage();
  Future<Result<ChatMessage>> sendMessage(String relationshipId, String receiverId, String content, String messageType);
  
  // Método para inicializar/escuchar sockets
  Future<void> initializeChatSocket({required Function(ChatMessage) onMessageReceived});
  Future<void> disconnectChatSocket();
}
