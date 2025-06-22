import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:aplicacion_movil/services/auth_service.dart';
import 'package:aplicacion_movil/services/firestore_service.dart';
import 'package:aplicacion_movil/shared/widgets/custom_text_field.dart';
import 'package:aplicacion_movil/shared/widgets/primary_button.dart';
import 'package:aplicacion_movil/shared/widgets/google_sign_in.dart';
import 'package:aplicacion_movil/shared/theme/app_colors.dart';
import 'package:aplicacion_movil/shared/utils/validators.dart';

import 'reset_password_page.dart';
import 'sign_up_page.dart';
import 'package:aplicacion_movil/features/auth/home/screens/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();
  
  
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final cred = await AuthService.loginWithEmail(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );

        final usuario = await FirestoreService.getUsuario(cred.user!.uid);



        if (!mounted) return;

        if (usuario != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomePage(usuario: usuario)),
          );
        } else {
          _showError('No se encontraron los datos del usuario');
        }
      } on FirebaseAuthException catch (_) {
        _showError('Correo o contraseña inválidos');
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _onGoogleSignIn() async {
    try {
      final cred = await AuthService.signInWithGoogle();

      if (cred != null && cred.user != null) {
        final usuario = await FirestoreService.getUsuario(cred.user!.uid);

        if (!mounted) return;

        if (usuario != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomePage(usuario: usuario)),
          );
        } else {
          _showError('Usuario no registrado en Firestore');
        }
      }
    } catch (e) {
      _showError('Error al iniciar sesión con Google');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Icon(Icons.shield_outlined, size: 80, color: AppColors.primary),
              const SizedBox(height: 16),
              Text(
                'LIMA EN ACCIÓN',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Inicia sesión para continuar',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 32),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _emailController,
                      labelText: 'Correo electrónico',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: FormValidators.validateEmail,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(_isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: FormValidators.validatePassword,
                    ),
                    const SizedBox(height: 24),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : PrimaryButton(
                            text: 'Iniciar sesión',
                            onPressed: _onLogin,
                          ),
                    const SizedBox(height: 16),
                    GoogleSignInButton(
                      onPressed: _onGoogleSignIn,
                    ),
                    const SizedBox(height: 30),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ResetPasswordPage(),
                          ),
                        );
                      },
                      child: Text(
                        '¿Olvidaste tu contraseña?',
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        text: '¿No tienes una cuenta? ',
                        style: const TextStyle(color: Colors.black87),
                        children: [
                          TextSpan(
                            text: 'Regístrate',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const SignupPage(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
