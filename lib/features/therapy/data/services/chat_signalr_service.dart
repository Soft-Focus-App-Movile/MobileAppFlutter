import 'package:signalr_netcore/signalr_client.dart';
import '../models/response/chat_message_response_dto.dart';

class ChatSignalRService {
  HubConnection? _hubConnection;

  // Callback para cuando llega un mensaje
  Function(ChatMessageResponseDto)? onMessageReceived;

  ChatSignalRService();

  /// Inicia la conexión recibiendo el token explícitamente
  Future<void> connect(String token) async {
    if (token.isEmpty) {
      print('SignalR: No token provided');
      return;
    }

    const hubUrl = 'http://98.90.172.251:5000/chatHub'; 

    _hubConnection = HubConnectionBuilder()
        .withUrl(hubUrl, options: HttpConnectionOptions(
          accessTokenFactory: () async => token,
        ))
        .withAutomaticReconnect()
        .build();

    _hubConnection?.on('ReceiveMessage', (arguments) {
      if (arguments != null && arguments.isNotEmpty) {
        try {
           // El backend envía el mensaje como primer argumento
           // Verifica si llega como mapa directo o string JSON
           final messageData = arguments[0];
           if (messageData is Map<String, dynamic>) {
             final messageDto = ChatMessageResponseDto.fromJson(messageData);
             if (onMessageReceived != null) onMessageReceived!(messageDto);
           } else {
             print("SignalR: Formato de mensaje inesperado: $messageData");
           }
        } catch (e) {
          print("SignalR: Error parsing message: $e");
        }
      }
    });

    try {
      await _hubConnection?.start();
      print('SignalR Connected to $hubUrl');
    } catch (e) {
      print('Error connecting to SignalR: $e');
    }
  }

  Future<void> disconnect() async {
    await _hubConnection?.stop();
    _hubConnection = null;
  }
}