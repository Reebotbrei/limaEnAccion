import 'package:flutter/material.dart';
import '../features/auth/screens/login_page.dart';
import '../features/auth/screens/sign_up_page.dart';
import '../features/auth/screens/reset_password_page.dart';
import '../features/auth/home/screens/profile_screen.dart';
import '../features/auth/home/screens/sos_screen.dart';
import '../features/auth/home/screens/home_page.dart';
import '../objetos/usuario.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String resetPassword = '/reset-password';
  static const String profile = '/profile';
  static const String home = '/home';
  static const String sos = '/sos';

  static Map<String, WidgetBuilder> getRoutes(Usuario? user) {
    return {
      login: (context) => const LoginPage(),
      signup: (context) => const SignupPage(),
      resetPassword: (context) => const ResetPasswordPage(),
      profile: (context) => const ProfileScreen(),
      sos: (context) => const SosScreen(mostrar: false),
      home: (context) => HomePage(usuario: user!),
    };
  }
}
