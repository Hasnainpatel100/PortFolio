import 'package:flutter/material.dart';

/// A custom painter that draws a subtle grid/hash pattern.
class GridPatternPainter extends CustomPainter {
  final double spacing;
  final double opacity;
  final Color color;

  GridPatternPainter({
    this.spacing = 40.0,
    this.opacity = 0.03,
    this.color = Colors.white,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final paint = Paint()
      ..color = color.withOpacity(opacity)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Draw vertical lines
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Draw horizontal lines
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant GridPatternPainter oldDelegate) {
    return oldDelegate.spacing != spacing ||
        oldDelegate.opacity != opacity ||
        oldDelegate.color != color;
  }
}
