import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String nombre;
  String email;
  String distrito;

  Usuario({required this.nombre, required this.email, required this.distrito});

  factory Usuario.fromFirestore(DocumentSnapshot doc) {
    final dataFromJsonFireStore = doc.data() as Map<String, dynamic>;
    return Usuario(
      //XD
      nombre: dataFromJsonFireStore['nombre'],
      distrito: dataFromJsonFireStore['distrito'],
      email: dataFromJsonFireStore['email'],
    );
  }
}
