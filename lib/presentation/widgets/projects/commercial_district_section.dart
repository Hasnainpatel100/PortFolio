import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../core/constants/portfolio_data.dart';
import '../common/glass_card.dart';
import '../common/magic_button.dart';

/// Section 2: Skeuomorphic Projects Section
/// Dark, elegant project cards with 3D depth effects
class CityCenterSection extends StatefulWidget {
  const CityCenterSection({super.key});

  @override
  State<CityCenterSection> createState() => _CityCenterSectionState();
}

class _CityCenterSectionState extends State<CityCenterSection> {
  bool _isVisible = false;

  List<ProjectData> get _cityProjects => PortfolioData.projects
      .where((p) => !['RailSathi', 'CoachSathi', 'RailOps'].contains(p.title))
      .toList();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return VisibilityDetector(
      key: const Key('city-center-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: isMobile ? 800 : 1000),
        decoration: BoxDecoration(
          // Skeuomorphic dark gradient background
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF0A0A0A),
              const Color(0xFF121212),
              const Color(0xFF1A1A1A),
              const Color(0xFF151515),
            ],
            stops: const [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Subtle texture background
            Positioned.fill(
              child: CustomPaint(painter: SkeuomorphicGridPainter()),
            ),

            // Content
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 80,
                vertical: 100,
              ),
              child: Column(
                children: [
                  // Header Card
                  GlassCard(
                    color: const Color(0xFF252525),
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        // Section badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1A1A),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.black.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            "PROJECT SHOWCASE",
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(
                                  color: const Color(0xFF00D4FF),
                                  letterSpacing: 3,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "The Application Hub",
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withValues(alpha: 0.8),
                                    offset: const Offset(2, 2),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "A showcase of robust, scalable applications. From commercial platforms to utility tools, each project demonstrates a solution-first approach.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: const Color(0xFF808080),
                                fontSize: isMobile ? 14 : 18,
                              ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn().slideY(),

                  SizedBox(height: isMobile ? 40 : 60),

                  // Project Grid
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Wrap(
                        spacing: isMobile ? 20 : 32,
                        runSpacing: isMobile ? 24 : 40,
                        alignment: WrapAlignment.center,
                        children: _cityProjects.asMap().entries.map((entry) {
                          final index = entry.key;
                          final project = entry.value;
                          return _buildProjectCard(context, project, index);
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(
    BuildContext context,
    ProjectData project,
    int index,
  ) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final isSmallMobile = size.width < 400;

    final cardWidth = isSmallMobile
        ? size.width - 48
        : (isMobile ? size.width - 60 : 320.0);

    return _SkeuomorphicProjectCard(
      project: project,
      width: cardWidth,
      onTap: () => _showProjectDetails(context, project),
      isVisible: _isVisible,
      delay: index * 100,
    );
  }

  void _showProjectDetails(BuildContext context, ProjectData project) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: Container(
          width: 800,
          constraints: const BoxConstraints(maxHeight: 700),
          decoration: BoxDecoration(
            color: const Color(0xFF252525),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.12),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.6),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          project.title,
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      _SkeuomorphicCloseButton(
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    project.subtitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF808080),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Image container
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.black.withValues(alpha: 0.4),
                        width: 1,
                      ),
                      image: DecorationImage(
                        image: AssetImage(project.imageUrl),
                        fit: BoxFit.cover,
                        opacity: 0.7,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    "Technologies",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: project.technologies
                        .map((t) => _buildTechChip(t))
                        .toList(),
                  ),

                  const SizedBox(height: 24),
                  Text(
                    "Key Features",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...project.highlights.map(
                    (h) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF4CAF50),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF4CAF50,
                                  ).withValues(alpha: 0.5),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              h,
                              style: const TextStyle(
                                color: Color(0xFFB0B0B0),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                  Center(
                    child: MagicButton(
                      text: "Close",
                      icon: Icons.check,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTechChip(String tech) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      child: Text(
        tech,
        style: const TextStyle(
          color: Color(0xFF00D4FF),
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

/// Skeuomorphic Project Card with 3D effects
class _SkeuomorphicProjectCard extends StatefulWidget {
  final ProjectData project;
  final double width;
  final VoidCallback onTap;
  final bool isVisible;
  final int delay;

  const _SkeuomorphicProjectCard({
    required this.project,
    required this.width,
    required this.onTap,
    required this.isVisible,
    this.delay = 0,
  });

  @override
  State<_SkeuomorphicProjectCard> createState() =>
      _SkeuomorphicProjectCardState();
}

class _SkeuomorphicProjectCardState extends State<_SkeuomorphicProjectCard> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTapDown: (_) => setState(() => _isPressed = true),
            onTapUp: (_) {
              setState(() => _isPressed = false);
              widget.onTap();
            },
            onTapCancel: () => setState(() => _isPressed = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: widget.width,
              transform: _isPressed
                  ? Matrix4.translationValues(0, 3, 0)
                  : (_isHovered
                        ? Matrix4.translationValues(0, -4, 0)
                        : Matrix4.identity()),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: _isPressed
                      ? [const Color(0xFF252525), const Color(0xFF2A2A2A)]
                      : [
                          Color.lerp(
                            const Color(0xFF2A2A2A),
                            Colors.white,
                            0.05,
                          )!,
                          const Color(0xFF2A2A2A),
                          Color.lerp(
                            const Color(0xFF2A2A2A),
                            Colors.black,
                            0.08,
                          )!,
                        ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _isPressed
                      ? Colors.black.withValues(alpha: 0.25)
                      : Colors.white.withValues(alpha: 0.10),
                  width: _isHovered ? 1.5 : 1,
                ),
                boxShadow: _isPressed
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(
                            alpha: _isHovered ? 0.5 : 0.4,
                          ),
                          blurRadius: _isHovered ? 20 : 14,
                          offset: Offset(0, _isHovered ? 10 : 7),
                        ),
                        if (_isHovered)
                          BoxShadow(
                            color: const Color(
                              0xFF00D4FF,
                            ).withValues(alpha: 0.1),
                            blurRadius: 20,
                            spreadRadius: -2,
                          ),
                      ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Project image area
                    Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        image: DecorationImage(
                          image: AssetImage(widget.project.imageUrl),
                          fit: BoxFit.cover,
                          opacity: _isHovered ? 0.5 : 0.4,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              const Color(0xFF2A2A2A).withValues(alpha: 0.9),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Content
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1A1A),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: const Color(
                                  0xFF00D4FF,
                                ).withValues(alpha: 0.3),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              widget.project.category.toUpperCase(),
                              style: const TextStyle(
                                color: Color(0xFF00D4FF),
                                fontSize: 10,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Title
                          Text(
                            widget.project.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withValues(alpha: 0.5),
                                  offset: const Offset(1, 1),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          // Technologies
                          Text(
                            widget.project.technologies.take(3).join(" • "),
                            style: const TextStyle(
                              color: Color(0xFF707070),
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Arrow indicator
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFF1A1A1A),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.1),
                                    width: 1,
                                  ),
                                ),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: _isHovered
                                      ? const Color(0xFF00D4FF)
                                      : const Color(0xFF606060),
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        .animate(target: widget.isVisible ? 1 : 0)
        .fadeIn(delay: (200 + widget.delay).ms, duration: 600.ms)
        .slideY(begin: 0.2, end: 0);
  }
}

/// Skeuomorphic close button
class _SkeuomorphicCloseButton extends StatefulWidget {
  final VoidCallback onTap;

  const _SkeuomorphicCloseButton({required this.onTap});

  @override
  State<_SkeuomorphicCloseButton> createState() =>
      _SkeuomorphicCloseButtonState();
}

class _SkeuomorphicCloseButtonState extends State<_SkeuomorphicCloseButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.all(8),
        transform: _isPressed
            ? Matrix4.translationValues(0, 1, 0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _isPressed ? const Color(0xFF252525) : const Color(0xFF2A2A2A),
          border: Border.all(
            color: _isPressed
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: const Icon(Icons.close, color: Colors.white, size: 20),
      ),
    );
  }
}

/// Skeuomorphic grid background painter
class SkeuomorphicGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Very subtle grid lines
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.015)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Vertical lines
    for (double x = 0; x < size.width; x += 80) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Horizontal lines
    for (double y = 0; y < size.height; y += 80) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Vignette effect
    final vignettePaint = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 1.5,
        colors: [Colors.transparent, Colors.black.withValues(alpha: 0.3)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      vignettePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
