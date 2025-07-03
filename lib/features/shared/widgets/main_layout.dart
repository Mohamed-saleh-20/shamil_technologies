import 'package:flutter/material.dart';
import 'package:shamil_technologies/app/constants/app_colors.dart';
import 'package:shamil_technologies/features/shared/widgets/custom_app_bar.dart';
import 'package:shamil_technologies/features/shared/widgets/footer.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Set RTL for the entire app
      child: Scaffold(
        // Ensure the background color is consistent across all layouts
        backgroundColor: AppColors.deepSpaceNavy, // ✨ Updated Color
        body: Column(
          children: [
            const CustomAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    child,
                    // const Footer(), // Assuming you have a footer
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}