import 'package:aplicacion_movil/objetos/usuario.dart';

class ListaUsuarios {
  List<Usuario>? _lista;

  void addUser(Usuario value) {
    if (_lista == null) 

    _lista!.add(value);
  }
}
