import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '/shared/theme/app_colors.dart';
import '/shared/widgets/custom_button.dart';

class SosScreen extends StatelessWidget {
  final bool mostrar;

  const SosScreen({super.key, required this.mostrar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Líneas de Emergencia',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColors.background,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const EmergencyCard(
            title: 'Sistema de Atención Móvil de Urgencia SAMU',
            number: '106',
            icon: Icons.local_hospital,
          ),
          const EmergencyCard(
            title: 'Bomberos',
            number: '116',
            icon: Icons.fire_truck,
          ),
          const EmergencyCard(
            title: 'Policía Nacional del Perú (PNP)',
            number: '105',
            icon: Icons.local_police,
          ),
          const EmergencyCard(
            title: 'Defensa Civil',
            number: '115',
            icon: Icons.shield,
          ),
          const EmergencyCard(
            title: 'Elias',
            number: '927 073 539',
            icon: Icons.account_circle,
          ),
          const SizedBox(height: 100),
          if (mostrar)
            CustomButton(
              label: "Página Principal",
              onPressed: () => Navigator.pop(context),
            ),
        ],
      ),
    );
  }
}

class EmergencyCard extends StatelessWidget {
  final String title;
  final String number;
  final IconData icon;

  const EmergencyCard({
    required this.title,
    required this.number,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary, size: 36),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          number,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        onTap: () async {
          final Uri phoneUri = Uri(scheme: 'tel', path: number);
          try {
            final bool launched = await launchUrl(
              phoneUri,
              mode: LaunchMode.externalApplication,
            );
            if (!launched) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No se pudo iniciar la llamada')),
              );
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error al intentar llamar: $e')),
            );
          }
        },
      ),
    );
  }
}
