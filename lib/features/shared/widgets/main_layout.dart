import 'package:flutter/material.dart';
import 'package:shamil_technologies/app/constants/app_colors.dart';
import 'package:shamil_technologies/features/shared/widgets/custom_app_bar.dart';
import 'package:shamil_technologies/features/shared/widgets/footer.dart';
import 'dart:ui';
import 'package:animate_do/animate_do.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  final bool showAppBar;
  final bool showFooter;

  const MainLayout({
    super.key,
    required this.child,
    this.showAppBar = true,
    this.showFooter = true,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late ScrollController _scrollController;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    // Start animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 50 && !_isScrolled) {
      setState(() {
        _isScrolled = true;
      });
    } else if (_scrollController.offset <= 50 && _isScrolled) {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.deepSpaceNavy,
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            // Background Pattern
            _buildBackgroundPattern(),

            // Main Content
            Column(
              children: [
                // App Bar
                if (widget.showAppBar)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: _isScrolled
                          ? AppColors.deepSpaceNavy.withOpacity(0.95)
                          : Colors.transparent,
                      boxShadow: _isScrolled
                          ? [
                              BoxShadow(
                                color: AppColors.primaryGradientStart
                                    .withOpacity(0.1),
                                blurRadius: 20,
                                spreadRadius: 0,
                              ),
                            ]
                          : [],
                    ),
                    child: const CustomAppBar(),
                  ),

                // Body
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        children: [
                          // Main Content
                          widget.child,

                          // Footer
                          // if (widget.showFooter) _buildFooter(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Scroll to Top Button
            _buildScrollToTopButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundPattern() {
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.darkGradient,
        ),
        child: Stack(
          children: [
            Positioned(
              top: -100,
              left: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primaryGradientStart.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -150,
              right: -150,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.accentGradientEnd.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildFooter() {
  //   return const Footer();
  // }

  Widget _buildScrollToTopButton() {
    return Positioned(
      bottom: 30,
      right: 30,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: _isScrolled
            ? FloatingActionButton(
                onPressed: _scrollToTop,
                backgroundColor: AppColors.primaryGradientStart,
                child: const Icon(Icons.arrow_upward, color: Colors.white),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}