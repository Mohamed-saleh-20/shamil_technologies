import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shamil_technologies/app/constants/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      // Use the main background color with a slight opacity for a modern feel
      color: AppColors.deepSpaceNavy.withOpacity(0.85),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo text using a brand color
          const Text(
            'Shamil Technologies',
            style: TextStyle(
              color: AppColors.mediumBlue, // ✨ Updated Color
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              _navBarItem('الرئيسية', () => context.go('/')),
              const SizedBox(width: 30),
              _navBarItem('خدماتنا', () => context.go('/services')),
              // Add other navigation items here
            ],
          )
        ],
      ),
    );
  }

  Widget _navBarItem(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Text(
        title,
        style: const TextStyle(color: AppColors.white, fontSize: 16),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}