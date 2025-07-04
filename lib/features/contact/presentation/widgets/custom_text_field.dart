import 'package:flutter/material.dart';
import 'package:shamil_technologies/app/constants/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final int maxLines;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.maxLines = 1,
    required this.controller,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: TextFormField(
        controller: widget.controller,
        maxLines: widget.maxLines,
        style: const TextStyle(color: AppColors.white),
        decoration: InputDecoration(
          // Use a darker, more solid fill color for better contrast
          fillColor: AppColors.darkSlate,
          filled: true,
          // Add padding for more comfortable text entry
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: AppColors.mediumGray),
          prefixIcon: Icon(widget.icon, color: AppColors.mediumGray, size: 20),
          
          // Define a consistent base border
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.glassBorder),
          ),
          
          // Define the border style when the field is not focused
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            // The border brightens on hover for clear feedback
            borderSide: BorderSide(
              color: _isHovered ? AppColors.mediumGray : AppColors.glassBorder,
              width: 1,
            ),
          ),
          
          // The border uses the primary gradient color when focused
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primaryGradientStart, width: 2),
          ),
        ),
      ),
    );
  }
}