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
      minimum: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Text(
            "Bienvenido,",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.usuario.nombre,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 60),
          Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      contador++;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(
                    'Contador: $contador',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Cada click es un minuto\nmás de sueño para Brei",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
