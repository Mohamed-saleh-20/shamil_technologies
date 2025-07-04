import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shamil_technologies/app/constants/app_colors.dart';
import 'package:shamil_technologies/app/utils/responsive.dart';
import 'dart:ui';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _CustomAppBarState extends State<CustomAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _logoAnimation;
  String _hoveredItem = '';
  bool _isMenuOpen = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _logoAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.deepSpaceNavy.withOpacity(0.9),
            border: const Border(
              bottom: BorderSide(
                color: AppColors.glassBorder,
                width: 1,
              ),
            ),
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo
                _buildLogo(),

                // Navigation
                if (isDesktop || isTablet)
                  _buildDesktopNavigation()
                else
                  _buildMobileMenuButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return AnimatedBuilder(
      animation: _logoAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _logoAnimation.value,
          child: GestureDetector(
            onTap: () => context.go('/'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo Icon
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryGradientStart.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.code,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Logo Text
                  ShaderMask(
                    shaderCallback: (bounds) =>
                        AppColors.primaryGradient.createShader(bounds),
                    child: const Text(
                      'شامل تكنولوجيز',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopNavigation() {
    return Row(
      children: [
        _buildNavItem('الرئيسية', '/', Icons.home_rounded),
        const SizedBox(width: 8),
        _buildNavItem('خدماتنا', '/services', Icons.build_rounded),
        const SizedBox(width: 8),
        _buildNavItem('أعمالنا', '/portfolio', Icons.work_rounded),
        const SizedBox(width: 8),
        _buildNavItem('المدونة', '/blog', Icons.article_rounded),
        const SizedBox(width: 8),
        _buildNavItem('تواصل معنا', '/contact', Icons.contact_page_rounded),
        const SizedBox(width: 24),
        _buildCTAButton(),
      ],
    );
  }

  Widget _buildNavItem(String title, String route, IconData icon) {
    final isHovered = _hoveredItem == title;
    final isActive = GoRouter.of(context).routeInformationProvider.value.location == route;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredItem = title),
      onExit: (_) => setState(() => _hoveredItem = ''),
      child: GestureDetector(
        onTap: () => context.go(route),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primaryGradientStart.withOpacity(0.1)
                : (isHovered ? AppColors.glassBackground : Colors.transparent),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isActive
                  ? AppColors.primaryGradientStart.withOpacity(0.3)
                  : (isHovered ? AppColors.glassBorder : Colors.transparent),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: isActive
                    ? AppColors.primaryGradientStart
                    : (isHovered ? AppColors.white : AppColors.lightGray),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  color: isActive
                      ? AppColors.primaryGradientStart
                      : (isHovered ? AppColors.white : AppColors.lightGray),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCTAButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryGradientStart.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: () => context.go('/contact'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        icon: const Icon(
          Icons.rocket_launch_rounded,
          size: 16,
          color: Colors.white,
        ),
        label: const Text(
          'ابدأ مشروعك',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildMobileMenuButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isMenuOpen = !_isMenuOpen;
        });
        _showMobileMenu();
      },
      icon: AnimatedRotation(
        turns: _isMenuOpen ? 0.5 : 0,
        duration: const Duration(milliseconds: 300),
        child: Icon(
          _isMenuOpen ? Icons.close : Icons.menu,
          color: AppColors.white,
          size: 24,
        ),
      ),
    );
  }

  void _showMobileMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppColors.darkSlate,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.mediumGray,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            _buildMobileNavItem('الرئيسية', '/', Icons.home_rounded),
            _buildMobileNavItem('خدماتنا', '/services', Icons.build_rounded),
            _buildMobileNavItem('أعمالنا', '/portfolio', Icons.work_rounded),
            _buildMobileNavItem('المدونة', '/blog', Icons.article_rounded),
            _buildMobileNavItem(
                'تواصل معنا', '/contact', Icons.contact_page_rounded),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: _buildCTAButton(),
              ),
            ),
          ],
        ),
      ),
    ).then((_) {
      setState(() {
        _isMenuOpen = false;
      });
    });
  }

  Widget _buildMobileNavItem(String title, String route, IconData icon) {
    final isActive =
        GoRouter.of(context).routeInformationProvider.value.location == route;

    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? AppColors.primaryGradientStart : AppColors.lightGray,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isActive ? AppColors.primaryGradientStart : AppColors.white,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
      onTap: () {
        context.go(route);
        Navigator.pop(context);
      },
    );
  }
}