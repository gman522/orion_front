import 'package:go_router/go_router.dart';
import '../widgets/categoria_card.dart';
import 'package:flutter/material.dart';
import '../constants/app_strings.dart';
import '../theme/app_colors.dart';

class HomeScreen extends StatelessWidget {

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            CategoriaCard(
              titulo: AppStrings.health,
              color: AppColors.verde,
              icono: Icons.favorite,
              onTap:(){
                context.go('/subcategoria/SALUD');
              },
            ),

            const SizedBox(height: 20),

            CategoriaCard(
              titulo: AppStrings.infraestructure,
              color: AppColors.amarillo,
              icono: Icons.build,
              onTap:(){
                context.go('/subcategoria/INFRAESTRUCTURA');
              },
            ),

            const SizedBox(height: 20),

            CategoriaCard(
              titulo: AppStrings.security,
              color: AppColors.rojo,
              icono: Icons.build,
              onTap:(){
                context.go('/subcategoria/SEGURIDAD');
              },
            ),
          ],
        ),
      ),
    );
  }
}