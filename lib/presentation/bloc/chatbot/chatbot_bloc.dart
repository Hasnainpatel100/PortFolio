import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/chatbot_knowledge_base.dart';
import '../../../core/models/chat_message.dart';
import 'chatbot_event.dart';
import 'chatbot_state.dart';

/// BLoC for managing chatbot state
class ChatbotBloc extends Bloc<ChatbotEvent, ChatbotState> {
  ChatbotBloc()
      : super(ChatbotState(
          suggestions: ChatbotKnowledgeBase.initialSuggestions,
        )) {
    on<ToggleChatWindow>(_onToggleChatWindow);
    on<SendMessage>(_onSendMessage);
    on<SelectSuggestion>(_onSelectSuggestion);
    on<ClearChat>(_onClearChat);
  }

  void _onToggleChatWindow(
    ToggleChatWindow event,
    Emitter<ChatbotState> emit,
  ) {
    final newIsOpen = !state.isOpen;

    // Add welcome message when opening for the first time
    if (newIsOpen && state.messages.isEmpty) {
      final welcomeMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content:
            'Hi! 👋 I\'m Hasnain\'s assistant. Ask me anything about skills, projects, experience, or how to get in touch!',
        isUser: false,
        timestamp: DateTime.now(),
      );

      emit(state.copyWith(
        isOpen: newIsOpen,
        messages: [welcomeMessage],
        suggestions: ChatbotKnowledgeBase.initialSuggestions,
      ));
    } else {
      emit(state.copyWith(isOpen: newIsOpen));
    }
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<ChatbotState> emit,
  ) async {
    if (event.message.trim().isEmpty) return;

    // Add user message
    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: event.message,
      isUser: true,
      timestamp: DateTime.now(),
    );

    emit(state.copyWith(
      messages: [...state.messages, userMessage],
      isTyping: true,
      suggestions: [],
    ));

    // Simulate typing delay for natural feel
    await Future.delayed(const Duration(milliseconds: 800));

    // Get response from knowledge base
    final response = ChatbotKnowledgeBase.getResponse(event.message);

    final botMessage = ChatMessage(
      id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
      content: response.message,
      isUser: false,
      timestamp: DateTime.now(),
    );

    emit(state.copyWith(
      messages: [...state.messages, botMessage],
      isTyping: false,
      suggestions: response.suggestions,
    ));
  }

  void _onSelectSuggestion(
    SelectSuggestion event,
    Emitter<ChatbotState> emit,
  ) {
    add(SendMessage(event.suggestion));
  }

  void _onClearChat(
    ClearChat event,
    Emitter<ChatbotState> emit,
  ) {
    emit(const ChatbotState(
      isOpen: true,
      messages: [],
      suggestions: [],
    ));

    // Add welcome message again
    add(const ToggleChatWindow());
    add(const ToggleChatWindow());
  }
}
