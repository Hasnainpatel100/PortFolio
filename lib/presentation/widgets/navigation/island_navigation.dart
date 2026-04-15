import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

/// Skeuomorphic Navigation Path
class IslandNavigation extends StatefulWidget {
  final ScrollController scrollController;
  final double contentHeight;

  const IslandNavigation({
    super.key,
    required this.scrollController,
    required this.contentHeight,
  });

  @override
  State<IslandNavigation> createState() => _IslandNavigationState();
}

class _IslandNavigationState extends State<IslandNavigation> {
  double _currentScrollOffset = 0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _currentScrollOffset = widget.scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.contentHeight == 0) return const SizedBox.shrink();

    return Stack(
      children: [
        // The subtle path
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width, widget.contentHeight),
          painter: SkeuomorphicPathPainter(),
        ),

        // The Vehicle indicator
        _SkeuomorphicVehicle(
          scrollOffset: _currentScrollOffset,
          totalHeight: widget.contentHeight,
          roadPath: IslandPathGenerator.generatePath(
            MediaQuery.of(context).size.width,
            widget.contentHeight,
          ),
        ),
      ],
    );
  }
}

class _SkeuomorphicVehicle extends StatelessWidget {
  final double scrollOffset;
  final double totalHeight;
  final Path roadPath;

  const _SkeuomorphicVehicle({
    required this.scrollOffset,
    required this.totalHeight,
    required this.roadPath,
  });

  @override
  Widget build(BuildContext context) {
    if (totalHeight <= 0) return const SizedBox();

    final metrics = roadPath.computeMetrics().toList();
    if (metrics.isEmpty) return const SizedBox();

    final pathMetric = metrics.first;
    if (pathMetric.length == 0) return const SizedBox();

    final double maxScroll = totalHeight;
    final double clampedOffset = scrollOffset.clamp(0.0, maxScroll);
    if (clampedOffset.isNaN) return const SizedBox();

    final double viewportHeight = MediaQuery.of(context).size.height;
    final denominator = totalHeight - viewportHeight;

    if (denominator <= 0) return const SizedBox();

    double progress = (clampedOffset / denominator);
    if (progress.isNaN || progress.isInfinite) progress = 0.0;
    progress = progress.clamp(0.0, 1.0);

    final Tangent? tangent = pathMetric.getTangentForOffset(
      pathMetric.length * progress,
    );

    if (tangent == null) return const SizedBox();
    if (tangent.position.dx.isNaN || tangent.position.dy.isNaN) {
      return const SizedBox();
    }

    return Positioned(
      left: tangent.position.dx - 20,
      top: tangent.position.dy - 20 - scrollOffset,
      child: Transform.rotate(
        angle: tangent.angle + pi / 2,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            // Skeuomorphic metallic style
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF505050),
                const Color(0xFF3A3A3A),
                const Color(0xFF2A2A2A),
              ],
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.15),
              width: 1,
            ),
            boxShadow: [
              // Outer shadow for depth
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
              // Subtle glow effect
              BoxShadow(
                color: const Color(0xFF00D4FF).withValues(alpha: 0.2),
                blurRadius: 8,
                spreadRadius: -2,
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.directions_car,
              size: 22,
              color: Color(0xFFE0E0E0),
            ),
          ),
        ),
      ),
    );
  }
}

/// Skeuomorphic subtle path painter
class SkeuomorphicPathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final path = IslandPathGenerator.generatePath(size.width, size.height);

    // Very subtle dark line (like a groove)
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, shadowPaint);

    // Main path line - subtle gray
    final mainPaint = Paint()
      ..color = const Color(0xFF2A2A2A).withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, mainPaint);

    // Subtle highlight on top edge
    final highlightPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, highlightPaint);

    // Very subtle dashed center line
    final dashPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawPath(path, dashPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class IslandPathGenerator {
  static Path generatePath(double width, double height) {
    final path = Path();
    path.moveTo(width * 0.5, 50);

    path.quadraticBezierTo(
      width * 0.8,
      height * 0.15,
      width * 0.7,
      height * 0.25,
    );

    path.quadraticBezierTo(
      width * 0.1,
      height * 0.4,
      width * 0.3,
      height * 0.5,
    );

    path.quadraticBezierTo(
      width * 0.9,
      height * 0.65,
      width * 0.6,
      height * 0.75,
    );

    path.quadraticBezierTo(
      width * 0.2,
      height * 0.9,
      width * 0.5,
      height - 100,
    );

    return path;
  }
}
