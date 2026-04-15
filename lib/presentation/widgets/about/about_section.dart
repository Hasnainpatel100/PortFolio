import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../core/constants/portfolio_data.dart';
import '../common/glass_card.dart';

/// About Me Section - Skeuomorphic Design
class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool _isVisible = true; // Show immediately

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return VisibilityDetector(
      key: const Key('about-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 80,
          vertical: isMobile ? 60 : 120,
        ),
        decoration: const BoxDecoration(
          // Skeuomorphic dark gradient
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF050B14), Color(0xFF071220), Color(0xFF050B14)],
          ),
        ),
        child: Column(
          children: [
            // Section title
            _buildSectionTitle(context, isMobile),

            const SizedBox(height: 60),

            // Content
            if (isMobile) _buildMobileLayout() else _buildDesktopLayout(),

            // Extra bottom padding for mobile
            if (isMobile) const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, bool isMobile) {
    return Column(
      children: [
        Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: Colors.black.withValues(alpha: 0.4),
                  width: 1,
                ),
              ),
              child: Text(
                '01.',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: const Color(0xFF00D4FF),
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.3, end: 0),
        const SizedBox(height: 12),
        Text(
              'About Me',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: const Color(0xFFE0E0E0),
                fontWeight: FontWeight.bold,
              ),
            )
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms, delay: 200.ms)
            .slideY(begin: 0.3, end: 0),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side - Image/Avatar
        Expanded(flex: 2, child: _buildMagicalProfile()),
        const SizedBox(width: 60),
        // Right side - Content
        Expanded(flex: 3, child: _buildAboutContent()),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildMagicalProfile(),
        const SizedBox(height: 40),
        _buildAboutContent(),
      ],
    );
  }

  Widget _buildMagicalProfile() {
    return GlassCard(
          child: Column(
            children: [
              // Skeuomorphic metallic frame for avatar
              Container(
                width: 358,
                height: 358,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF4A4A4A),
                      Color(0xFF2A2A2A),
                      Color(0xFF1A1A1A),
                    ],
                  ),
                  border: Border.all(
                    color: Colors.black.withValues(alpha: 0.5),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(-4, -4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(4),
                child: ClipOval(
                  child: Image.asset(
                    PortfolioData.profileImage,
                    width: 350,
                    height: 350,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback to emoji if image fails to load
                      return Container(
                        color: const Color(0xFF1A1A1A),
                        child: const Center(
                          child: Text('👨‍💻', style: TextStyle(fontSize: 120)),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                PortfolioData.fullName,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFE0E0E0),
                ),
              ),
              const SizedBox(height: 8),
              // Skeuomorphic badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF3A3A3A), Color(0xFF2A2A2A)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.12),
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
                child: Text(
                  PortfolioData.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: const Color(0xFF00D4FF),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black.withValues(alpha: 0.3),
                      ),
                    ),
                    child: const Icon(
                      Icons.location_on,
                      color: Color(0xFF00D4FF),
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    PortfolioData.location,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF808080),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
        .animate(target: _isVisible ? 1 : 0)
        .fadeIn(duration: 800.ms, delay: 400.ms)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1));
  }

  Widget _buildAboutContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
              PortfolioData.aboutMe,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.8,
                color: const Color(0xFF808080),
              ),
            )
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 800.ms, delay: 600.ms)
            .slideX(begin: 0.2, end: 0),
        const SizedBox(height: 32),
        _buildQuickStats(),
      ],
    );
  }

  Widget _buildQuickStats() {
    final stats = [
      {'number': '1+', 'label': 'Year Experience'},
      {'number': '4+', 'label': 'Projects Built'},
      {'number': '1', 'label': 'Company (RH POS)'},
      {'number': '100%', 'label': 'Passion & Drive'},
    ];

    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Wrap(
      spacing: isMobile ? 12 : 24,
      runSpacing: isMobile ? 12 : 24,
      alignment: WrapAlignment.start,
      children: stats.asMap().entries.map((entry) {
        return _buildStatCard(
          entry.value['number']!,
          entry.value['label']!,
          entry.key,
          isMobile,
        );
      }).toList(),
    );
  }

  Widget _buildStatCard(String number, String label, int index, bool isMobile) {
    // Calculate responsive width
    final cardWidth = isMobile
        ? (MediaQuery.of(context).size.width - 72) /
              2 // 2 cards per row on mobile
        : 140.0; // Fixed width on desktop

    return Container(
          width: cardWidth,
          padding: EdgeInsets.all(isMobile ? 16 : 20),
          decoration: BoxDecoration(
            // Skeuomorphic card
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
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                number,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: const Color(0xFF00D4FF),
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 32 : 42,
                ),
              ),
              SizedBox(height: isMobile ? 6 : 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF808080),
                  fontSize: isMobile ? 11 : 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        )
        .animate(target: _isVisible ? 1 : 0)
        .fadeIn(duration: 600.ms, delay: (800 + (index * 100)).ms)
        .slideY(begin: 0.3, end: 0);
  }
}
