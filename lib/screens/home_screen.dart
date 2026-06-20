import '../repositories/categoria_repository.dart';
import 'package:go_router/go_router.dart';
import '../widgets/categoria_card.dart';
import '../widgets/vista_cargando.dart';
import 'package:flutter/material.dart';
import '../constants/app_strings.dart';
import '../services/api_service.dart';
import '../widgets/vista_error.dart';
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
              return const VistaCargando();
            }

            if (snapshot.hasError){
              return VistaError(
                mensaje: "Error cargando categorias",
                onRetry: (){
                  (context as Element).markNeedsBuild();
                },
              );
            }

            final categorias = snapshot.data ?? [];

            return ListView.builder(
              itemCount: categorias.length,
              itemBuilder: (context, index){

                final cat = categorias[index];

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
                    break;
                  
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
              },
            );
          },
        ),
      ),
    );
  }
}