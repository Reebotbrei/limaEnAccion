import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SosScreen extends StatelessWidget {
  const SosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Líneas de Emergencia'),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: const Color(0xFFFFF3E0),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          EmergencyCard(
            title: 'Sistema de Atención Móvil de Urgencia SAMU',
            number: '106',
            icon: Icons.local_hospital,
          ),
          EmergencyCard(
            title: 'Bomberos',
            number: '116',
            icon: Icons.fire_truck,
          ),
          EmergencyCard(
            title: 'Policía Nacional del Perú',
            number: '105',
            icon: Icons.local_police,
          ),
          EmergencyCard(
            title: 'Defensa Civil',
            number: '115',
            icon: Icons.shield,
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
        leading: Icon(icon, color: Colors.orange, size: 36),
        title: Text(title),
        subtitle: Text(
          number,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        onTap: () async {
          final Uri phoneUri = Uri(scheme: 'tel', path: number);
          if (await canLaunchUrl(phoneUri)) {
            await launchUrl(phoneUri);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('No se pudo iniciar la llamada')),
            );
          }
        },
      ),
    );
  }
}
