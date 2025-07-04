import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shamil_technologies/app/constants/app_colors.dart';
import 'package:shamil_technologies/app/utils/responsive.dart';
import 'dart:math' as math;

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late AnimationController _particleController;
  late AnimationController _glowController;
  late Animation<double> _floatingAnimation;
  late Animation<double> _particleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    _floatingController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat(reverse: true);

    _particleController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _glowController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _floatingAnimation = Tween<double>(
      begin: 0,
      end: 20,
    ).animate(CurvedAnimation(
      parent: _floatingController,
      curve: Curves.easeInOut,
    ));

    _particleAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(_particleController);

    _glowAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _particleController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return Container(
      height: screenHeight,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppColors.darkGradient,
      ),
      child: Stack(
        children: [
          // Animated Background Particles
          ...List.generate(
              15, (index) => _buildParticle(index, screenWidth, screenHeight)),

          // Gradient Orbs
          _buildGradientOrb(context, screenWidth, screenHeight),

          // Main Content: Wrapped in a SingleChildScrollView to prevent overflow.
          // A Container with minHeight ensures the content area is at least as
          // tall as the screen, and Center positions the content within it.
          SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(minHeight: screenHeight),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 80 : (isTablet ? 60 : 24),
                    vertical: 80, // Increased vertical padding for better spacing
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo Animation
                      FadeInDown(
                        duration: const Duration(milliseconds: 1000),
                        child: AnimatedBuilder(
                          animation: _floatingAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, -_floatingAnimation.value),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: AppColors.primaryGradient,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primaryGradientStart
                                          .withOpacity(0.3),
                                      blurRadius: 30,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.code,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Main Title
                      FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: ShaderMask(
                          shaderCallback: (bounds) =>
                              AppColors.primaryGradient.createShader(bounds),
                          child: Text(
                            'شامل تكنولوجيز',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isDesktop ? 80 : (isTablet ? 60 : 48),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.1,
                              letterSpacing: -2.0,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Subtitle
                      FadeInUp(
                        duration: const Duration(milliseconds: 1400),
                        delay: const Duration(milliseconds: 200),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.glassBackground,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: AppColors.glassBorder),
                          ),
                          child: Text(
                            'بيتك البرمجي المتكامل',
                            style: TextStyle(
                              fontSize: isDesktop ? 24 : (isTablet ? 20 : 18),
                              color: AppColors.lightGray,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Description
                      FadeInUp(
                        duration: const Duration(milliseconds: 1600),
                        delay: const Duration(milliseconds: 400),
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 600),
                          child: Text(
                            'نحول أفكارك إلى حلول تقنية متقدمة بأحدث التقنيات والأدوات. رؤيتك هي كودنا.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isDesktop ? 20 : (isTablet ? 18 : 16),
                              color: AppColors.mediumGray,
                              height: 1.6,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 50),

                      // CTA Buttons
                      FadeInUp(
                        duration: const Duration(milliseconds: 1800),
                        delay: const Duration(milliseconds: 600),
                        child: Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          alignment: WrapAlignment.center,
                          children: [
                            _buildGradientButton(
                              text: 'اكتشف خدماتنا',
                              onPressed: () {},
                              isPrimary: true,
                            ),
                            _buildGlassButton(
                              text: 'تواصل معنا',
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 60),

                      // Stats
                      FadeInUp(
                        duration: const Duration(milliseconds: 2000),
                        delay: const Duration(milliseconds: 800),
                        child: _buildStatsRow(isDesktop, isTablet),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParticle(int index, double screenWidth, double screenHeight) {
    return AnimatedBuilder(
      animation: _particleAnimation,
      builder: (context, child) {
        final double x = (screenWidth / 2) +
            (100 + index * 50) * math.cos(_particleAnimation.value + index);
        final double y = (screenHeight / 2) +
            (100 + index * 30) * math.sin(_particleAnimation.value + index);

        return Positioned(
          left: x,
          top: y,
          child: Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryGradientStart.withOpacity(0.3),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryGradientStart.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGradientOrb(
      BuildContext context, double screenWidth, double screenHeight) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Positioned(
          right: screenWidth * 0.1,
          top: screenHeight * 0.2,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primaryGradientStart
                      .withOpacity(0.3 * _glowAnimation.value),
                  AppColors.primaryGradientEnd
                      .withOpacity(0.1 * _glowAnimation.value),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGradientButton({
    required String text,
    required VoidCallback onPressed,
    bool isPrimary = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryGradientStart.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildGlassButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.glassBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow(bool isDesktop, bool isTablet) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.glassBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Wrap(
        spacing: isDesktop ? 60 : 30,
        runSpacing: 20,
        alignment: WrapAlignment.center,
        children: [
          _buildStat('100+', 'مشروع مكتمل'),
          _buildStat('50+', 'عميل سعيد'),
          _buildStat('5+', 'سنوات خبرة'),
          _buildStat('24/7', 'دعم فني'),
        ],
      ),
    );
  }

  Widget _buildStat(String number, String label) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.accentGradient.createShader(bounds),
          child: Text(
            number,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.mediumGray,
          ),
        ),
      ],
    );
  }
}
