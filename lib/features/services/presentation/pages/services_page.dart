import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shamil_technologies/app/constants/app_colors.dart';
import 'package:shamil_technologies/app/utils/responsive.dart';
import 'package:shamil_technologies/core/data/repositories/content_repository.dart';
import 'package:shamil_technologies/features/services/presentation/widgets/service_card.dart';
import 'package:shamil_technologies/features/shared/widgets/main_layout.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _backgroundController;
  late Animation<double> _headerFadeAnimation;
  late Animation<Offset> _headerSlideAnimation;
  late Animation<double> _backgroundAnimation;

  @override
  void initState() {
    super.initState();
    
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    
    _headerFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _headerController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));
    
    _headerSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _headerController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
    ));
    
    _backgroundAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_backgroundController);
    
    // Start animations
    _headerController.forward();
  }

  @override
  void dispose() {
    _headerController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final services = ContentRepository.services;
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return MainLayout(
      child: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.darkGradient,
        ),
        child: Stack(
          children: [
            // Animated Background
            _buildAnimatedBackground(),
            
            // Main Content
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 120 : (isTablet ? 60 : 24),
                vertical: 80,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Header Section
                  _buildHeader(),
                  
                  const SizedBox(height: 80),
                  
                  // Services Grid
                  _buildServicesGrid(services, isDesktop, isTablet),
                  
                  const SizedBox(height: 100),
                  
                  // CTA Section
                  _buildCTASection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _backgroundAnimation,
      builder: (context, child) {
        return Positioned.fill(
          child: CustomPaint(
            painter: BackgroundPainter(_backgroundAnimation.value),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return AnimatedBuilder(
      animation: _headerController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _headerFadeAnimation,
          child: SlideTransition(
            position: _headerSlideAnimation,
            child: Column(
              children: [
                // Section Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    'خدماتنا',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Main Title
                ShaderMask(
                  shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
                  child: const Text(
                    'حلول تقنية متكاملة',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Subtitle
                Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: const Text(
                    'نقدم مجموعة شاملة من الخدمات التقنية المتطورة لتحويل أفكارك إلى واقع رقمي مبتكر',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.lightGray,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildServicesGrid(List services, bool isDesktop, bool isTablet) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = isDesktop ? 3 : (isTablet ? 2 : 1);
        double childAspectRatio = isDesktop ? 0.85 : (isTablet ? 0.9 : 1.1);
        
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            return FadeInUp(
              duration: const Duration(milliseconds: 600),
              delay: Duration(milliseconds: 150 * index),
              child: ServiceCard(
                service: services[index],
                index: index,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCTASection() {
    return FadeInUp(
      duration: const Duration(milliseconds: 800),
      delay: const Duration(milliseconds: 1000),
      child: Container(
        padding: const EdgeInsets.all(48),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryGradientStart.withOpacity(0.3),
              blurRadius: 30,
              spreadRadius: 0,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Column(
          children: [
            const Text(
              'جاهز لبدء مشروعك؟',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            
            const SizedBox(height: 16),
            
            const Text(
              'تواصل معنا الآن واحصل على استشارة مجانية لمشروعك القادم',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                height: 1.5,
              ),
            ),
            
            const SizedBox(height: 32),
            
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: [
                _buildCTAButton(
                  text: 'احجز استشارة مجانية',
                  onPressed: () {},
                  isPrimary: true,
                ),
                _buildCTAButton(
                  text: 'تصفح أعمالنا',
                  onPressed: () {},
                  isPrimary: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCTAButton({
    required String text,
    required VoidCallback onPressed,
    required bool isPrimary,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isPrimary ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isPrimary ? null : Border.all(color: Colors.white, width: 2),
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
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isPrimary ? AppColors.primaryGradientStart : Colors.white,
          ),
        ),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final double animationValue;

  BackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.primaryGradientStart.withOpacity(0.1),
          AppColors.primaryGradientEnd.withOpacity(0.05),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(
        center: Offset(size.width * 0.8, size.height * 0.3),
        radius: size.width * 0.4,
      ));

    canvas.drawCircle(
      Offset(
        size.width * 0.8 + (50 * animationValue),
        size.height * 0.3,
      ),
      size.width * 0.4,
      paint,
    );

    // Second orb
    final paint2 = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.accentGradientStart.withOpacity(0.08),
          AppColors.accentGradientEnd.withOpacity(0.03),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(
        center: Offset(size.width * 0.2, size.height * 0.7),
        radius: size.width * 0.3,
      ));

    canvas.drawCircle(
      Offset(
        size.width * 0.2 - (30 * animationValue),
        size.height * 0.7,
      ),
      size.width * 0.3,
      paint2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}