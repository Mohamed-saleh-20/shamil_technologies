import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shamil_technologies/app/constants/app_colors.dart';
import 'package:shamil_technologies/app/utils/responsive.dart';
import 'package:shamil_technologies/core/domain/entities/project.dart';
import 'package:shamil_technologies/features/portfolio/presentation/widgets/project_card.dart';
import 'package:shamil_technologies/features/shared/widgets/main_layout.dart';
import 'dart:math' as math;
import 'dart:ui';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _parallaxController;
  late ScrollController _scrollController;

  String selectedFilter = 'الكل';
  List<String> filterCategories = [
    'الكل',
    'تطبيقات الموبايل',
    'تطوير الويب',
    'حلول المؤسسات'
  ];

  static final List<Project> _allProjects = [
    Project(
      title: 'تطبيق للاستماع عند الطلب',
      description:
          'تواصل مع مستمعين داعمين ومجهولين على مدار الساعة طوال أيام الأسبوع للحصول على دعم عاطفي فوري.',
      imagePath: 'assets/images/portfolio/listening_app.jpg',
      technologies: ['Flutter', 'Firebase', 'WebRTC'],
      category: 'تطبيقات الموبايل',
      tags: ['Health', 'Communication'],
    ),
    Project(
      title: 'منصة لإدارة الفعاليات',
      description:
          'منصة شاملة تربط المواهب وأماكن العرض والمحترفين لتنظيم فعاليات سلس.',
      imagePath: 'assets/images/portfolio/event_app.jpg',
      technologies: ['Flutter', 'Node.js', 'MongoDB'],
      category: 'تطوير الويب',
      tags: ['Events', 'Management'],
    ),
    Project(
      title: 'منصة إندورو ومغامرات الطرق الوعرة',
      description:
          'مُصممة لمستكشفي المسارات الشغوفين لاكتشاف وتتبع ومشاركة مغامراتهم على الطرق الوعرة.',
      imagePath: 'assets/images/portfolio/enduro_app.jpg',
      technologies: ['Flutter', 'Google Maps API', 'Firebase'],
      category: 'تطبيقات الموبايل',
      tags: ['Sports', 'Adventure', 'Maps'],
    ),
    Project(
      title: 'نظام إدارة الموارد البشرية',
      description:
          'حل متكامل لإدارة الموظفين والرواتب والحضور مع تقارير تحليلية متقدمة.',
      imagePath: 'assets/images/portfolio/hr_system.jpg',
      technologies: ['React', 'Node.js', 'PostgreSQL'],
      category: 'حلول المؤسسات',
      tags: ['HR', 'Business', 'Analytics'],
    ),
    Project(
      title: 'تطبيق التجارة الإلكترونية',
      description:
          'منصة تسوق متطورة مع نظام دفع آمن وتجربة مستخدم سلسة.',
      imagePath: 'assets/images/portfolio/ecommerce_app.jpg',
      technologies: ['Flutter', 'Stripe', 'Firebase'],
      category: 'تطبيقات الموبايل',
      tags: ['E-commerce', 'Shopping'],
    ),
    Project(
      title: 'لوحة تحكم التحليلات',
      description:
          'أداة قوية لتحليل البيانات مع رسوم بيانية تفاعلية وتقارير في الوقت الفعلي.',
      imagePath: 'assets/images/portfolio/analytics_dashboard.jpg',
      technologies: ['React', 'D3.js', 'Python'],
      category: 'تطوير الويب',
      tags: ['Data', 'Analytics', 'Dashboard'],
    ),
  ];

  List<Project> get filteredProjects {
    if (selectedFilter == 'الكل') {
      return _allProjects;
    }
    return _allProjects
        .where((project) => project.category == selectedFilter)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _parallaxController = AnimationController(
      duration: const Duration(seconds: 40),
      vsync: this,
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _headerController.forward();
      }
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _parallaxController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Stack(
        children: [
          AnimatedBackground(controller: _parallaxController),
          // FINAL FIX: Replaced CustomScrollView with a more stable SingleChildScrollView and Column layout.
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _buildHeader(),
                _buildFilterSection(),
                _buildProjectsGrid(),
                _buildStatsSection(),
              ],
            ),
          ),
          FloatingActionMenu(scrollController: _scrollController),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.deepSpaceNavy.withOpacity(0.9),
            AppColors.darkSlate.withOpacity(0.7),
            Colors.transparent,
          ],
        ),
      ),
      child: Stack(
        children: [
          _buildGeometricShapes(),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeInDown(
                    duration: const Duration(milliseconds: 800),
                    child: ShaderMask(
                      shaderCallback: (bounds) =>
                          AppColors.primaryGradient.createShader(bounds),
                      child: Text(
                        'معرض أعمالنا',
                        style: TextStyle(
                          fontSize: Responsive.isDesktop(context) ? 64 : 48,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    duration: const Duration(milliseconds: 800),
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Text(
                        'رحلة إبداعية عبر مشاريعنا المتميزة\nحيث تلتقي التكنولوجيا بالفن',
                        style: TextStyle(
                          fontSize: Responsive.isDesktop(context) ? 20 : 16,
                          color: AppColors.lightGray,
                          height: 1.6,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGeometricShapes() {
    return AnimatedBuilder(
      animation: _headerController,
      builder: (context, child) {
        final animationValue =
            Curves.easeInOut.transform(_headerController.value);
        return Stack(
          children: [
            Positioned(
              top: 100,
              right: 50,
              child: Opacity(
                opacity: animationValue,
                child: Transform.translate(
                  offset: Offset(50 * (1 - animationValue), 0),
                  child: Transform.rotate(
                    angle: animationValue * math.pi / 2,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primaryGradientStart.withOpacity(0.3),
                          width: 2,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 200,
              left: 80,
              child: Opacity(
                opacity: animationValue,
                child: Transform.translate(
                  offset: Offset(-50 * (1 - animationValue), 0),
                  child: Transform.rotate(
                    angle: -animationValue * math.pi / 2,
                    child: CustomPaint(
                      size: const Size(60, 60),
                      painter: TrianglePainter(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterSection() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: FadeInUp(
          from: 50,
          delay: const Duration(milliseconds: 200),
          duration: const Duration(milliseconds: 800),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.glassBackground,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: filterCategories.map((category) {
                  final isSelected = category == selectedFilter;
                  return GestureDetector(
                    onTap: () => setState(() => selectedFilter = category),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        gradient:
                            isSelected ? AppColors.primaryGradient : null,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color:
                              isSelected ? Colors.white : AppColors.lightGray,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectsGrid() {
    // FINAL FIX: Using a GridView.builder inside a Column requires these properties
    // to ensure it calculates its size correctly and doesn't conflict with the parent scroll view.
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: Responsive.isDesktop(context)
              ? 3
              : Responsive.isTablet(context)
                  ? 2
                  : 1,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: 0.85,
        ),
        itemCount: filteredProjects.length,
        itemBuilder: (context, index) {
          return FadeInUp(
            delay: Duration(milliseconds: 100 * (index % 6)),
            duration: const Duration(milliseconds: 500),
            child: InnovativeProjectCard(
              project: filteredProjects[index],
              index: index,
              onTap: () => _showProjectDetails(filteredProjects[index]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: AppColors.darkGradient,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Column(
        children: [
          const Text('إحصائيات متميزة',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 32),
        
        ],
      ),
    );
  }

  void _showProjectDetails(Project project) {
    showDialog(
      context: context,
      builder: (context) => ProjectDetailsDialog(project: project),
    );
  }
}

// --- WIDGETS SECTION ---

class AnimatedBackground extends StatelessWidget {
  final AnimationController controller;
  const AnimatedBackground({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: CustomPaint(
        painter: StarfieldPainter(animation: controller),
      ),
    );
  }
}

class StarfieldPainter extends CustomPainter {
  final Animation<double> animation;
  final particles = List.generate(40, (index) => Particle(index));

  StarfieldPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.4);

    for (var p in particles) {
      var p_y = p.y * size.height;
      final y = (p_y + animation.value * size.height * p.speed) % size.height;
      final x = p.x * size.width;
      canvas.drawCircle(Offset(x, y), p.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant StarfieldPainter oldDelegate) => false;
}

class Particle {
  final int seed;
  late final double x;
  late final double y;
  late final double size;
  late final double speed;

  Particle(this.seed) {
    final random = math.Random(seed);
    x = random.nextDouble();
    y = random.nextDouble();
    size = random.nextDouble() * 2 + 1;
    speed = random.nextDouble() * 0.2 + 0.05;
  }
}

class FloatingActionMenu extends StatefulWidget {
  final ScrollController scrollController;
  const FloatingActionMenu({super.key, required this.scrollController});

  @override
  State<FloatingActionMenu> createState() => _FloatingActionMenuState();
}

class _FloatingActionMenuState extends State<FloatingActionMenu> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (!mounted) return;
    final shouldBeVisible = widget.scrollController.position.pixels > 400;
    if (shouldBeVisible != _isVisible) {
      setState(() => _isVisible = shouldBeVisible);
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      right: 30,
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: IgnorePointer(
          ignoring: !_isVisible,
          child: FloatingActionButton(
            onPressed: () => widget.scrollController.animateTo(0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut),
            backgroundColor: AppColors.primaryGradientStart,
            child: const Icon(Icons.arrow_upward, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.accentGradientStart.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ProjectDetailsDialog extends StatelessWidget {
  final Project project;
  const ProjectDetailsDialog({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 550),
        decoration: BoxDecoration(
          gradient: AppColors.darkGradient,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.glassBorder),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(project.title,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Colors.white)),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(project.description,
                        style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.lightGray,
                            height: 1.6)),
                    const SizedBox(height: 24),
                    const Text('التقنيات المستخدمة:',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: project.technologies.map((tech) {
                        return Chip(
                          label: Text(tech),
                          backgroundColor:
                              AppColors.primaryGradientStart.withOpacity(0.2),
                          labelStyle: const TextStyle(
                              color: AppColors.primaryGradientStart,
                              fontWeight: FontWeight.w500),
                          side: BorderSide(
                              color: AppColors.primaryGradientStart
                                  .withOpacity(0.5)),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.launch, color: Colors.white),
                    label: const Text('عرض المشروع',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGradientStart,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
