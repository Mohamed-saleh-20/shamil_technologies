import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shamil_technologies/app/constants/app_colors.dart';
import 'package:shamil_technologies/app/utils/responsive.dart';
import 'package:shamil_technologies/core/domain/entities/project.dart';
import 'package:shamil_technologies/features/portfolio/presentation/widgets/project_card.dart';
import 'package:shamil_technologies/features/shared/widgets/main_layout.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  // Translated mock data
  static const List<Project> _projects = [
    Project(
      title: 'تطبيق للاستماع عند الطلب',
      description: 'تواصل مع مستمعين داعمين ومجهولين على مدار الساعة طوال أيام الأسبوع للحصول على دعم عاطفي فوري.',
      imagePath: 'assets/images/portfolio/listening_app.jpg',
      technologies: ['Flutter', 'Firebase', 'WebRTC'],
    ),
    Project(
      title: 'منصة لإدارة الفعاليات',
      description: 'منصة شاملة تربط المواهب وأماكن العرض والمحترفين لتنظيم فعاليات سلس.',
      imagePath: 'assets/images/portfolio/event_app.jpg',
      technologies: ['Flutter', 'Node.js', 'MongoDB'],
    ),
    Project(
      title: 'منصة إندورو ومغامرات الطرق الوعرة',
      description: 'مُصممة لمستكشفي المسارات الشغوفين لاكتشاف وتتبع ومشاركة مغامراتهم على الطرق الوعرة.',
      imagePath: 'assets/images/portfolio/enduro_app.jpg',
      technologies: ['Flutter', 'Google Maps API', 'Firebase'],
    ),
    // أضف المزيد من المشاريع هنا
  ];

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Column(
        children: [
          _buildHeader(),
          _buildProjectsGrid(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 24.0),
      child: FadeInDown(
        duration: const Duration(milliseconds: 500),
        child: Column(
          children: [
            ShaderMask(
              shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
              child: const Text(
                'أعمالنا',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'نظرة على الحلول المبتكرة التي صممناها لعملائنا.',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.lightGray,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = Responsive.isDesktop(context)
        ? 3
        : Responsive.isTablet(context)
            ? 2
            : 1;
    final cardHeight = screenWidth / crossAxisCount * 1.2;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: 0.75,
        ),
        itemCount: _projects.length,
        itemBuilder: (context, index) {
          return FadeInUp(
            delay: Duration(milliseconds: 100 * index),
            duration: const Duration(milliseconds: 500),
            child: ProjectCard(project: _projects[index]),
          );
        },
      ),
    );
  }
}