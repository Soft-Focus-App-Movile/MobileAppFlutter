import 'dart:convert';
import '../../../../core/common/result.dart';
import '../../domain/models/therapeutic_relationship.dart';
import '../../domain/repositories/therapy_repository.dart';
import '../services/therapy_service.dart';
import '../models/request/connect_with_psychologist_request_dto.dart';
import '../../domain/models/patient_directory_item.dart';
import '../../domain/models/chat_message.dart';
import '../models/request/send_chat_message_request_dto.dart';
import '../services/chat_signalr_service.dart';

class TherapyRepositoryImpl implements TherapyRepository {
  final TherapyService _therapyService;
  final ChatSignalRService _signalRService;

  TherapyRepositoryImpl({
    required TherapyService service,
    ChatSignalRService? signalRService,  
  })
      : _therapyService = service,
        _signalRService = signalRService ?? ChatSignalRService();

  @override
  Future<Result<TherapeuticRelationship?>> getMyRelationship() async {
    try {
      final response = await _therapyService.getMyRelationship();

      if (response.hasRelationship && response.relationship != null) {
        final relationship = response.relationship!.toDomain();
        return Success(relationship);
      } else {
        return Success(null);
      }
    } catch (e) {
      final errorMessage = _extractErrorMessage(e);
      return Error(errorMessage);
    }
  }

  @override
  Future<Result<String>> getRelationshipWithPatient(String patientId) async {
    try {
      final response = await _therapyService.getRelationshipWithPatient(patientId);
      return Success(response.relationshipId);
    } catch (e) {
      final errorMessage = _extractErrorMessage(e);
      return Error(errorMessage);
    }
  }

  @override
  Future<Result<String>> connectWithPsychologist(String connectionCode) async {
    try {
      final request = ConnectWithPsychologistRequestDto(
        connectionCode: connectionCode,
      );
      final response = await _therapyService.connectWithPsychologist(request);
      return Success(response.relationshipId);
    } catch (e) {
      final errorMessage = _extractErrorMessage(e);
      return Error(errorMessage);
    }
  }

  @override
  Future<Result<List<PatientDirectoryItem>>> getPatientDirectory() async {
    try {
      final response = await _therapyService.getPatientDirectory();
      final directory = response.map((dto) => dto.toDomain()).toList();
      return Success(directory);
    } catch (e) {
      final errorMessage = _extractErrorMessage(e);
      return Error(errorMessage);
    }
  }

  @override
  Future<Result<List<ChatMessage>>> getChatHistory(String relationshipId, int page, int size) async {
    try {
      final dtos = await _therapyService.getChatHistory(relationshipId, page: page, size: size);
      final messages = dtos.map((e) => e.toDomain()).toList();
      return Success(messages);
    } catch (e) {
      return Error(_extractErrorMessage(e));
    }
  }

  @override
  Future<Result<ChatMessage?>> getLastReceivedMessage() async {
    try {
      final dto = await _therapyService.getLastReceivedMessage();
      return Success(dto?.toDomain());
    } catch (e) {
      return Error(_extractErrorMessage(e));
    }
  }

  @override
  Future<Result<ChatMessage>> sendMessage(
      String relationshipId, String receiverId, String content, String messageType) async {
    try {
      final request = SendChatMessageRequestDto(
        relationshipId: relationshipId,
        receiverId: receiverId,
        content: content,
        messageType: messageType,
      );
      final dto = await _therapyService.sendChatMessage(request);
      return Success(dto.toDomain());
    } catch (e) {
      return Error(_extractErrorMessage(e));
    }
  }

  @override
  Future<void> initializeChatSocket({required Function(ChatMessage) onMessageReceived}) async {
    // 1. Configurar el callback
    _signalRService.onMessageReceived = (dto) {
      onMessageReceived(dto.toDomain());
    };

    // 2. Obtener el token del servicio HTTP
    // Asegúrate de que en therapy_service.dart hayas agregado: String? get authToken => _httpClient.token;
    final token = _therapyService.authToken; 

    if (token != null && token.isNotEmpty) {
      // 3. Pasar el token al método connect
      await _signalRService.connect(token);
    } else {
      print("Error: No auth token available for SignalR connection");
    }
  }

  @override
  Future<void> disconnectChatSocket() async {
    await _signalRService.disconnect();
  }

  /// Extract error message from exception
  String _extractErrorMessage(dynamic error) {
    final errorString = error.toString();

    // Try to parse JSON error response
    try {
      if (errorString.contains('{') && errorString.contains('}')) {
        final jsonStart = errorString.indexOf('{');
        final jsonEnd = errorString.lastIndexOf('}') + 1;
        final jsonString = errorString.substring(jsonStart, jsonEnd);
        final jsonMap = jsonDecode(jsonString);

        if (jsonMap['message'] != null) {
          return jsonMap['message'];
        }
      }
    } catch (e) {
      // If JSON parsing fails, return the original error
    }

    // Extract message after "Exception: " or "failed: "
    if (errorString.contains('Exception: ')) {
      return errorString.split('Exception: ').last;
    } else if (errorString.contains('failed: ')) {
      return errorString.split('failed: ').last;
    }

    return 'An error occurred: $errorString';
  }
}
