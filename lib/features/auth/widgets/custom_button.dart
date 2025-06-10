import 'package:aplicacion_movil/features/auth/screens/login_page.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? label;

  const CustomButton({super.key, this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        
        style: ElevatedButton.styleFrom(
          
          backgroundColor: Colors.orange[700],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(fontSize: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: (){
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
        child: Text(label.toString()),
      ),
    );
  }
}
