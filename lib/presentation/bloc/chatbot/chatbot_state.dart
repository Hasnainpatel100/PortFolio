import 'package:equatable/equatable.dart';
import '../../../core/models/chat_message.dart';

/// State for the Chatbot BLoC
class ChatbotState extends Equatable {
  final bool isOpen;
  final List<ChatMessage> messages;
  final bool isTyping;
  final List<String> suggestions;

  const ChatbotState({
    this.isOpen = false,
    this.messages = const [],
    this.isTyping = false,
    this.suggestions = const [],
  });

  ChatbotState copyWith({
    bool? isOpen,
    List<ChatMessage>? messages,
    bool? isTyping,
    List<String>? suggestions,
  }) {
    return ChatbotState(
      isOpen: isOpen ?? this.isOpen,
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
      suggestions: suggestions ?? this.suggestions,
    );
  }

  @override
  List<Object?> get props => [isOpen, messages, isTyping, suggestions];
}
