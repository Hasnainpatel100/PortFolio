import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/portfolio_data.dart';
import '../../bloc/portfolio_bloc.dart';
import '../../bloc/portfolio_event.dart';
import '../../bloc/portfolio_state.dart';
import '../common/glass_card.dart';

/// Projects Gallery Section
class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  bool _isVisible = true; // Show immediately
  String? _selectedCategory;

  final List<String> categories = [
    'All',
    'Professional',
    'Freelance',
    'Personal',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return VisibilityDetector(
      key: const Key('projects-section'),
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
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppTheme.darkSurface, AppTheme.darkBg],
          ),
        ),
        child: Column(
          children: [
            _buildSectionTitle(context),
            const SizedBox(height: 40),
            _buildCategoryFilter(isMobile),
            const SizedBox(height: 60),
            _buildProjectsGrid(isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context) {
    return Column(
      children: [
        Text(
              '04.',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.cosmicIndigo,
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
                'Featured Projects',
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

  Widget _buildCategoryFilter(bool isMobile) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: categories.map((category) {
        final isSelected =
            _selectedCategory == category ||
            (_selectedCategory == null && category == 'All');
        return _buildCategoryChip(category, isSelected);
      }).toList(),
    );
  }

  Widget _buildCategoryChip(String category, bool isSelected) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(
            () => _selectedCategory = category == 'All' ? null : category,
          );
          context.read<PortfolioBloc>().add(
            FilterProjects(category == 'All' ? null : category),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            gradient: isSelected ? AppTheme.magicGradient : null,
            color: isSelected ? null : AppTheme.darkCard,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: isSelected
                  ? Colors.transparent
                  : AppTheme.primaryMagic.withValues(alpha: 0.3),
              width: 2,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppTheme.primaryMagic.withValues(alpha: 0.4),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: Text(
            category,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectsGrid(bool isMobile) {
    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        final projects = state is PortfolioLoaded
            ? state.filteredProjects
            : PortfolioData.projects;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile
                ? 1
                : (MediaQuery.of(context).size.width < 1200 ? 2 : 3),
            childAspectRatio: isMobile ? 0.7 : 0.8,
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return _buildProjectCard(projects[index], index);
          },
        );
      },
    );
  }

  Widget _buildProjectCard(ProjectData project, int index) {
    return GlassCard(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project image placeholder
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryMagic.withValues(alpha: 0.3),
                      AppTheme.secondaryMagic.withValues(alpha: 0.3),
                    ],
                  ),
                ),
                child: project.imageUrl.isNotEmpty
                    ? ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                        child: Image.asset(
                          project.imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(
                                child: Icon(
                                  Icons.videocam_rounded,
                                  size: 60,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                        ),
                      )
                    : const Center(
                        child: Icon(
                          Icons.image,
                          size: 60,
                          color: AppTheme.textSecondary,
                        ),
                      ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryMagic.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          project.category,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: AppTheme.primaryMagic,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Title
                      Text(
                        project.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      // Subtitle
                      Text(
                        project.subtitle,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      // Description
                      Expanded(
                        child: Text(
                          project.description,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: AppTheme.textSecondary,
                                height: 1.6,
                              ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Technologies
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: project.technologies.take(3).map((tech) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.darkCard,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              tech,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    fontSize: 11,
                                    color: AppTheme.accentCyan,
                                  ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
        .animate(target: _isVisible ? 1 : 0)
        .fadeIn(duration: 800.ms, delay: (400 + index * 100).ms)
        .slideY(begin: 0.3, end: 0);
  }
}
