// lib/features/therapy/presentation/psychologist/patientdetail/widgets/chat_bubble.dart
import 'package:flutter/material.dart';
import '../../../../../../core/ui/colors.dart';
import '../../../../../../core/ui/text_styles.dart';
import '../../../../domain/models/chat_message.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final String time;
  final String? psychologistId;

  const ChatBubble({
    super.key,
    required this.message,
    required this.time,
    this.psychologistId,
  });

  bool get _isFromMe => message.senderId == psychologistId;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: _isFromMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          color: _isFromMe 
              ? const Color(0xFFE0F7E0) 
              : white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: _isFromMe 
                ? const Radius.circular(16) 
                : Radius.zero,
            bottomRight: _isFromMe 
                ? Radius.zero 
                : const Radius.circular(16),
          ),
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.content,
              style: sourceSansRegular.copyWith(
                fontSize: 15,
                color: black,
              ),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                time,
                style: sourceSansRegular.copyWith(
                  fontSize: 12,
                  color: gray808,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}