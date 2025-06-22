import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const LoginButton({
    super.key,
    required this.onPressed,
    this.label = 'Iniciar Sesión',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(fontSize: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
