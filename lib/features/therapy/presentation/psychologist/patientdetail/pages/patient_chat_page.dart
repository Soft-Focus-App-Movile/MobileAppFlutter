// lib/features/therapy/presentation/psychologist/patientdetail/pages/patient_chat_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/ui/colors.dart';
import '../../../../../../core/ui/text_styles.dart';
import '../../../../../../core/widgets/profile_avatar.dart';
import '../blocs/patient_chat_bloc.dart';
import '../blocs/patient_chat_event.dart';
import '../blocs/patient_chat_state.dart';
import '../widgets/chat_bubble.dart';
import '../../../../../../core/ui/components/navigation/psychologist_scaffold.dart';

class PatientChatPage extends StatefulWidget {
  final String patientId;
  final String patientName;
  final String? patientProfileUrl;

  const PatientChatPage({
    super.key,
    required this.patientId,
    required this.patientName,
    this.patientProfileUrl,
  });

  @override
  State<PatientChatPage> createState() => _PatientChatPageState();
}

class _PatientChatPageState extends State<PatientChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<PatientChatBloc>().add(
          InitializePatientChat(
            patientId: widget.patientId,
            patientName: widget.patientName,
            patientProfileUrl: widget.patientProfileUrl,
          ),
        );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final content = _messageController.text.trim();
    if (content.isEmpty) return;

    context.read<PatientChatBloc>().add(
          SendChatMessage(
            patientId: widget.patientId,
            content: content,
          ),
        );

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: BlocBuilder<PatientChatBloc, PatientChatState>(
              builder: (context, state) {
                if (state.isLoading && state.messages.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state.error != null && state.messages.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Error: ${state.error}',
                        style: sourceSansRegular.copyWith(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                return _buildMessageList(state);
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: yellowCB9D,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 16,
        right: 16,
        bottom: 10,
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: white),
            onPressed: () {
              // Lógica corregida para volver al Detalle manteniendo el BottomNav
              final scaffoldState = context.findAncestorStateOfType<PsychologistScaffoldState>();
              if (scaffoldState != null) {
                scaffoldState.showPatientDetail(widget.patientId);
              } else {
                // Fallback por si se usa fuera del scaffold
                Navigator.of(context).pop();
              }
            },
          ),
          const SizedBox(width: 12),
          ProfileAvatar(
            imageUrl: widget.patientProfileUrl ?? '',
            fullName: widget.patientName,
            size: 44,
            fontSize: 18,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              widget.patientName,
              style: crimsonSemiBold.copyWith(
                fontSize: 23,
                color: white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList(PatientChatState state) {
    return BlocBuilder<PatientChatBloc, PatientChatState>(
      builder: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients && state.messages.isNotEmpty) {
            _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });

        return ListView.separated(
          controller: _scrollController,
          reverse: true,
          padding: const EdgeInsets.all(16),
          itemCount: state.messages.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final message = state.messages[index];
            final bloc = context.read<PatientChatBloc>();
            
            return ChatBubble(
              message: message,
              time: bloc.formatTimestamp(message.timestamp),
              // CAMBIA ESTO:
              // psychologistId: bloc._psychologistId,
              // POR ESTO:
              psychologistId: bloc.psychologistId,
            );
          },
        );
      },
    );
  }

  Widget _buildMessageInput() {
    return Container(
      color: white,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Escribe un mensaje...',
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              style: sourceSansRegular,
              maxLines: null,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF9BA9B0),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: white),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}