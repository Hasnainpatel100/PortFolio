import 'package:equatable/equatable.dart';

/// Events for the Chatbot BLoC
abstract class ChatbotEvent extends Equatable {
  const ChatbotEvent();

  @override
  List<Object?> get props => [];
}

/// Toggle the chat window open/close
class ToggleChatWindow extends ChatbotEvent {
  const ToggleChatWindow();
}

/// Send a message from the user
class SendMessage extends ChatbotEvent {
  final String message;

  const SendMessage(this.message);

  @override
  List<Object?> get props => [message];
}

/// Select a quick reply suggestion
class SelectSuggestion extends ChatbotEvent {
  final String suggestion;

  const SelectSuggestion(this.suggestion);

  @override
  List<Object?> get props => [suggestion];
}

/// Clear all chat messages
class ClearChat extends ChatbotEvent {
  const ClearChat();
}
