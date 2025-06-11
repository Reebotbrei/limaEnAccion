import 'package:flutter/material.dart';

class ScreenInicio extends StatefulWidget {
  
  const ScreenInicio({super.key});

  @override
  State<ScreenInicio> createState() => _ScreenInicio();
}

class _ScreenInicio extends State<ScreenInicio> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Column(children: [
        Text("Bienvenido " ),
      ])),
    );
  }
}
