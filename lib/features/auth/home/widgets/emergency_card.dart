import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '/shared/theme/app_colors.dart';

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
