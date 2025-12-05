import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
// 1. SOLUCIÓN: Usamos SOLO el import con alias para evitar conflictos con 'Error' de Dart
import '../../../../../../core/common/result.dart' as common;
import '../../../../domain/usecases/get_patient_profile_usecase.dart';
import '../../../../domain/usecases/get_relationship_with_patient_usecase.dart';
import '../../../../domain/usecases/get_chat_history_usecase.dart';
import '../../../../domain/usecases/send_chat_message_usecase.dart';
import '../../../../domain/repositories/therapy_repository.dart';
import '../../../../domain/models/chat_message.dart'; 
import '../../../../../auth/data/local/user_session.dart';
import 'patient_chat_event.dart';
import 'patient_chat_state.dart';

class PatientChatBloc extends Bloc<PatientChatEvent, PatientChatState> {
  final GetPatientProfileUseCase _getPatientProfileUseCase;
  final GetRelationshipWithPatientUseCase _getRelationshipWithPatientUseCase;
  final GetChatHistoryUseCase _getChatHistoryUseCase;
  final SendChatMessageUseCase _sendChatMessageUseCase;
  final TherapyRepository _therapyRepository;
  final UserSession _userSession;
  final DateFormat _timeFormatter = DateFormat('h:mm a', 'es_ES');

  String? _relationshipId;
  String? _psychologistId;
  
  // Getter público para que la UI pueda acceder al ID (arregla error en patient_chat_page)
  String? get psychologistId => _psychologistId;

  PatientChatBloc({
    required GetPatientProfileUseCase getPatientProfileUseCase,
    required GetRelationshipWithPatientUseCase getRelationshipWithPatientUseCase,
    required GetChatHistoryUseCase getChatHistoryUseCase,
    required SendChatMessageUseCase sendChatMessageUseCase,
    required TherapyRepository therapyRepository,
    required UserSession userSession,
  })  : _getPatientProfileUseCase = getPatientProfileUseCase,
        _getRelationshipWithPatientUseCase = getRelationshipWithPatientUseCase,
        _getChatHistoryUseCase = getChatHistoryUseCase,
        _sendChatMessageUseCase = sendChatMessageUseCase,
        _therapyRepository = therapyRepository,
        _userSession = userSession,
        super(const PatientChatState()) {
    on<InitializePatientChat>(_onInitialize);
    on<LoadChatHistory>(_onLoadChatHistory);
    on<SendChatMessage>(_onSendMessage);
    on<ReceiveNewMessage>(_onReceiveNewMessage);
  }

  Future<void> _onInitialize(
    InitializePatientChat event,
    Emitter<PatientChatState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final user = await _userSession.getUser();
      _psychologistId = user?.id;

      if (_psychologistId == null) {
        emit(state.copyWith(
          isLoading: false,
          error: 'Error: No se pudo obtener el ID del psicólogo.',
        ));
        return;
      }

      final profileResult = await _getPatientProfileUseCase(event.patientId);
      
      // Usamos el alias 'common'
      if (profileResult is common.Error) {
        emit(state.copyWith(
          isLoading: false,
          error: (profileResult as common.Error).message,
        ));
        return;
      }

      final profile = (profileResult as common.Success).data;

      final relationshipResult = await _getRelationshipWithPatientUseCase(event.patientId);
      
      if (relationshipResult is common.Error) {
        emit(state.copyWith(
          isLoading: false,
          error: (relationshipResult as common.Error).message,
        ));
        return;
      }

      _relationshipId = (relationshipResult as common.Success).data;

      emit(state.copyWith(
        isLoading: false,
        patientName: profile.fullName,
        patientProfileUrl: profile.profilePhotoUrl,
      ));

      await _therapyRepository.initializeChatSocket(
        onMessageReceived: (message) {
          add(ReceiveNewMessage(message: message));
        },
      );

      add(LoadChatHistory());
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onLoadChatHistory(
    LoadChatHistory event,
    Emitter<PatientChatState> emit,
  ) async {
    if (_relationshipId == null) return;

    emit(state.copyWith(isLoading: true));

    final result = await _getChatHistoryUseCase(
      _relationshipId!,
      page: 1,
      size: 50,
    );

    switch (result) {
      case common.Success():
        // Aseguramos que la lista sea de tipo ChatMessage
        final List<ChatMessage> messages = result.data.map((msg) {
          return msg.copyWith(
            senderId: msg.senderId,
            receiverId: msg.receiverId,
          );
        }).toList();

        emit(state.copyWith(
          isLoading: false,
          messages: messages,
          error: null,
        ));

      case common.Error():
        emit(state.copyWith(
          isLoading: false,
          error: result.message,
        ));
    }
  }

  Future<void> _onSendMessage(
    SendChatMessage event,
    Emitter<PatientChatState> emit,
  ) async {
    if (_relationshipId == null || _psychologistId == null) return;
    if (event.content.trim().isEmpty) return;

    // 2. SOLUCIÓN: Creamos un objeto ChatMessage real, no un Mapa
    final localMessage = _createLocalMessage(
      content: event.content,
      senderId: _psychologistId!,
      receiverId: event.patientId,
    );

    emit(state.copyWith(
      messages: [localMessage, ...state.messages],
    ));

    final result = await _sendChatMessageUseCase(
      relationshipId: _relationshipId!,
      receiverId: event.patientId,
      content: event.content,
      messageType: 'text',
    );

    if (result is common.Error) {
      emit(state.copyWith(
        error: 'Error al enviar: ${result.toString()})}',
      ));
    }
  }

  void _onReceiveNewMessage(
    ReceiveNewMessage event,
    Emitter<PatientChatState> emit,
  ) {
    if (event.message.senderId != _psychologistId) {
      emit(state.copyWith(
        messages: [event.message, ...state.messages],
      ));
    }
  }

  // 2. SOLUCIÓN (Continuación): Esta función ahora devuelve ChatMessage
  ChatMessage _createLocalMessage({
    required String content,
    required String senderId,
    required String receiverId,
  }) {
    return ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      relationshipId: _relationshipId ?? '',
      senderId: senderId,
      receiverId: receiverId,
      content: content,
      timestamp: DateTime.now(),
      isRead: false,
      messageType: 'text',
    );
  }

  String formatTimestamp(DateTime timestamp) {
    return _timeFormatter.format(timestamp);
  }

  @override
  Future<void> close() {
    _therapyRepository.disconnectChatSocket();
    return super.close();
  }
}

// 3. SOLUCIÓN: Hemos eliminado la extensión problemática que estaba aquí abajo