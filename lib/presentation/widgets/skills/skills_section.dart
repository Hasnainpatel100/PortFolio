import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../core/constants/portfolio_data.dart';
import '../common/glass_card.dart';

/// Section 4: The Power Plant (Backend/DevOps/Logic) - Skeuomorphic Design
class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    // Filter skills for "Power Plant"
    final powerSkills = PortfolioData.skills
        .where(
          (s) => [
            'Backend',
            'Realtime',
            'Tools',
            'Architecture',
            'State Management',
            'Languages',
          ].contains(s.category),
        )
        .toList();

    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return VisibilityDetector(
      key: const Key('power-plant-section'),
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
            colors: [Color(0xFF0A0A0A), Color(0xFF151515), Color(0xFF0F0F0F)],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background Visual (Subtle grid)
            Positioned.fill(
              child: CustomPaint(painter: _SkeuomorphicGridPainter()),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 80,
                vertical: 80,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  GlassCard(
                    child: Column(
                      children: [
                        Center(
                          child: Container(
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
                              "CORE TECHNOLOGIES",
                              style: Theme.of(context).textTheme.labelMedium
                                  ?.copyWith(
                                    color: const Color(
                                      0xFF6B8E23,
                                    ), // Olive green - more muted
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        Center(
                          child: Text(
                            "The Engineering Core",
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFE0E0E0),
                                ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 700),
                            child: Text(
                              "The engine room of development. Advanced architecture (Clean/BLoC), and precise state management.",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    color: const Color(0xFF808080),
                                    fontWeight: FontWeight.normal,
                                    fontSize: isMobile ? 14 : 18,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn().slideY(),

                  const SizedBox(height: 60),

                  // Skills Grid (Server Racks)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isMobile ? 1 : 2,
                      childAspectRatio: isMobile ? 3 : 4,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: powerSkills.length,
                    itemBuilder: (context, index) {
                      final skill = powerSkills[index];
                      return _buildServerRackItem(skill, index);
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

  Widget _buildServerRackItem(SkillData skill, int index) {
    return Container(
      decoration: BoxDecoration(
        // Skeuomorphic panel styling
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2A2A2A), Color(0xFF1E1E1E), Color(0xFF181818)],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Status Lights - LED style
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              3,
              (i) => Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  // Skeuomorphic LED lights
                  gradient: RadialGradient(
                    colors: i == 0
                        ? [const Color(0xFF4A9E4A), const Color(0xFF2D6B2D)]
                        : (i == 1
                              ? [
                                  const Color(0xFF6B8E23),
                                  const Color(0xFF4A6318),
                                ]
                              : [
                                  const Color(0xFF3A3A3A),
                                  const Color(0xFF2A2A2A),
                                ]),
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black.withValues(alpha: 0.5),
                    width: 1,
                  ),
                  boxShadow: i < 2
                      ? [
                          BoxShadow(
                            color: const Color(
                              0xFF4A9E4A,
                            ).withValues(alpha: 0.3),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ]
                      : null,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Icon
          Text(skill.icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  skill.name,
                  style: const TextStyle(
                    color: Color(0xFFE0E0E0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // Skeuomorphic progress bar (inset groove)
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                      color: Colors.black.withValues(alpha: 0.4),
                      width: 1,
                    ),
                  ),
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        duration: 1000.ms,
                        width: 100 * (skill.level / 100),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4A9E4A), Color(0xFF6B8E23)],
                          ),
                          borderRadius: BorderRadius.circular(2),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF4A9E4A,
                              ).withValues(alpha: 0.3),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.black.withValues(alpha: 0.3)),
            ),
            child: Text(
              "${skill.level}%",
              style: const TextStyle(
                color: Color(0xFF6B8E23),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    ).animate(delay: (index * 50).ms).fadeIn().slideX();
  }
}

class _SkeuomorphicGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Subtle grid lines
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.02)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Vertical lines
    for (double x = 0; x < w; x += 60) {
      canvas.drawLine(Offset(x, 0), Offset(x, h), gridPaint);
    }

    // Horizontal lines
    for (double y = 0; y < h; y += 60) {
      canvas.drawLine(Offset(0, y), Offset(w, y), gridPaint);
    }

    // Subtle central ambient light
    final ambientPaint = Paint()
      ..shader =
          RadialGradient(
            colors: [Colors.white.withValues(alpha: 0.03), Colors.transparent],
          ).createShader(
            Rect.fromCircle(center: Offset(w / 2, h / 2), radius: w / 2),
          );

    canvas.drawCircle(Offset(w / 2, h / 2), w / 3, ambientPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
