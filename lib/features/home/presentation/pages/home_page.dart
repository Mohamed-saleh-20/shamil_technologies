import 'package:flutter/material.dart';
import 'package:shamil_technologies/features/home/presentation/widgets/featured_services_section.dart';
import 'package:shamil_technologies/features/home/presentation/widgets/hero_section.dart';
import 'package:shamil_technologies/features/shared/widgets/main_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      child: Column(
        children: [
          HeroSection(),
          // FeaturedServicesSection(), // Assuming this will be built next
          // Add other sections like Testimonials, Blog Preview here
        ],
      ),
    );
  }
}