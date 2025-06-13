import 'package:aplicacion_movil/features/auth/home/screens/screen_inicio.dart';
import 'package:aplicacion_movil/objetos/usuario.dart';
import 'package:flutter/material.dart';
import 'sos_screen.dart';
import '../../screens/profile_screen.dart';

class HomePage extends StatefulWidget {
  final Usuario usuario;
  const HomePage({super.key, required this.usuario});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this); // 3 pestañas
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(

        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: (){
          },
        ),
        title: const Text('Menú principal',
            style: TextStyle(color: Color.fromARGB(255, 255, 243, 206))),
        
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'INICIO'),
            Tab(text: 'REPORTAR DELITOS'),
            Tab(text: 'HACER DENUNCIAS'),
            Tab(text: 'NOTICIAS'),
          ],
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black,
          indicatorColor: Colors.black,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: TabBarView(
            controller: _tabController,
            children: [
              Center(child: ScreenInicio(usuario: widget.usuario)),
              const Center(child: Text('Contenido de Reportar Delitos')),
              const Center(child: Text('Contenido de Hacer Denuncias')),
              const Center(child: Text('Noticias')),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                icon: const Icon(Icons.home, color: Colors.orange),
                onPressed: () {}),
            IconButton(icon: const Icon(Icons.report), onPressed: () {}),
            const SizedBox(width: 40), // espacio para el botón flotante
            IconButton(icon: const Icon(Icons.map), onPressed: () {}),
            IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()),
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Text('SOS', style: TextStyle(color: Colors.black)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SosScreen(mostrar: false)),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
