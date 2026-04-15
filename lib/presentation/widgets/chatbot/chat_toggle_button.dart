import 'package:flutter/material.dart';

/// Floating chat toggle button with pulse animation
class ChatToggleButton extends StatefulWidget {
  final bool isOpen;
  final VoidCallback onTap;

  const ChatToggleButton({
    super.key,
    required this.isOpen,
    required this.onTap,
  });

  @override
  State<ChatToggleButton> createState() => _ChatToggleButtonState();
}

class _ChatToggleButtonState extends State<ChatToggleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Start pulse animation when chat is closed
    if (!widget.isOpen) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(ChatToggleButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpen != oldWidget.isOpen) {
      if (widget.isOpen) {
        _pulseController.stop();
        _pulseController.reset();
      } else {
        _pulseController.repeat(reverse: true);
      }
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: widget.isOpen ? 1.0 : _pulseAnimation.value,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF1E3A8A), // Dark Blue
                      Color(0xFF3B82F6), // Formal Blue
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(
                        0xFF3B82F6,
                      ).withOpacity(widget.isOpen ? 0.3 : 0.5),
                      blurRadius: widget.isOpen ? 15 : 25,
                      spreadRadius: widget.isOpen ? 1 : 3,
                    ),
                  ],
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, animation) {
                    return RotationTransition(
                      turns: Tween(begin: 0.5, end: 1.0).animate(animation),
                      child: ScaleTransition(scale: animation, child: child),
                    );
                  },
                  child: Icon(
                    widget.isOpen ? Icons.close : Icons.chat_bubble_rounded,
                    key: ValueKey(widget.isOpen),
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
