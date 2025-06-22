import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'features/emergency/screens/sos_screen.dart';
import 'shared/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const LimaEnAccionApp());
}

class LimaEnAccionApp extends StatelessWidget {
  const LimaEnAccionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Lima en Acción",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SosScreen(mostrar: true),
    );
  }
}
