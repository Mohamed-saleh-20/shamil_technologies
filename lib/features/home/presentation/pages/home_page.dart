import 'package:flutter/material.dart';
import 'package:shamil_technologies/features/home/presentation/widgets/about_us_section.dart';
import 'package:shamil_technologies/features/home/presentation/widgets/blog_preview_section.dart';
import 'package:shamil_technologies/features/home/presentation/widgets/contact_cta_section.dart';
import 'package:shamil_technologies/features/home/presentation/widgets/featured_services_section.dart';
import 'package:shamil_technologies/features/home/presentation/widgets/hero_section.dart';
import 'package:shamil_technologies/features/home/presentation/widgets/testimonials_section.dart';
import 'package:shamil_technologies/features/shared/widgets/main_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      child: Column(
        children: [
          HeroSection(),
          AboutUsSection(),
          TestimonialsSection(),
          BlogPreviewSection(),
          ContactCTASection(),
        ],
      ),
    );
  }
}