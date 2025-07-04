import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shamil_technologies/app/constants/app_colors.dart';
import 'package:shamil_technologies/app/utils/responsive.dart';
import 'package:go_router/go_router.dart';

class AboutUsSection extends StatelessWidget {
  const AboutUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        children: [
          FadeInDown(
            child: const Text(
              'من نحن؟',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          const SizedBox(height: 40),
          Flex(
            direction: isDesktop ? Axis.horizontal : Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            children: [
              // Text Content
              Expanded(
                flex: 3,
                child: FadeInLeft(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'شريكك التقني نحو النجاح',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryGradientStart,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'في شامل تكنولوجيز، نحن لا نكتفي بكتابة الأكواد البرمجية، بل نصنع حلولاً تدفع عجلة أعمالك نحو الأمام. فريقنا من الخبراء مكرس لتحويل أفكارك الرائدة إلى واقع رقمي ملموس، باستخدام أحدث التقنيات وأفضل الممارسات لضمان تقديم منتجات تتجاوز توقعاتك.',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.lightGray,
                          height: 1.7,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => context.go('/portfolio'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: AppColors.glassBorder),
                          ),
                        ),
                        child: const Text(
                          'اكتشف أعمالنا',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (isDesktop) const SizedBox(width: 60),
              if (!isDesktop) const SizedBox(height: 40),
              // Visual Content
              Expanded(
                flex: 2,
                child: FadeInRight(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: AppColors.darkGradient,
                      border: Border.all(color: AppColors.glassBorder),
                    ),
                    child: Column(
                      children: [
                        _buildFeatureRow(Icons.code_rounded, 'تطوير مخصص'),
                        _buildFeatureRow(Icons.layers_rounded, 'حلول متكاملة'),
                        _buildFeatureRow(Icons.support_agent_rounded, 'دعم فني متواصل'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryGradientStart, size: 24),
          const SizedBox(width: 16),
          Text(text, style: const TextStyle(fontSize: 18, color: Colors.white)),
        ],
      ),
    );
  }
}