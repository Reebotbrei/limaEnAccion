import 'package:flutter/material.dart';
import 'package:aplicacion_movil/shared/theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isExpanded;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double borderRadius;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isExpanded = true,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? AppColors.primary;
    final fgColor = foregroundColor ?? AppColors.primary;

    return SizedBox(
      width: isExpanded ? double.infinity : null,
      height: 50,
      child: ElevatedButton.icon(
        icon:
            icon != null ? Icon(icon, color: fgColor) : const SizedBox.shrink(),
        label: Text(
          text,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: fgColor),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 2,
        ),
      ),
    );
  }
}
