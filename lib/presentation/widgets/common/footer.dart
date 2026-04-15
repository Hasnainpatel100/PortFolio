import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/portfolio_data.dart';

/// Footer Section - Skeuomorphic Design
class Footer extends StatelessWidget {
  const Footer({super.key});

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 40,
      ),
      decoration: BoxDecoration(
        // Skeuomorphic dark gradient
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF151515), Color(0xFF0A0A0A)],
        ),
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          if (!isMobile)
            _buildDesktopFooter(context)
          else
            _buildMobileFooter(context),
          const SizedBox(height: 30),
          // Skeuomorphic divider
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.white.withValues(alpha: 0.1),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildDesktopFooter(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildAboutColumn(context)),
        const SizedBox(width: 60),
        _buildQuickLinksColumn(context),
        const SizedBox(width: 60),
        _buildContactColumn(context),
      ],
    );
  }

  Widget _buildMobileFooter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAboutColumn(context),
        const SizedBox(height: 30),
        _buildQuickLinksColumn(context),
        const SizedBox(height: 30),
        _buildContactColumn(context),
      ],
    );
  }

  Widget _buildAboutColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          PortfolioData.fullName,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: const Color(0xFFE0E0E0),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Colors.black.withValues(alpha: 0.4),
              width: 1,
            ),
          ),
          child: Text(
            PortfolioData.title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: const Color(0xFF00D4FF)),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          PortfolioData.heroSubtitle,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF808080)),
        ),
        const SizedBox(height: 20),
        _buildSocialIcons(),
      ],
    );
  }

  Widget _buildQuickLinksColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Links',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFFE0E0E0),
          ),
        ),
        const SizedBox(height: 16),
        _buildFooterLink('Home'),
        _buildFooterLink('About'),
        _buildFooterLink('Skills'),
        _buildFooterLink('Experience'),
        _buildFooterLink('Projects'),
        _buildFooterLink('Contact'),
      ],
    );
  }

  Widget _buildContactColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Info',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFFE0E0E0),
          ),
        ),
        const SizedBox(height: 16),
        _buildContactInfo(Icons.email, PortfolioData.email),
        _buildContactInfo(Icons.phone, PortfolioData.phone),
        _buildContactInfo(Icons.location_on, PortfolioData.location),
      ],
    );
  }

  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            // Handle navigation
          },
          child: Text(
            text,
            style: const TextStyle(color: Color(0xFF808080), fontSize: 14),
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black.withValues(alpha: 0.3)),
            ),
            child: Icon(icon, color: const Color(0xFF00D4FF), size: 14),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(color: Color(0xFF808080), fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcons() {
    final socials = [
      {
        'icon': FontAwesomeIcons.linkedin,
        'url': PortfolioData.linkedIn,
        'color': const Color(0xFF00D4FF),
      },
      {
        'icon': FontAwesomeIcons.github,
        'url': PortfolioData.github,
        'color': const Color(0xFFE0E0E0),
      },
      {
        'icon': FontAwesomeIcons.envelope,
        'url': 'mailto:${PortfolioData.email}',
        'color': const Color(0xFF00D4FF),
      },
    ];

    return Row(
      children: socials.map((social) {
        return Padding(
          padding: const EdgeInsets.only(right: 16),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _launchURL(social['url'] as String),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  // Skeuomorphic button styling
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF2A2A2A), Color(0xFF1E1E1E)],
                  ),
                  borderRadius: BorderRadius.circular(12),
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
                child: Icon(
                  social['icon'] as IconData,
                  color: social['color'] as Color,
                  size: 20,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            '${DateTime.now().year} ${PortfolioData.fullName}. All rights reserved.',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: const Color(0xFF606060)),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.black.withValues(alpha: 0.3)),
          ),
          child: Text(
            'Built with Flutter',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: const Color(0xFF00D4FF)),
          ),
        ),
      ],
    );
  }
}
