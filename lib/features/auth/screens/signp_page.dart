import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/login_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignpPage extends StatefulWidget {
  const SignpPage({super.key});

  @override
  State<SignpPage> createState() => _SignpPageState();
}

class _SignpPageState extends State<SignpPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSignup() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final nombre = _nameController.text.trim();

      try {
        // Crear usuario en Firebase
        UserCredential usuario = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await FirebaseFirestore.instance
            .collection('Usuario')
            .doc(usuario.user!.uid) //este es el identificador de cada usuario en firestore :v
            .set({
              'correo': email,
              'distrito': 'san juan',
              'nombre' : nombre
              });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cuenta creada con éxito. Inicia sesión.'),
          ),
        );

        Navigator.pop(context); // Volver a login
      } on FirebaseAuthException catch (e) {
        String mensaje;
        if (e.code == 'email-already-in-use') {
          mensaje = 'Ese correo ya está registrado.';
        } else if (e.code == 'invalid-email') {
          mensaje = 'El correo no es válido.';
        } else if (e.code == 'weak-password') {
          mensaje = 'La contraseña es demasiado débil.';
        } else {
          mensaje = 'Error: ${e.message}';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(mensaje)),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error inesperado: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Cuenta'),
        backgroundColor: Colors.orange[700],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Icon(Icons.person_add_alt_1_outlined,
                  size: 80, color: Colors.orange[700]),
              const SizedBox(height: 16),
              Text(
                'Regístrate para continuar',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[800]),
              ),
              const SizedBox(height: 32),

              // Campo Nombre
              CustomTextField(
                controller: _nameController,
                labelText: 'Nombre completo',
                prefixIcon: Icons.person_outline,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo Email
              CustomTextField(
                controller: _emailController,
                labelText: 'Correo electrónico',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu correo';
                  }
                  final gmailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
                  if (!gmailRegex.hasMatch(value)) {
                    return 'Ingresa un correo válido de Gmail';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo Contraseña
              CustomTextField(
                controller: _passwordController,
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una contraseña';
                  }
                  if (value.length < 6) {
                    return 'La contraseña debe tener al menos 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Confirmar Contraseña
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

              // Botón crear cuenta
              LoginButton(
                onPressed: _onSignup,
                label: 'Crear Cuenta',
              ),
              const SizedBox(height: 16),

              // Google (sin funcionalidad aún)
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
                onPressed: () {
                  // Google Sign-In opcional
                },
              ),
              const SizedBox(height: 24),

              // Enlace para volver al login
              RichText(
                text: TextSpan(
                  text: '¿Ya tienes una cuenta? ',
                  style: const TextStyle(color: Colors.black87, fontSize: 14),
                  children: [
                    TextSpan(
                      text: 'Inicia sesión',
                      style: TextStyle(
                        color: Colors.orange[700],
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
