import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../objetos/usuario.dart';
import 'firestore_service.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirestoreService _firestore = FirestoreService();

  /// Iniciar sesión con email y contraseña
  static Future<UserCredential> loginWithEmail(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  /// Registrar nuevo usuario con email/contraseña
  static Future<void> signupWithEmail({
    required String email,
    required String password,
    required String nombre,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final newUser = Usuario(
      uid: cred.user!.uid,
      email: email,
      nombre: nombre,
      distrito: 'san juan', // puedes parametrizarlo si lo necesitas
    );

    await _firestore.createUser(cred.user!.uid, newUser);
  }

  /// Iniciar sesión con Google
  static Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _auth.signInWithCredential(credential);

      // Verificar si el usuario ya existe en Firestore
      final uid = userCredential.user!.uid;
      final existingUser = await _firestore.getUser(uid);

      if (existingUser == null) {
        final newUser = Usuario(
          uid: uid,
          email: userCredential.user!.email ?? '',
          nombre: userCredential.user!.displayName ?? '',
          distrito: 'desconocido',
        );

        await _firestore.createUser(uid, newUser);
      }

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  /// Cerrar sesión
  static Future<void> logout() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }
}
