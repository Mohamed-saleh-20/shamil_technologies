import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shamil_technologies/app/constants/app_colors.dart';
import 'package:shamil_technologies/app/utils/responsive.dart';
import 'package:go_router/go_router.dart';

class AboutUsSection extends StatefulWidget {
  const AboutUsSection({super.key});

  @override
  State<AboutUsSection> createState() => _AboutUsSectionState();
}

class _AboutUsSectionState extends State<AboutUsSection>
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late AnimationController _pulseController;
  late Animation<double> _floatingAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _floatingAnimation = Tween<double>(
      begin: -10,
      end: 10,
    ).animate(CurvedAnimation(
      parent: _floatingController,
      curve: Curves.easeInOut,
    ));

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 24),
      child: Column(
        children: [
          // Animated Title with Particles Effect
          _buildAnimatedTitle(),
          const SizedBox(height: 80),
          
          // Main Content with Hexagonal Layout
          _buildMainContent(isDesktop, screenWidth),
          
          const SizedBox(height: 60),
          
          // Interactive Stats Section
          _buildInteractiveStats(),
          
          const SizedBox(height: 80),
          
          // Floating CTA Button
          _buildFloatingCTA(),
        ],
      ),
    );
  }

  Widget _buildAnimatedTitle() {
    return Stack(
      children: [
        // Background Glow Effect
        AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _pulseAnimation.value,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primaryGradientStart.withOpacity(0.3),
                      AppColors.primaryGradientEnd.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        
        // Main Title
        FadeInDown(
          duration: const Duration(milliseconds: 1000),
          child: Column(
            children: [
              ShaderMask(
                shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
                child: const Text(
                  'من نحن؟',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 4,
                width: 100,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent(bool isDesktop, double screenWidth) {
    return Container(
      constraints: BoxConstraints(maxWidth: isDesktop ? 1200 : screenWidth),
      child: Stack(
        children: [
          // Background Geometric Shapes
          ..._buildBackgroundShapes(),
          
          // Main Content Grid
          Column(
            children: [
              if (isDesktop)
                _buildDesktopLayout()
              else
                _buildMobileLayout(),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildBackgroundShapes() {
    return [
      Positioned(
        top: -50,
        right: -50,
        child: AnimatedBuilder(
          animation: _floatingAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(_floatingAnimation.value, _floatingAnimation.value * 0.5),
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.accentGradientStart.withOpacity(0.2),
                      AppColors.accentGradientEnd.withOpacity(0.1),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      Positioned(
        bottom: -80,
        left: -80,
        child: AnimatedBuilder(
          animation: _floatingAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(-_floatingAnimation.value * 0.8, _floatingAnimation.value),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.vibrantTeal.withOpacity(0.15),
                      AppColors.electricBlue.withOpacity(0.1),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ];
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Side - Story Card
        Expanded(
          flex: 2,
          child: FadeInLeft(
            duration: const Duration(milliseconds: 1200),
            child: _buildStoryCard(),
          ),
        ),
        
        const SizedBox(width: 60),
        
        // Right Side - Features Hexagon
        Expanded(
          flex: 1,
          child: FadeInRight(
            duration: const Duration(milliseconds: 1200),
            child: _buildHexagonFeatures(),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        FadeInUp(
          duration: const Duration(milliseconds: 1200),
          child: _buildStoryCard(),
        ),
        const SizedBox(height: 60),
        FadeInUp(
          duration: const Duration(milliseconds: 1400),
          child: _buildHexagonFeatures(),
        ),
      ],
    );
  }

  Widget _buildStoryCard() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.glassBackground,
            AppColors.darkSlate.withOpacity(0.8),
          ],
        ),
        border: Border.all(
          color: AppColors.glassBorder,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryGradientStart.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon with Glow
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.primaryGradient,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryGradientStart.withOpacity(0.5),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(
              Icons.rocket_launch_rounded,
              color: Colors.white,
              size: 40,
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Title
          ShaderMask(
            shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
            child: const Text(
              'شريكك التقني نحو النجاح',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.3,
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Description
          const Text(
            'في شامل تكنولوجيز، نحن لا نكتفي بكتابة الأكواد البرمجية، بل نصنع حلولاً تدفع عجلة أعمالك نحو الأمام. فريقنا من الخبراء مكرس لتحويل أفكارك الرائدة إلى واقع رقمي ملموس.',
            style: TextStyle(
              fontSize: 18,
              color: AppColors.lightGray,
              height: 1.8,
              letterSpacing: 0.5,
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Innovation Badges
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildBadge('تطوير مبتكر', Icons.lightbulb_outline_rounded),
              _buildBadge('حلول ذكية', Icons.psychology_rounded),
              _buildBadge('تقنيات حديثة', Icons.auto_awesome_rounded),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accentGradientStart.withOpacity(0.2),
            AppColors.accentGradientEnd.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.accentGradientStart.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: AppColors.accentGradientStart,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.lightGray,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHexagonFeatures() {
    return AnimatedBuilder(
      animation: _floatingAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatingAnimation.value),
          child: Container(
            height: 400,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Center Hexagon
                _buildHexagon(
                  size: 120,
                  color: AppColors.primaryGradientStart,
                  icon: Icons.groups_rounded,
                  label: 'فريق\nخبراء',
                  offset: const Offset(0, 0),
                ),
                
                // Surrounding Hexagons
                _buildHexagon(
                  size: 80,
                  color: AppColors.vibrantTeal,
                  icon: Icons.speed_rounded,
                  label: 'سرعة\nالتنفيذ',
                  offset: const Offset(-100, -60),
                ),
                
                _buildHexagon(
                  size: 80,
                  color: AppColors.electricBlue,
                  icon: Icons.security_rounded,
                  label: 'أمان\nعالي',
                  offset: const Offset(100, -60),
                ),
                
                _buildHexagon(
                  size: 80,
                  color: AppColors.neonGreen,
                  icon: Icons.support_agent_rounded,
                  label: 'دعم\nمتواصل',
                  offset: const Offset(-100, 60),
                ),
                
                _buildHexagon(
                  size: 80,
                  color: AppColors.warningOrange,
                  icon: Icons.trending_up_rounded,
                  label: 'نمو\nمستدام',
                  offset: const Offset(100, 60),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHexagon({
    required double size,
    required Color color,
    required IconData icon,
    required String label,
    required Offset offset,
  }) {
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withOpacity(0.8),
              color.withOpacity(0.3),
            ],
          ),
          border: Border.all(
            color: color.withOpacity(0.5),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: size * 0.3,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: size * 0.1,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveStats() {
    return FadeInUp(
      duration: const Duration(milliseconds: 1600),
      child: Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.mediumSlate.withOpacity(0.5),
              AppColors.lightSlate.withOpacity(0.3),
            ],
          ),
          border: Border.all(color: AppColors.glassBorder),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem('50+', 'مشروع مكتمل', Icons.check_circle_outline_rounded),
            _buildStatItem('50+', 'عميل راضي', Icons.sentiment_very_satisfied_rounded),
            _buildStatItem('2+', 'سنوات خبرة', Icons.timeline_rounded),
            _buildStatItem('24/7', 'دعم فني', Icons.support_agent_rounded),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String number, String label, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.accentGradient,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          number,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.lightGray,
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingCTA() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + (_pulseAnimation.value - 1.0) * 0.05,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              gradient: AppColors.primaryGradient,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryGradientStart.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () => context.go('/portfolio'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'استكشف رحلتنا',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}