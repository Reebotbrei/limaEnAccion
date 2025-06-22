import 'package:flutter/material.dart';
import 'package:aplicacion_movil/objetos/usuario.dart';
import 'package:aplicacion_movil/shared/theme/app_colors.dart';

import 'package:aplicacion_movil/features/auth/home/screens/profile_screen.dart';
import 'package:aplicacion_movil/features/auth/home/screens/screen_inicio.dart';
import 'package:aplicacion_movil/features/auth/home/screens/sos_screen.dart';
import 'package:aplicacion_movil/features/auth/home/screens/barrita_menu.dart';
import '/shared/widgets/no_hero_fab.dart';

class HomePage extends StatefulWidget {
  final Usuario usuario;
  const HomePage({super.key, required this.usuario});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose(); // Liberar recursos
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Menú principal',
          style: TextStyle(color: AppColors.secondary),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'INICIO'),
            Tab(text: 'REPORTAR DELITOS'),
            Tab(text: 'HACER DENUNCIAS'),
            Tab(text: 'NOTICIAS'),
          ],
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black54,
          indicatorColor: Colors.black,
        ),
      ),
      drawer: const Menu(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: TabBarView(
            controller: _tabController,
            children: [
              ScreenInicio(usuario: widget.usuario),
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
              icon: const Icon(Icons.home, color: AppColors.primary),
              onPressed: () {
                _tabController.animateTo(0); // Navega a INICIO
              },
            ),
            IconButton(
              icon: const Icon(Icons.report),
              onPressed: () {
                _tabController.animateTo(1);
              },
            ),
            const SizedBox(width: 40), // espacio para el FAB
            IconButton(
              icon: const Icon(Icons.map),
              onPressed: () {
                // Aquí puedes añadir lógica para el mapa
              },
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ProfileScreen()),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: NoHeroFloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const Text('SOS', style: TextStyle(color: Colors.black)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const SosScreen(mostrar: false),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
