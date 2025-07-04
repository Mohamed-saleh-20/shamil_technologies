import 'package:flutter/material.dart';
import 'package:shamil_technologies/app/constants/app_colors.dart';
import 'package:shamil_technologies/core/domain/entities/project.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  final double parallaxOffset;

  const ProjectCard({
    super.key,
    required this.project,
    this.parallaxOffset = 0,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.darkSlate,
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primaryGradientStart.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project Image
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Transform.scale(
                    scale: _isHovered ? 1.05 : 1.0,
                    child: Image.asset(
                      widget.project.imagePath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
              // Project Details
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.project.title,
                        textAlign: TextAlign.start, // Ensures correct alignment for RTL
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.project.description,
                        textAlign: TextAlign.start, // Ensures correct alignment for RTL
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.lightGray,
                          height: 1.5,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              // View Project Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.bottomLeft, // Align icon to the left for RTL
                  child: Icon(
                    Icons.arrow_back_rounded, // Use back arrow for RTL context
                    color: _isHovered ? AppColors.primaryGradientStart : AppColors.mediumGray,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}