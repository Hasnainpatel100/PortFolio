import 'package:flutter/material.dart';

/// Skeuomorphic Card with realistic 3D depth and material effects
/// Replaces glassmorphism with tactile, physical appearance
class GlassCard extends StatefulWidget {
  final Widget child;
  final double opacity;
  final double blur;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Border? border;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final bool useSkeuomorphic;
  final bool isPressed;

  const GlassCard({
    super.key,
    required this.child,
    this.opacity = 0.1,
    this.blur = 10.0,
    this.borderRadius,
    this.padding,
    this.margin,
    this.color,
    this.border,
    this.width,
    this.height,
    this.onTap,
    this.useSkeuomorphic = true,
    this.isPressed = false,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _isPressed = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final borderRadius = widget.borderRadius ?? BorderRadius.circular(16);
    final baseColor = widget.color ?? const Color(0xFF2A2A2A);

    Widget card = AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      transform: _isPressed
          ? Matrix4.translationValues(0, 2, 0)
          : (_isHovered
                ? Matrix4.translationValues(0, -2, 0)
                : Matrix4.identity()),
      decoration: _buildSkeuomorphicDecoration(baseColor, borderRadius),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top highlight line
            Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.white.withValues(alpha: _isPressed ? 0.05 : 0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            // Content
            Flexible(
              child: Padding(
                padding: widget.padding ?? const EdgeInsets.all(16),
                child: widget.child,
              ),
            ),
          ],
        ),
      ),
    );

    if (widget.onTap != null) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) {
            setState(() => _isPressed = false);
            widget.onTap!();
          },
          onTapCancel: () => setState(() => _isPressed = false),
          child: card,
        ),
      );
    }

    return card;
  }

  BoxDecoration _buildSkeuomorphicDecoration(
    Color baseColor,
    BorderRadius borderRadius,
  ) {
    return BoxDecoration(
      // Gradient to simulate curved surface catching light
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: _isPressed
            ? [
                Color.lerp(baseColor, Colors.black, 0.1)!,
                baseColor,
                Color.lerp(baseColor, Colors.black, 0.05)!,
              ]
            : [
                Color.lerp(baseColor, Colors.white, 0.08)!,
                baseColor,
                Color.lerp(baseColor, Colors.black, 0.08)!,
              ],
        stops: const [0.0, 0.5, 1.0],
      ),
      borderRadius: borderRadius,
      // Simple uniform border (required for borderRadius)
      border: Border.all(
        color: _isPressed
            ? Colors.black.withValues(alpha: 0.25)
            : Colors.white.withValues(alpha: 0.10),
        width: 1,
      ),
      // Realistic shadow
      boxShadow: _isPressed
          ? [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ]
          : [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: _isHovered ? 16 : 12,
                offset: Offset(0, _isHovered ? 8 : 6),
                spreadRadius: _isHovered ? 1 : 0,
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 24,
                offset: const Offset(0, 12),
                spreadRadius: -4,
              ),
            ],
    );
  }
}

/// Skeuomorphic inset panel for content areas
class SkeuomorphicInsetPanel extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final Color? color;
  final BorderRadius? borderRadius;

  const SkeuomorphicInsetPanel({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.color,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(12);
    final baseColor = color ?? const Color(0xFF1A1A1A);

    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: radius,
        // Simple uniform border (required for borderRadius)
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(2, 2),
            spreadRadius: -4,
          ),
        ],
      ),
      child: child,
    );
  }
}
