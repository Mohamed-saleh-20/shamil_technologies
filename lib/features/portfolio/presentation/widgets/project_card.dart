import 'package:flutter/material.dart';
import 'package:shamil_technologies/app/constants/app_colors.dart';
import 'package:shamil_technologies/core/domain/entities/project.dart';
import 'dart:ui'; // Needed for ImageFilter.blur
import 'dart:math' as math;

class InnovativeProjectCard extends StatefulWidget {
  final Project project;
  final int index;
  final VoidCallback onTap;

  const InnovativeProjectCard({
    super.key,
    required this.project,
    required this.index,
    required this.onTap,
  });

  @override
  State<InnovativeProjectCard> createState() => _InnovativeProjectCardState();
}

class _InnovativeProjectCardState extends State<InnovativeProjectCard>
    with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late AnimationController _glowController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _glowAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _glowController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutCubic,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.02,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutCubic,
    ));

    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));

    // Start glow animation
    _glowController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });

    if (isHovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: Listenable.merge([_hoverController, _glowController]),
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Transform.rotate(
                angle: _rotationAnimation.value,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      // Main shadow
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                      // Glow effect on hover
                      if (_isHovered)
                        BoxShadow(
                          color: AppColors.primaryGradientStart
                              .withAlpha((0.4 * 255).round()),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      // Continuous animated glow
                      BoxShadow(
                        color: AppColors.accentGradientStart.withAlpha(
                            (0.2 * 255 * _glowAnimation.value).round()),
                        blurRadius: 25,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: [
                        // Main card content
                        _buildMainContent(),

                        // Glassmorphism overlay that appears on hover
                        _buildGlassmorphismOverlay(),

                        // Animated border that appears on hover
                        _buildAnimatedBorder(),

                        // Hover effects (e.g., "View Project" text)
                        _buildHoverEffects(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.darkSlate.withAlpha((0.95 * 255).round()),
            AppColors.darkSlate.withAlpha((0.85 * 255).round()),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Image Section
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Background image placeholder
                  Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.image,
                        size: 48,
                        color: Colors.white24,
                      ),
                    ),
                  ),

                  // Category badge
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.glassBackground.withAlpha((0.7 * 255).round()),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.glassBorder),
                      ),
                      // FIX: The 'category' field is missing from the Project entity.
                      // This section is commented out to prevent a compile error.
                      // To enable this, add `final String category;` to your Project class.
                      /*
                      child: Text(
                        widget.project.category,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.primaryGradientStart,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      */
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Project Info Section
          Expanded(
            flex: 3, // Gave more space for content
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    widget.project.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  // Description
                  Text(
                    widget.project.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.lightGray,
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const Spacer(), // Pushes tags to the bottom

                  // FIX: The 'tags' field is missing from the Project entity.
                  // This section is commented out to prevent a compile error.
                  // To enable this, add `final List<String> tags;` to your Project class.
                  /*
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: widget.project.tags
                        .map((tag) => Chip(
                              label: Text(tag),
                              backgroundColor:
                                  AppColors.primaryGradientStart.withAlpha((0.2 * 255).round()),
                              labelStyle: const TextStyle(
                                  color: AppColors.lightGray, fontSize: 12),
                              side: BorderSide(
                                  color: AppColors.primaryGradientStart
                                      .withAlpha((0.5 * 255).round())),
                            ))
                        .toList(),
                  )
                  */
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassmorphismOverlay() {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: _isHovered ? 1.0 : 0.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedBorder() {
    return AnimatedBuilder(
      animation: _hoverController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primaryGradientStart
                  .withOpacity(0.8 * _hoverController.value),
              width: 2.0,
            ),
          ),
        );
      },
    );
  }

  Widget _buildHoverEffects() {
    return IgnorePointer(
      child: AnimatedOpacity(
        opacity: _isHovered ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          color: Colors.transparent, // Ensures the whole area is covered
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.visibility_outlined,
                    color: Colors.white, size: 40),
                SizedBox(height: 8),
                Text(
                  'View Project',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
