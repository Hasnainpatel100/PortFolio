import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/portfolio_data.dart';
import '../../bloc/portfolio_bloc.dart';
import '../../bloc/portfolio_event.dart';
import '../../bloc/portfolio_state.dart';
import '../common/glass_card.dart';
import '../common/magic_button.dart';

/// Skeuomorphic Contact Form Section
class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _isVisible = true;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<PortfolioBloc>().add(
        SubmitContactForm(
          name: _nameController.text,
          email: _emailController.text,
          message: _messageController.text,
        ),
      );
    }
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return VisibilityDetector(
      key: const Key('contact-section'),
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF1A1A1A),
              const Color(0xFF151515),
              const Color(0xFF101010),
            ],
          ),
        ),
        child: Column(
          children: [
            _buildSectionTitle(context),
            const SizedBox(height: 60),
            if (isMobile) _buildMobileLayout() else _buildDesktopLayout(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context) {
    return Column(
      children: [
        // Embossed badge
        Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Text(
                'CONNECT',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: const Color(0xFF00D4FF),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: 2,
                ),
              ),
            )
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.3, end: 0),
        const SizedBox(height: 16),
        Text(
              "Let's Build The Future",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
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
            )
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms, delay: 200.ms)
            .slideY(begin: 0.3, end: 0),
        const SizedBox(height: 16),
        Container(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Text(
                "Ready to engineer the next big thing? I bring the code, the architecture, and the magic. You bring the vision.",
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: const Color(0xFF808080)),
              ),
            )
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms, delay: 400.ms),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildContactInfo()),
        const SizedBox(width: 60),
        Expanded(child: _buildContactForm()),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildContactForm(),
        const SizedBox(height: 40),
        _buildContactInfo(),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
              "Let's Connect",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    offset: const Offset(1, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            )
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 800.ms, delay: 600.ms)
            .slideX(begin: -0.2, end: 0),
        const SizedBox(height: 24),
        _buildContactItem(
          icon: Icons.email,
          label: 'Email',
          value: PortfolioData.email,
          onTap: () => _launchURL('mailto:${PortfolioData.email}'),
        ),
        const SizedBox(height: 20),
        _buildContactItem(
          icon: Icons.phone,
          label: 'Phone',
          value: PortfolioData.phone,
          onTap: () => _launchURL('tel:${PortfolioData.phone}'),
        ),
        const SizedBox(height: 20),
        _buildContactItem(
          icon: Icons.location_on,
          label: 'Location',
          value: PortfolioData.location,
        ),
        const SizedBox(height: 40),
        Text(
          'Follow Me',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        _buildSocialLinks(),
      ],
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String label,
    required String value,
    VoidCallback? onTap,
  }) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      onTap: onTap,
      child: Row(
        children: [
          // Skeuomorphic icon container
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF3A7BD5),
                  const Color(0xFF2563EB),
                  const Color(0xFF1D4ED8),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.15),
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
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF808080),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          if (onTap != null)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF252525),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Color(0xFF00D4FF),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSocialLinks() {
    final socials = [
      {
        'icon': FontAwesomeIcons.linkedin,
        'label': 'LinkedIn',
        'url': PortfolioData.linkedIn,
        'color': const Color(0xFF0A66C2),
      },
      {
        'icon': FontAwesomeIcons.github,
        'label': 'GitHub',
        'url': PortfolioData.github,
        'color': const Color(0xFF6E6E6E),
      },
      {
        'icon': FontAwesomeIcons.envelope,
        'label': 'Email',
        'url': 'mailto:${PortfolioData.email}',
        'color': const Color(0xFF00D4FF),
      },
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: socials.map((social) {
        return _buildSocialButton(
          icon: social['icon'] as IconData,
          label: social['label'] as String,
          url: social['url'] as String,
          color: social['color'] as Color,
        );
      }).toList(),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required String url,
    required Color color,
  }) {
    return _SkeuomorphicSocialButton(
      icon: icon,
      label: label,
      color: color,
      onTap: () => _launchURL(url),
    );
  }

  Widget _buildContactForm() {
    return BlocConsumer<PortfolioBloc, PortfolioState>(
      listener: (context, state) {
        if (state is ContactFormSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
          _formKey.currentState?.reset();
          _nameController.clear();
          _emailController.clear();
          _messageController.clear();
        } else if (state is ContactFormError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        final isSubmitting = state is ContactFormSubmitting;

        return GlassCard(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSkeuomorphicTextField(
                      controller: _nameController,
                      label: 'Your Name',
                      hint: 'John Doe',
                      icon: Icons.person,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildSkeuomorphicTextField(
                      controller: _emailController,
                      label: 'Your Email',
                      hint: 'john@example.com',
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildSkeuomorphicTextField(
                      controller: _messageController,
                      label: 'Your Message',
                      hint: 'Tell me about your project...',
                      icon: Icons.message,
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your message';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    MagicButton(
                      text: isSubmitting ? 'Sending...' : 'Send Message',
                      icon: isSubmitting ? null : FontAwesomeIcons.paperPlane,
                      onPressed: isSubmitting ? () {} : _submitForm,
                    ),
                  ],
                ),
              ),
            )
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 800.ms, delay: 600.ms)
            .slideX(begin: 0.2, end: 0);
      },
    );
  }

  Widget _buildSkeuomorphicTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: const Color(0xFF808080),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.black.withValues(alpha: 0.4),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
                spreadRadius: -2,
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            validator: validator,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: const Color(0xFF606060)),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 12, right: 8),
                child: Icon(icon, color: const Color(0xFF00D4FF), size: 20),
              ),
              prefixIconConstraints: const BoxConstraints(minWidth: 44),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: maxLines > 1 ? 16 : 14,
              ),
              errorStyle: const TextStyle(color: Color(0xFFEF5350)),
            ),
          ),
        ),
      ],
    );
  }
}

/// Skeuomorphic social button with 3D press effect
class _SkeuomorphicSocialButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _SkeuomorphicSocialButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  State<_SkeuomorphicSocialButton> createState() =>
      _SkeuomorphicSocialButtonState();
}

class _SkeuomorphicSocialButtonState extends State<_SkeuomorphicSocialButton> {
  bool _isPressed = false;
  bool _isHovered = false;

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
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          transform: _isPressed
              ? Matrix4.translationValues(0, 2, 0)
              : Matrix4.identity(),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _isPressed
                  ? [const Color(0xFF252525), const Color(0xFF2A2A2A)]
                  : [
                      Color.lerp(const Color(0xFF2A2A2A), Colors.white, 0.05)!,
                      const Color(0xFF2A2A2A),
                      Color.lerp(const Color(0xFF2A2A2A), Colors.black, 0.05)!,
                    ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isPressed
                  ? Colors.black.withValues(alpha: 0.25)
                  : Colors.white.withValues(alpha: 0.10),
              width: 1,
            ),
            boxShadow: _isPressed
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: _isHovered ? 12 : 8,
                      offset: Offset(0, _isHovered ? 6 : 4),
                    ),
                    if (_isHovered)
                      BoxShadow(
                        color: widget.color.withValues(alpha: 0.2),
                        blurRadius: 12,
                        spreadRadius: -2,
                      ),
                  ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, color: widget.color, size: 20),
              const SizedBox(width: 12),
              Text(
                widget.label,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
