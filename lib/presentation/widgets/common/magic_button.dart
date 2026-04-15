import 'package:flutter/material.dart';

/// Skeuomorphic 3D button with realistic press effects
/// Features beveled edges, depth shadows, and tactile feedback
class MagicButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final IconData? icon;
  final double? width;
  final double? height;

  const MagicButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.icon,
    this.width,
    this.height,
  });

  @override
  State<MagicButton> createState() => _MagicButtonState();
}

class _MagicButtonState extends State<MagicButton>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  bool _isPressed = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color get _buttonColor {
    if (widget.isPrimary) {
      return const Color(0xFF2563EB); // Rich blue
    }
    return const Color(0xFF3D3D3D); // Dark gray
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) {
          setState(() => _isPressed = true);
          _controller.forward();
        },
        onTapUp: (_) {
          setState(() => _isPressed = false);
          _controller.reverse();
          widget.onPressed();
        },
        onTapCancel: () {
          setState(() => _isPressed = false);
          _controller.reverse();
        },
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: widget.width,
            height: widget.height ?? 56,
            // Move down when pressed
            transform: _isPressed
                ? Matrix4.translationValues(0, 3, 0)
                : Matrix4.identity(),
            decoration: _buildButtonDecoration(),
            child: Stack(
              children: [
                // Top highlight strip
                Positioned(
                  top: 0,
                  left: 8,
                  right: 8,
                  height: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1),
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.white.withValues(
                            alpha: _isPressed ? 0.0 : 0.25,
                          ),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                // Button content
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.icon != null) ...[
                          Icon(widget.icon, color: Colors.white, size: 20),
                          const SizedBox(width: 12),
                        ],
                        Text(
                          widget.text,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withValues(alpha: 0.3),
                                    offset: const Offset(0, 1),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildButtonDecoration() {
    final baseColor = _buttonColor;

    return BoxDecoration(
      // 3D gradient effect
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: _isPressed
            ? [
                // Pressed: darker at top (inverted light)
                Color.lerp(baseColor, Colors.black, 0.25)!,
                Color.lerp(baseColor, Colors.black, 0.15)!,
                Color.lerp(baseColor, Colors.black, 0.1)!,
              ]
            : [
                // Normal: lighter at top (catching light)
                Color.lerp(baseColor, Colors.white, 0.15)!,
                baseColor,
                Color.lerp(baseColor, Colors.black, 0.2)!,
              ],
      ),
      borderRadius: BorderRadius.circular(12),
      // Uniform border (required for borderRadius)
      border: Border.all(
        color: _isPressed
            ? Colors.black.withValues(alpha: 0.35)
            : Colors.white.withValues(alpha: 0.20),
        width: _isPressed ? 1 : 2,
      ),
      // Shadows for depth
      boxShadow: _isPressed
          ? [
              // Minimal shadow when pressed (button is "down")
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ]
          : [
              // Main drop shadow
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: _isHovered ? 12 : 8,
                offset: Offset(0, _isHovered ? 6 : 4),
              ),
              // Colored glow when hovered
              if (_isHovered && widget.isPrimary)
                BoxShadow(
                  color: baseColor.withValues(alpha: 0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                  spreadRadius: -2,
                ),
            ],
    );
  }
}

/// Skeuomorphic icon button with circular 3D effect
class SkeuomorphicIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final Color? color;

  const SkeuomorphicIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 48,
    this.color,
  });

  @override
  State<SkeuomorphicIconButton> createState() => _SkeuomorphicIconButtonState();
}

class _SkeuomorphicIconButtonState extends State<SkeuomorphicIconButton> {
  bool _isPressed = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.color ?? const Color(0xFF3D3D3D);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onPressed();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: widget.size,
          height: widget.size,
          transform: _isPressed
              ? Matrix4.translationValues(0, 2, 0)
              : Matrix4.identity(),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _isPressed
                  ? [Color.lerp(baseColor, Colors.black, 0.2)!, baseColor]
                  : [
                      Color.lerp(baseColor, Colors.white, 0.1)!,
                      Color.lerp(baseColor, Colors.black, 0.1)!,
                    ],
            ),
            border: Border.all(
              color: _isPressed
                  ? Colors.black.withValues(alpha: 0.3)
                  : Colors.white.withValues(alpha: 0.1),
              width: 1,
            ),
            boxShadow: _isPressed
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: _isHovered ? 10 : 6,
                      offset: Offset(0, _isHovered ? 4 : 3),
                    ),
                  ],
          ),
          child: Icon(
            widget.icon,
            color: Colors.white.withValues(alpha: 0.9),
            size: widget.size * 0.5,
          ),
        ),
      ),
    );
  }
}
