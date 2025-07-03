// lib/features/services/presentation/widgets/service_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shamil_technologies/app/constants/app_colors.dart';
import 'package:shamil_technologies/core/domain/entities/service.dart';

class ServiceCard extends StatefulWidget {
  final Service service;
  const ServiceCard({super.key, required this.service});

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.primaryDarkBlue.withOpacity(0.6) : AppColors.primaryDarkBlue.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered ? AppColors.vibrantTeal : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              widget.service.iconAsset,
              height: 50,
              width: 50,
              colorFilter: const ColorFilter.mode(AppColors.vibrantTeal, BlendMode.srcIn),
              placeholderBuilder: (context) => const Icon(Icons.settings, size: 50, color: AppColors.vibrantTeal),
            ),
            const SizedBox(height: 20),
            Text(
              widget.service.title,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.service.description,
              style: const TextStyle(
                color: AppColors.lightIceBlue,
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}