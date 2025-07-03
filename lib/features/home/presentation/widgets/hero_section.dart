import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shamil_technologies/app/constants/app_colors.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: double.infinity,
      color: AppColors.deepSpaceNavy, // Uses the main background color
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInDown(
              duration: const Duration(milliseconds: 1200),
              child: const Text(
                'شامل تكنولوجيز - بيتك البرمجي المتكامل',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            FadeInUp(
              duration: const Duration(milliseconds: 1400),
              child: const Text(
                'رؤيتك. كودنا. وجهة واحدة.',
                style: TextStyle(
                  fontSize: 24,
                  color: AppColors.mediumBlue, // ✨ Updated Color
                ),
              ),
            ),
            const SizedBox(height: 40),
            FadeInUp(
              duration: const Duration(milliseconds: 1600),
              // This button automatically uses the vibrantTeal and deepSpaceNavy
              // colors defined in your AppTheme.
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to contact page
                },
                child: const Text('اكتشف خدماتنا'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}