class Usuario {
  final String uid;
  final String email;
  final String nombre;
  final String distrito;

  Usuario({
    required this.uid,
    required this.email,
    required this.nombre,
    required this.distrito,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'nombre': nombre,
      'distrito': distrito,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map, String uid) {
    return Usuario(
      uid: uid,
      email: map['email'] ?? '',
      nombre: map['nombre'] ?? '',
      distrito: map['distrito'] ?? '',
    );
  }
}
