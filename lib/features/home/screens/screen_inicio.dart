import 'package:aplicacion_movil/objetos/usuario.dart';
import 'package:flutter/material.dart';

class ScreenInicio extends StatefulWidget {
  final Usuario usuario;
  const ScreenInicio({super.key, required this.usuario});

  @override
  State<ScreenInicio> createState() => _ScreenInicio();
}

class _ScreenInicio extends State<ScreenInicio> {
  int contador = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            const Text("Bienvenido,",
                style: TextStyle(fontWeight: FontWeight.w500)),
            Text("  ${widget.usuario.nombre}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Color.fromARGB(255, 88, 67, 3))),
            const SizedBox(height: 80),
            Wrap(
              children: [
                  FloatingActionButton(
                    enableFeedback: true,
                      onPressed: () {
                      setState(() {
                      contador++;
                       }
                      );
                    },
                  child: Text(contador.toString()),
                  ),
                  const SizedBox(width: 25),
                  const Text("Cada click es un minuto\n más de sueño para brei"),
              ]
            )
          ],
        ),
      ),
    );
  }
}
