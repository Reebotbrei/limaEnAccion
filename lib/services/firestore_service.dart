import 'package:cloud_firestore/cloud_firestore.dart';
import '../objetos/usuario.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(String uid, Usuario user) async {
    await _db.collection('Usuario').doc(uid).set(user.toMap());
  }

  Future<void> updateUser(String uid, Usuario user) async {
    await _db.collection('Usuario').doc(uid).update(user.toMap());
  }

  Future<void> deleteUser(String uid) async {
    await _db.collection('Usuario').doc(uid).delete();
  }

  /// ✅ Nuevo método estático para usar en LoginPage
  static Future<Usuario?> getUsuario(String uid) async {
    final doc = await FirebaseFirestore.instance.collection('Usuario').doc(uid).get();
    if (doc.exists && doc.data() != null) {
      return Usuario.fromMap(doc.data()!, doc.id);
    }
    return null;
  }
}
