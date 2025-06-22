class Usuario {
  final String nombre;
  final String email;
  final String distrito;

  Usuario({
    required this.nombre,
    required this.email,
    required this.distrito,
  });

  // Convierte un mapa (Firestore) a una instancia de UserModel
  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      nombre: map['nombre'] ?? '',
      email: map['email'] ?? '',
      distrito: map['distrito'] ?? '',
    );
  }

  // Convierte una instancia de UserModel a un mapa (para Firestore)
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'email': email,
      'distrito': distrito,
    };
  }
}
