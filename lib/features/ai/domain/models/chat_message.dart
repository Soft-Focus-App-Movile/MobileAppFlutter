import 'message_role.dart';
import 'exercise_recommendation.dart';

class ChatMessage {
  final MessageRole role;
  final String content;
  final DateTime timestamp;
  final List<String> suggestedQuestions;
  final List<ExerciseRecommendation> recommendedExercises;
  final bool crisisDetected;

  const ChatMessage({
    required this.role,
    required this.content,
    required this.timestamp,
    this.suggestedQuestions = const [],
    this.recommendedExercises = const [],
    this.crisisDetected = false,
  });
}
