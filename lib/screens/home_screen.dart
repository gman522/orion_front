import '../repositories/categoria_repository.dart';
import 'package:go_router/go_router.dart';
import '../widgets/categoria_card.dart';
import 'package:flutter/material.dart';
import '../constants/app_strings.dart';
import '../services/api_service.dart';
import '../theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  
  final CategoriaRepository repo = CategoriaRepository(ApiService());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: AppColors.azul,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(AppStrings.appName),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [

            const DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.azul,
              ),

              child: Text(
                AppStrings.menuTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(AppStrings.home),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.history),
              title: const Text(AppStrings.history),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text(AppStrings.settings),
              onTap: () {
                Navigator.pop(context);
              },
            ),

          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: repo.obtenerCategorias(),
          builder: (context, snapshot){

            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError){
              return const Center(
                child: Text("Error cargando categorias"),
              );
            }

            final categorias = snapshot.data ?? [];

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: categorias.map((cat){

                Color color;
                IconData icono;

                switch(cat.nombre.toUpperCase()){
                  case "SALUD":
                    color = AppColors.verde;
                    icono = Icons.favorite;
                    break;

                  case "INFRAESTRUCTURA":
                    color = AppColors.amarillo;
                    icono = Icons.security;

                  default:
                    color = AppColors.rojo;
                    icono = Icons.security;
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CategoriaCard(
                    titulo: cat.nombre,
                    color: color,
                    icono: icono,
                    onTap: (){
                      context.go('/subcategoria/${cat.nombre}');
                    },
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}