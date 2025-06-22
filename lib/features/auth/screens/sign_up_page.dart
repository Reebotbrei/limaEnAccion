import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../shared/widgets/custom_text_field.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/theme/app_colors.dart';
import '/shared/utils/validators.dart';
import '../../../services/auth_service.dart';
import '../../../services/firestore_service.dart';
import '../../../shared/utils/validators.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _onSignup() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        await AuthService.signupWithEmail(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          nombre: _nameController.text.trim(),
        );

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cuenta creada con éxito. Inicia sesión.')),
        );
        Navigator.pop(context); // Regresa al login
      } on FirebaseAuthException catch (e) {
        String mensaje;
        switch (e.code) {
          case 'email-already-in-use':
            mensaje = 'Ese correo ya está registrado.';
            break;
          case 'invalid-email':
            mensaje = 'El correo no es válido.';
            break;
          case 'weak-password':
            mensaje = 'La contraseña es demasiado débil.';
            break;
          default:
            mensaje = 'Error: ${e.message}';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(mensaje)),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error inesperado: $e')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _onGoogleSignup() async {
    try {
      final cred = await AuthService.signInWithGoogle();

      if (cred != null && cred.user != null) {
        final usuario = await FirestoreService().getUser(cred.user!.uid);

        if (!mounted) return;

        if (usuario != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => HomePage(usuario: usuario),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No se pudo recuperar la información del usuario.'),
            ),
          );
        }
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión con Google: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Crear Cuenta'),
        backgroundColor: AppColors.primary,
        elevation: 0,
        foregroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Icon(Icons.person_add_alt_1_outlined,
                  size: 80, color: AppColors.primary),
              const SizedBox(height: 16),
              Text(
                'Regístrate para continuar',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 32),
              CustomTextField(
                controller: _nameController,
                labelText: 'Nombre completo',
                prefixIcon: Icons.person_outline,
                keyboardType: TextInputType.name,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingresa tu nombre' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _emailController,
                labelText: 'Correo electrónico',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: FormValidators.validateEmail,

              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _passwordController,
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline,
                obscureText: true,
               validator: FormValidators.validatePassword,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _confirmPasswordController,
                labelText: 'Confirmar contraseña',
                prefixIcon: Icons.lock_outline,
                obscureText: true,
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              _isLoading
                  ? const CircularProgressIndicator()
                  : PrimaryButton(
                      text: 'Crear Cuenta',
                      onPressed: _onSignup,
                    ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.login, color: Colors.red),
                label: const Text('Registrarse con Google'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black87,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  side: const BorderSide(color: Colors.grey),
                ),
                onPressed: _onGoogleSignup,
              ),
              const SizedBox(height: 24),
              RichText(
                text: TextSpan(
                  text: '¿Ya tienes una cuenta? ',
                  style: const TextStyle(color: Colors.black87, fontSize: 14),
                  children: [
                    TextSpan(
                      text: 'Inicia sesión',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
                        },
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
