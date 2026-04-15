import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/portfolio_bloc.dart';
import '../bloc/portfolio_event.dart';
import '../widgets/hero/hero_section.dart';
import '../widgets/skills/skills_section.dart'; // Power Plant
import '../widgets/projects/commercial_district_section.dart'; // The City Center

import '../widgets/design/design_studio_section.dart'; // Design Studio
import '../widgets/contact/contact_section.dart';
import '../widgets/common/footer.dart';
import '../widgets/navigation/island_navigation.dart';
import '../widgets/chatbot/chatbot_widget.dart';
import '../../core/theme/app_theme.dart';

import '../widgets/common/grid_pattern_painter.dart';

/// Main Home Page - "The Dev Island"
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _projectsKey = GlobalKey();
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    // Load portfolio data
    context.read<PortfolioBloc>().add(const LoadPortfolioData());

    // Listen to scroll for back-to-top button
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 500 && !_showBackToTop) {
      setState(() => _showBackToTop = true);
    } else if (_scrollController.offset <= 500 && _showBackToTop) {
      setState(() => _showBackToTop = false);
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeInOutCubic,
    );
  }

  void _scrollToProjects() {
    final context = _projectsKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg, // The "Sea" of code
      body: NotificationListener<ScrollMetricsNotification>(
        onNotification: (notification) {
          return false;
        },
        child: Stack(
          children: [
            // Layer -1: Global Grid Pattern
            Positioned.fill(
              child: CustomPaint(
                painter: GridPatternPainter(
                  spacing: 50,
                  opacity: 0.05,
                  color: Colors.white,
                ),
              ),
            ),
            // Layer 0: The Navigation Path (Road & Vehicle)
            LayoutBuilder(
              builder: (context, constraints) {
                // Determine total scrollable height dynamically
                double totalHeight = 5000;
                if (_scrollController.hasClients &&
                    _scrollController.position.hasContentDimensions) {
                  final position = _scrollController.position;
                  totalHeight =
                      position.maxScrollExtent + position.viewportDimension;
                }

                return IslandNavigation(
                  scrollController: _scrollController,
                  contentHeight: totalHeight,
                );
              },
            ),

            // Layer 1: Main Content (The Districts)
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                // Section 1: The Landing (Hero)
                SliverToBoxAdapter(
                  child: HeroSection(onViewProjectsPressed: _scrollToProjects),
                ),

                // Section 2: Commercial District (The City Center & Projects)
                SliverToBoxAdapter(
                  key: _projectsKey,
                  child: const CityCenterSection(),
                ),



                // Section 4: The Power Plant (Backend/Skills)
                const SliverToBoxAdapter(child: SkillsSection()),

                // Section 5: Design Studio (UI/UX)
                const SliverToBoxAdapter(child: DesignStudioSection()),

                // Contact Section
                const SliverToBoxAdapter(child: ContactSection()),

                // Footer
                const SliverToBoxAdapter(child: Footer()),
              ],
            ),

            // Back to top button
            if (_showBackToTop)
              Positioned(
                bottom: 100,
                right: 24,
                child: _buildBackToTopButton(),
              ),

            // Chatbot widget (sticky)
            const ChatbotWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackToTopButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _scrollToTop,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 300),
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF1E3A8A), // Dark Blue
                      Color(0xFF3B82F6), // Formal Blue
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3B82F6).withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_upward,
                  color: AppTheme.textPrimary,
                  size: 24,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
