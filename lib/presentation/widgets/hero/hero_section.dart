import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proftolio/presentation/widgets/common/glass_card.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/portfolio_data.dart';
import '../common/magic_button.dart';

/// The Landing - Skeuomorphic Hero Section
class HeroSection extends StatefulWidget {
  final VoidCallback? onViewProjectsPressed;

  const HeroSection({
    super.key,
    this.onViewProjectsPressed,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _hoverController;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final isSmallMobile = size.width < 400;

    final minHeight = isMobile ? null : size.height;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: minHeight ?? size.height),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Skeuomorphic Background
          Positioned.fill(
            child: CustomPaint(
              painter: SkeuomorphicBackgroundPainter(
                animationValue: _hoverController,
              ),
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 24,
              vertical: isMobile ? 60 : 80,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top),

                // Floating Avatar with metallic frame
                AnimatedBuilder(
                  animation: _hoverController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(
                        0,
                        _hoverController.value * (isMobile ? 8 : 15),
                      ),
                      child: child,
                    );
                  },
                  child: Hero(
                    tag: 'avatar',
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // Metallic ring effect
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFF606060),
                            const Color(0xFF404040),
                            const Color(0xFF303030),
                            const Color(0xFF505050),
                          ],
                        ),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 1,
                        ),
                        boxShadow: [
                          // Outer shadow
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                          // Inner highlight
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.1),
                            blurRadius: 1,
                            offset: const Offset(-1, -1),
                          ),
                        ],
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF1A1A1A),
                          border: Border.all(
                            color: Colors.black.withValues(alpha: 0.5),
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: isSmallMobile ? 75 : (isMobile ? 100 : 130),
                          backgroundColor: const Color(0xFF2A2A2A),
                          backgroundImage: AssetImage(
                            PortfolioData.profileImage,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: isMobile ? 32 : 48),

                // Skeuomorphic Card for Text
                GlassCard(
                  color: const Color(
                    0xFF2A2A2A,
                  ).withOpacity(0.3), // More transparent for visibility
                  child: Padding(
                    padding: EdgeInsets.all(isMobile ? 16 : 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Badge with embossed effect
                        Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A1A1A).withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.1),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                    spreadRadius: -1,
                                  ),
                                ],
                              ),
                              child: Text(
                                "FLUTTER & FULL STACK DEV",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.labelLarge
                                    ?.copyWith(
                                      color: const Color(0xFF00D4FF),
                                      letterSpacing: isMobile
                                          ? 1.5
                                          : 3, // Reduced spacing
                                      fontWeight: FontWeight.bold,
                                      fontSize: isMobile ? 12 : 14,
                                    ),
                              ),
                            )
                            .animate()
                            .fadeIn(duration: 800.ms)
                            .slideY(begin: 0.2, end: 0),

                        SizedBox(height: isMobile ? 12 : 16),

                        // Name with metallic text effect
                        Text(
                              PortfolioData.fullName,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.displayLarge
                                  ?.copyWith(
                                    fontWeight:
                                        FontWeight.bold, // Reduced from w900
                                    fontSize: isSmallMobile
                                        ? 24
                                        : (isMobile ? 32 : 56), // Reduced size
                                    color: Colors.white,
                                    letterSpacing:
                                        1.5, // Added spacing for breathability
                                    height: 1.1,
                                    shadows: [
                                      // 3D emboss effect
                                      Shadow(
                                        color: Colors.black.withOpacity(0.8),
                                        offset: const Offset(2, 2),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                            )
                            .animate()
                            .fadeIn(delay: 200.ms, duration: 800.ms)
                            .scale(),

                        SizedBox(height: isMobile ? 12 : 16),

                        Container(
                          constraints: BoxConstraints(
                            maxWidth: isMobile ? double.infinity : 900,
                          ),
                          child: Text(
                            isMobile
                                ? "Flutter Developer & Full Stack enthusiast from Latur, India. Building cross-platform mobile apps with clean code, beautiful UI, and rock-solid performance."
                                : "I am a Flutter Developer and Full Stack enthusiast from Latur, India. I turn ideas into polished, cross-platform mobile and web applications using Flutter, Dart, GetX, REST APIs, and modern databases like MongoDB and MySQL. Clean code, beautiful UI, and performance are my core principles — from first commit to production release.",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: const Color(0xFFB0B0B0),
                                  height: 1.6,
                                  fontSize: isSmallMobile
                                      ? 13
                                      : (isMobile ? 14 : 18),
                                ),
                          ),
                        ).animate().fadeIn(delay: 400.ms, duration: 800.ms),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: isMobile ? 24 : 40),

                // Action Buttons (now skeuomorphic)
                Wrap(
                      spacing: isMobile ? 12 : 20,
                      runSpacing: isMobile ? 12 : 20,
                      alignment: WrapAlignment.center,
                      children: [
                        MagicButton(
                          text: "View Projects",
                          icon: FontAwesomeIcons.code,
                          onPressed: widget.onViewProjectsPressed!,
                        ),
                        MagicButton(
                          text: "Download CV",
                          icon: FontAwesomeIcons.fileArrowDown,
                          isPrimary: false,
                          onPressed: () async {
                            final Uri url = Uri.parse(PortfolioData.resumeUrl);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            }
                          },
                        ),
                      ],
                    )
                    .animate()
                    .fadeIn(delay: 600.ms, duration: 800.ms)
                    .slideY(begin: 0.2, end: 0),

                SizedBox(height: isMobile ? 32 : 60),

                // Scroll Indicator with skeuomorphic style
                Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "SCROLL TO EXPLORE",
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: const Color(0xFF606060),
                                letterSpacing: 2,
                                fontSize: isMobile ? 10 : 12,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF2A2A2A),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.1),
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
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: const Color(0xFF606060),
                            size: isMobile ? 20 : 24,
                          ),
                        ),
                      ],
                    )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .moveY(begin: 0, end: 10, duration: 1000.ms),

                SizedBox(height: isMobile ? 20 : 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Skeuomorphic Background Painter with subtle texture and depth
class SkeuomorphicBackgroundPainter extends CustomPainter {
  final Animation<double>? animationValue;

  SkeuomorphicBackgroundPainter({this.animationValue})
    : super(repaint: animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    // Dark leather-like background gradient
    final bgPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF050B14),
          const Color(0xFF070E1A),
          const Color(0xFF071220),
          const Color(0xFF050B14),
        ],
        stops: const [0.0, 0.3, 0.7, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Subtle noise texture simulation with dots
    final noisePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.02)
      ..style = PaintingStyle.fill;

    for (double x = 0; x < size.width; x += 8) {
      for (double y = 0; y < size.height; y += 8) {
        if ((x.toInt() + y.toInt()) % 3 == 0) {
          canvas.drawCircle(Offset(x, y), 0.5, noisePaint);
        }
      }
    }

    // Vignette effect (darker edges)
    final vignettePaint = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 1.2,
        colors: [Colors.transparent, Colors.black.withValues(alpha: 0.4)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      vignettePaint,
    );

    // Subtle spotlight from top center
    final spotlightPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0, -0.5),
        radius: 1.0,
        colors: [const Color(0xFF00D4FF).withValues(alpha: 0.04), Colors.transparent],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      spotlightPaint,
    );

    // Decorative embossed lines
    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final shadowLinePaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.3)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Horizontal decorative lines
    for (int i = 1; i < 4; i++) {
      double y = size.height * (i / 4);
      // Shadow line (below)
      canvas.drawLine(
        Offset(size.width * 0.1, y + 1),
        Offset(size.width * 0.9, y + 1),
        shadowLinePaint,
      );
      // Highlight line
      canvas.drawLine(
        Offset(size.width * 0.1, y),
        Offset(size.width * 0.9, y),
        linePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
