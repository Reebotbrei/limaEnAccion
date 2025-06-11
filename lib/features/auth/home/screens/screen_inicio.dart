import 'package:aplicacion_movil/objetos/usuario.dart';
import 'package:flutter/material.dart';

class ScreenInicio extends StatefulWidget {
  final Usuario usuario;
  const ScreenInicio({super.key, required this.usuario});

  @override
  State<ScreenInicio> createState() => _ScreenInicio();
}

class _ScreenInicio extends State<ScreenInicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        Text("Bienvenido ${widget.usuario.nombre}"),
      ])),
    );
  }
}
