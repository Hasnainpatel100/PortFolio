import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../core/constants/portfolio_data.dart';
import '../common/glass_card.dart';
import '../common/magic_button.dart';

/// Section 5: The Design Studio (UI/UX) - Skeuomorphic Design
class DesignStudioSection extends StatefulWidget {
  const DesignStudioSection({super.key});

  @override
  State<DesignStudioSection> createState() => _DesignStudioSectionState();
}

class _DesignStudioSectionState extends State<DesignStudioSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    // Filter skills for "Design"
    final designSkills = PortfolioData.skills
        .where(
          (s) =>
              ['Design', 'Mobile Development', 'Frontend'].contains(s.category),
        )
        .toList();

    if (!designSkills.any((s) => s.name.contains('Flutter'))) {
      designSkills.insert(
        0,
        PortfolioData.skills.firstWhere(
          (s) => s.name.contains('Flutter'),
          orElse: () => PortfolioData.skills.first,
        ),
      );
    }

    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return VisibilityDetector(
      key: const Key('design-studio-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 1000),
        decoration: const BoxDecoration(
          // Skeuomorphic dark gradient background
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F0F0F), Color(0xFF151515), Color(0xFF0A0A0A)],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background Visual (Subtle geometric)
            Positioned.fill(
              child: CustomPaint(painter: _SkeuomorphicStudioPainter()),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 80,
                vertical: 80,
              ),
              child: Column(
                children: [
                  // Header
                  GlassCard(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1A1A),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: Colors.black.withValues(alpha: 0.4),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            "UI/UX LAB",
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(
                                  color: const Color(
                                    0xFF00D4FF,
                                  ), // Muted blue accent
                                  letterSpacing: 3,
                                ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "The Design Studio",
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFE0E0E0),
                              ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Where logic meets aesthetics. Crafting pixel-perfect, responsive interfaces that delight users while maximizing engagement.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: const Color(0xFF808080),
                                fontSize: isMobile ? 14 : 18,
                              ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn().slideY(),

                  const SizedBox(height: 60),

                  // Showcase / Skills
                  Wrap(
                    spacing: 40,
                    runSpacing: 40,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildFrame(
                        context,
                        "Responsive Layouts",
                        FontAwesomeIcons.layerGroup,
                        "Adapt from tablet to desktop seamlessly.",
                      ),
                      _buildFrame(
                        context,
                        "Data Dashboards",
                        FontAwesomeIcons.chartPie,
                        "Intricate, data-dense interfaces that remain clean.",
                      ),
                      _buildFrame(
                        context,
                        "Micro-Interactions",
                        FontAwesomeIcons.wandMagicSparkles,
                        "Subtle animations that delight users.",
                      ),
                    ],
                  ),

                  const SizedBox(height: 60),

                  // Tools Palette
                  Text(
                    "The Palette",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: const Color(0xFF808080),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: designSkills
                        .map((s) => _buildSkillChip(s))
                        .toList(),
                  ),

                  const SizedBox(height: 80),
                  MagicButton(
                    text: "Enter Studio",
                    icon: FontAwesomeIcons.palette,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillChip(SkillData skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2A2A2A), Color(0xFF1E1E1E)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.10),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(skill.icon),
          const SizedBox(width: 8),
          Text(skill.name, style: const TextStyle(color: Color(0xFFE0E0E0))),
        ],
      ),
    );
  }

  Widget _buildFrame(
    BuildContext context,
    String title,
    IconData icon,
    String desc,
  ) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        // Skeuomorphic card styling
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2A2A2A), Color(0xFF1E1E1E), Color(0xFF181818)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Icon container with inset effect
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF00D4FF).withValues(alpha: 0.3),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 4,
                  offset: const Offset(2, 2),
                ),
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(-2, -2),
                ),
              ],
            ),
            child: Icon(icon, size: 28, color: const Color(0xFF00D4FF)),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFFE0E0E0),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF808080)),
          ),
        ],
      ),
    ).animate().scale(delay: 200.ms);
  }
}

class _SkeuomorphicStudioPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Subtle floating geometric shapes
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.02)
      ..style = PaintingStyle.fill;

    // Draw some floating "frames"
    canvas.save();
    canvas.translate(size.width * 0.1, size.height * 0.2);
    canvas.rotate(-0.1);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(0, 0, 100, 150),
        const Radius.circular(8),
      ),
      paint,
    );
    canvas.restore();

    canvas.save();
    canvas.translate(size.width * 0.8, size.height * 0.6);
    canvas.rotate(0.2);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(0, 0, 120, 180),
        const Radius.circular(8),
      ),
      paint,
    );
    canvas.restore();

    // Subtle grid perspective
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.015)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (double i = 0; i < size.width; i += 80) {
      canvas.drawLine(
        Offset(i, size.height),
        Offset(size.width / 2, size.height * 0.4),
        gridPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
