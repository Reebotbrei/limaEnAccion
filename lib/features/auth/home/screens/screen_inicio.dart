import 'package:flutter/material.dart';
import 'package:aplicacion_movil/objetos/usuario.dart';
import 'package:aplicacion_movil/shared/theme/app_colors.dart';

class ScreenInicio extends StatefulWidget {
  final Usuario usuario;
  const ScreenInicio({super.key, required this.usuario});

  @override
  State<ScreenInicio> createState() => _ScreenInicioState();
}

class _ScreenInicioState extends State<ScreenInicio> {
  int contador = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25),
          const Text(
            "Bienvenido,",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          Text(
            "  ${widget.usuario.nombre}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 80),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 20,
            children: [
              FloatingActionButton(
                heroTag: 'fab_sleep',
                backgroundColor: AppColors.primary,
                onPressed: () {
                  setState(() {
                    contador++;
                  });
                },
                child: Text(
                  contador.toString(),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const Text(
                "Cada click es un minuto\nmás de sueño para Brei",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
