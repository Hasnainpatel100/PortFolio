import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/portfolio_data.dart';
import '../common/glass_card.dart';

/// Experience Timeline Section
class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> {
  final bool _isVisible = true; // Show immediately

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 60 : 120,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppTheme.darkBg, AppTheme.darkSurface],
        ),
      ),
      child: Column(
        children: [
          _buildSectionTitle(context),
          const SizedBox(height: 60),
          _buildTimeline(isMobile),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context) {
    return Column(
      children: [
        Text(
              '03.',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.accentPink,
                fontWeight: FontWeight.bold,
              ),
            )
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.3, end: 0),
        const SizedBox(height: 8),
        ShaderMask(
              shaderCallback: (bounds) =>
                  AppTheme.magicGradient.createShader(bounds),
              child: Text(
                'Professional Experience',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms, delay: 200.ms)
            .slideY(begin: 0.3, end: 0),
      ],
    );
  }

  Widget _buildTimeline(bool isMobile) {
    return Column(
      children: PortfolioData.experiences.asMap().entries.map((entry) {
        final index = entry.key;
        final experience = entry.value;
        return _buildTimelineItem(experience, index, isMobile);
      }).toList(),
    );
  }

  Widget _buildTimelineItem(
    ExperienceData experience,
    int index,
    bool isMobile,
  ) {
    final isLeft = index.isEven;

    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile && isLeft) ...[
            Expanded(
              child: _buildExperienceCard(experience, index, isMobile)
                  .animate(target: _isVisible ? 1 : 0)
                  .fadeIn(duration: 800.ms, delay: (400 + index * 100).ms)
                  .slideX(begin: -0.3, end: 0),
            ),
            const SizedBox(width: 20),
          ],
          if (!isMobile)
            _buildTimelineDot()
                .animate(target: _isVisible ? 1 : 0)
                .scale(
                  begin: const Offset(0, 0),
                  delay: (400 + index * 100).ms,
                ),
          if (!isMobile && !isLeft) ...[
            const SizedBox(width: 20),
            Expanded(
              child: _buildExperienceCard(experience, index, isMobile)
                  .animate(target: _isVisible ? 1 : 0)
                  .fadeIn(duration: 800.ms, delay: (400 + index * 100).ms)
                  .slideX(begin: 0.3, end: 0),
            ),
          ],
          if (isMobile)
            Expanded(
              child: _buildExperienceCard(experience, index, isMobile)
                  .animate(target: _isVisible ? 1 : 0)
                  .fadeIn(duration: 800.ms, delay: (400 + index * 100).ms)
                  .slideY(begin: 0.3, end: 0),
            ),
        ],
      ),
    );
  }

  Widget _buildTimelineDot() {
    return Column(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppTheme.magicGradient,
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryMagic.withValues(alpha: 0.5),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
        Container(
          width: 2,
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppTheme.primaryMagic,
                AppTheme.primaryMagic.withValues(alpha: 0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExperienceCard(
    ExperienceData experience,
    int index,
    bool isMobile,
  ) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Company and duration
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      experience.company,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppTheme.primaryMagic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      experience.role,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  gradient: AppTheme.magicGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  experience.endDate == 'Present' ? 'Current' : 'Past',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Location and duration
          // Location and duration
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 16,
                    color: AppTheme.primaryMagic,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    experience.location,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: AppTheme.secondaryMagic,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    experience.duration,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Description
          Text(
            experience.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          // Technologies
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: experience.technologies.map((tech) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.darkCard,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppTheme.primaryMagic.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  tech,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppTheme.primaryMagic),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
