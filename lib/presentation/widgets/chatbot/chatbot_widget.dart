import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/chatbot/chatbot_bloc.dart';
import '../../bloc/chatbot/chatbot_event.dart';
import '../../bloc/chatbot/chatbot_state.dart';
import 'chat_toggle_button.dart';
import 'chat_window.dart';

/// Main chatbot widget that overlays on the page
class ChatbotWidget extends StatelessWidget {
  const ChatbotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return BlocBuilder<ChatbotBloc, ChatbotState>(
      builder: (context, state) {
        return Stack(
          children: [
            // Chat window (animated)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              bottom: state.isOpen ? (isMobile ? 80 : 100) : -600,
              right: isMobile ? 16 : 24,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: state.isOpen ? 1.0 : 0.0,
                child: ChatWindow(
                  onClose: () {
                    context.read<ChatbotBloc>().add(const ToggleChatWindow());
                  },
                ),
              ),
            ),

            // Toggle button
            Positioned(
              bottom: isMobile ? 16 : 24,
              right: isMobile ? 16 : 24,
              child: ChatToggleButton(
                isOpen: state.isOpen,
                onTap: () {
                  context.read<ChatbotBloc>().add(const ToggleChatWindow());
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
