import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shamil_technologies/app/constants/app_colors.dart';
import 'package:shamil_technologies/core/domain/entities/service.dart';

class ServiceCard extends StatefulWidget {
  final Service service;
  final int index;
  
  const ServiceCard({
    super.key,
    required this.service,
    this.index = 0,
  });

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.02,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -10),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    
    if (isHovered) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: _slideAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Transform.rotate(
              angle: _rotationAnimation.value,
              child: MouseRegion(
                onEnter: (_) => _onHover(true),
                onExit: (_) => _onHover(false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    gradient: _isHovered 
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.primaryGradientStart.withOpacity(0.1),
                              AppColors.primaryGradientEnd.withOpacity(0.05),
                            ],
                          )
                        : null,
                    color: _isHovered ? null : AppColors.glassBackground,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: _isHovered 
                          ? AppColors.primaryGradientStart.withOpacity(0.5)
                          : AppColors.glassBorder,
                      width: _isHovered ? 2 : 1,
                    ),
                    boxShadow: _isHovered
                        ? [
                            BoxShadow(
                              color: AppColors.primaryGradientStart.withOpacity(0.2),
                              blurRadius: 30,
                              spreadRadius: 0,
                              offset: const Offset(0, 15),
                            ),
                          ]
                        : [],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon Container
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: _isHovered 
                              ? AppColors.primaryGradient
                              : LinearGradient(
                                  colors: [
                                    AppColors.lightSlate,
                                    AppColors.mediumSlate,
                                  ],
                                ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: _isHovered
                              ? [
                                  BoxShadow(
                                    color: AppColors.primaryGradientStart.withOpacity(0.3),
                                    blurRadius: 20,
                                    spreadRadius: 0,
                                  ),
                                ]
                              : [],
                        ),
                        child: AnimatedRotation(
                          turns: _isHovered ? 0.1 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          child: SvgPicture.asset(
                            widget.service.iconAsset,
                            height: 32,
                            width: 32,
                            colorFilter: ColorFilter.mode(
                              _isHovered ? Colors.white : AppColors.vibrantTeal,
                              BlendMode.srcIn,
                            ),
                            placeholderBuilder: (context) => Icon(
                              Icons.settings,
                              size: 32,
                              color: _isHovered ? Colors.white : AppColors.vibrantTeal,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Title
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                          color: _isHovered ? AppColors.white : AppColors.lightGray,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                        child: Text(widget.service.title),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Description
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                          color: _isHovered ? AppColors.lightGray : AppColors.mediumGray,
                          fontSize: 16,
                          height: 1.6,
                        ),
                        child: Text(widget.service.description),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Learn More Button
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: _isHovered ? 1.0 : 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: AppColors.accentGradient,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate to service details
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'تعرف أكثر',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_back,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}