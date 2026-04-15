import 'package:flutter/material.dart';

/// Skeuomorphic animated skill progress bar with realistic gauge effect
class AnimatedProgressBar extends StatefulWidget {
  final String skillName;
  final int percentage;
  final String icon;
  final String? category;
  final int yearsOfExperience;

  const AnimatedProgressBar({
    super.key,
    required this.skillName,
    required this.percentage,
    required this.icon,
    this.category,
    this.yearsOfExperience = 0,
  });

  @override
  State<AnimatedProgressBar> createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: widget.percentage / 100,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startAnimation() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        transform: _isHovered
            ? Matrix4.translationValues(0, -2, 0)
            : Matrix4.identity(),
        decoration: _buildSkeuomorphicDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Skill header with icon, name, and badges
            Row(
              children: [
                // Icon with metallic badge
                _buildIconBadge(),
                const SizedBox(width: 12),
                // Skill name and category
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.skillName,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withValues(alpha: 0.5),
                                  offset: const Offset(1, 1),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      if (widget.category != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          widget.category!,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: const Color(0xFF808080),
                                fontSize: 11,
                                letterSpacing: 0.3,
                              ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ],
                  ),
                ),
                // Percentage display with embossed style
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return _buildPercentageDisplay(
                      (_animation.value * 100).toInt(),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 14),
            // Skeuomorphic progress bar
            _buildProgressBar(),
            const SizedBox(height: 12),
            // Experience and proficiency level
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Years of experience
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 14,
                        color: const Color(0xFF808080),
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          '${widget.yearsOfExperience} ${widget.yearsOfExperience == 1 ? 'Year' : 'Years'} Experience',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: const Color(0xFF808080),
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Proficiency level badge
                _buildProficiencyBadge(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildSkeuomorphicDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.lerp(const Color(0xFF2A2A2A), Colors.white, 0.05)!,
          const Color(0xFF2A2A2A),
          Color.lerp(const Color(0xFF2A2A2A), Colors.black, 0.1)!,
        ],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.10),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: _isHovered ? 0.5 : 0.4),
          blurRadius: _isHovered ? 16 : 12,
          offset: Offset(0, _isHovered ? 8 : 6),
        ),
        if (_isHovered)
          BoxShadow(
            color: _getProficiencyColor().withValues(alpha: 0.15),
            blurRadius: 20,
            spreadRadius: -2,
          ),
      ],
    );
  }

  Widget _buildIconBadge() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF404040),
            const Color(0xFF303030),
            const Color(0xFF252525),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Text(widget.icon, style: const TextStyle(fontSize: 20)),
    );
  }

  Widget _buildPercentageDisplay(int value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.lerp(_getProficiencyColor(), Colors.white, 0.2)!,
            _getProficiencyColor(),
            Color.lerp(_getProficiencyColor(), Colors.black, 0.2)!,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.20),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
          BoxShadow(
            color: _getProficiencyColor().withValues(alpha: 0.3),
            blurRadius: 8,
            spreadRadius: -2,
          ),
        ],
      ),
      child: Text(
        '$value%',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15,
          shadows: [
            Shadow(
              color: Colors.black.withValues(alpha: 0.5),
              offset: const Offset(1, 1),
              blurRadius: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Stack(
      children: [
        // Inset track (recessed groove)
        Container(
          height: 12,
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Colors.black.withValues(alpha: 0.4),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 4,
                offset: const Offset(0, 2),
                spreadRadius: -2,
              ),
            ],
          ),
        ),
        // Animated progress fill with 3D effect
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: _animation.value,
              child: Container(
                height: 12,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.lerp(_getProficiencyColor(), Colors.white, 0.3)!,
                      _getProficiencyColor(),
                      Color.lerp(_getProficiencyColor(), Colors.black, 0.2)!,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: _getProficiencyColor().withValues(alpha: 0.5),
                      blurRadius: 8,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                // Inner highlight strip
                child: Stack(
                  children: [
                    Positioned(
                      top: 2,
                      left: 4,
                      right: 4,
                      height: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1),
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.white.withValues(alpha: 0.4),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildProficiencyBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      child: Text(
        _getProficiencyLevel(),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: _getProficiencyColor(),
          fontWeight: FontWeight.bold,
          fontSize: 9,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Color _getProficiencyColor() {
    if (widget.percentage >= 90) return const Color(0xFF4CAF50); // Green
    if (widget.percentage >= 75) return const Color(0xFF2196F3); // Blue
    if (widget.percentage >= 60) return const Color(0xFFFF9800); // Orange
    return const Color(0xFFFF5722); // Deep Orange
  }

  String _getProficiencyLevel() {
    if (widget.percentage >= 90) return 'EXPERT';
    if (widget.percentage >= 75) return 'ADVANCED';
    if (widget.percentage >= 60) return 'INTERMEDIATE';
    return 'BEGINNER';
  }
}

/// Skeuomorphic Skill card with icon and level
class SkillCard extends StatefulWidget {
  final String skillName;
  final String icon;
  final int level;
  final Color? accentColor;

  const SkillCard({
    super.key,
    required this.skillName,
    required this.icon,
    required this.level,
    this.accentColor,
  });

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final accentColor = widget.accentColor ?? const Color(0xFF2196F3);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(20),
          transform: _isPressed
              ? Matrix4.translationValues(0, 2, 0)
              : (_isHovered
                    ? Matrix4.translationValues(0, -3, 0)
                    : Matrix4.identity()),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _isPressed
                  ? [const Color(0xFF252525), const Color(0xFF2A2A2A)]
                  : [
                      Color.lerp(const Color(0xFF2A2A2A), Colors.white, 0.05)!,
                      const Color(0xFF2A2A2A),
                      Color.lerp(const Color(0xFF2A2A2A), Colors.black, 0.08)!,
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
                      offset: const Offset(0, 1),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: _isHovered ? 0.5 : 0.4,
                      ),
                      blurRadius: _isHovered ? 16 : 10,
                      offset: Offset(0, _isHovered ? 8 : 5),
                    ),
                    if (_isHovered)
                      BoxShadow(
                        color: accentColor.withValues(alpha: 0.2),
                        blurRadius: 16,
                        spreadRadius: -4,
                      ),
                  ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon with metallic container
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [const Color(0xFF404040), const Color(0xFF303030)],
                  ),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 6,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Text(
                  widget.icon,
                  style: TextStyle(fontSize: _isHovered ? 32 : 28, height: 1),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.skillName,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      offset: const Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Level badge with 3D effect
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.lerp(accentColor, Colors.white, 0.15)!,
                      accentColor,
                      Color.lerp(accentColor, Colors.black, 0.15)!,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.20),
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
                  '${widget.level}%',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        offset: const Offset(1, 1),
                        blurRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
