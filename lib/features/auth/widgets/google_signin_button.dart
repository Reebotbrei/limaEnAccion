 import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleSignInButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        icon: Image.network(
          'https://developers.google.com/identity/images/g-logo.png',
          height: 24,
        ),
        label: Text('Registrarse con Google', style: TextStyle(color: Colors.black)),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.grey.shade300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 14.0),
          backgroundColor: Colors.white,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
