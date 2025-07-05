import 'package:flutter/material.dart';
import 'package:shamil_technologies/app/constants/app_colors.dart';
import 'dart:ui';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final int maxLines;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool isPassword;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.maxLines = 1,
    required this.controller,
    this.validator,
    this.isPassword = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _borderAnimation;
  bool _isHovered = false;
  bool _isFocused = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _borderAnimation = Tween<double>(begin: 1.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() => _isFocused = hasFocus);
          if (hasFocus) {
            _animationController.forward();
          } else {
            _animationController.reverse();
          }
        },
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: _isFocused
                    ? [
                        BoxShadow(
                          color: AppColors.primaryGradientStart.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ]
                    : [],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: TextFormField(
                    controller: widget.controller,
                    maxLines: widget.maxLines,
                    obscureText: widget.isPassword && _obscureText,
                    style: const TextStyle(color: AppColors.white),
                    validator: widget.validator,
                    decoration: InputDecoration(
                      fillColor: AppColors.glassBackground,
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 20),
                      hintText: widget.hintText,
                      hintStyle: const TextStyle(color: AppColors.mediumGray),
                      prefixIcon: Icon(
                        widget.icon,
                        color: _isFocused
                            ? AppColors.primaryGradientStart
                            : AppColors.mediumGray,
                        size: 20,
                      ),
                      suffixIcon: widget.isPassword
                          ? IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.mediumGray,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: _isHovered
                              ? AppColors.mediumGray
                              : AppColors.glassBorder,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: AppColors.primaryGradientStart,
                          width: _borderAnimation.value,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.dangerRed,
                          width: 2,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.dangerRed,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}