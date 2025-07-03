// lib/features/services/presentation/pages/services_page.dart

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shamil_technologies/app/constants/app_colors.dart';
import 'package:shamil_technologies/app/utils/responsive.dart';
import 'package:shamil_technologies/core/data/repositories/content_repository.dart';
import 'package:shamil_technologies/features/services/presentation/widgets/service_card.dart';
import 'package:shamil_technologies/features/shared/widgets/main_layout.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final services = ContentRepository.services;
    final screenWidth = MediaQuery.of(context).size.width;

    return MainLayout(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.isDesktop(context) ? 100 : 20,
          vertical: 50,
        ),
        child: Column(
          children: [
            FadeInDown(
              child: const Text(
                'خدماتنا',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            FadeInUp(
              child: const Text(
                'نقدم مجموعة متكاملة من الحلول التقنية لتحويل أفكارك إلى واقع ملموس.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.mediumBlue,
                ),
              ),
            ),
            const SizedBox(height: 50),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.isDesktop(context) ? 3 : (Responsive.isTablet(context) ? 2 : 1),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: Responsive.isDesktop(context) ? 1.1 : 1.3,
              ),
              itemCount: services.length,
              itemBuilder: (context, index) {
                return FadeInUp(
                  delay: Duration(milliseconds: 100 * index),
                  child: ServiceCard(service: services[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}