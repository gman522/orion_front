import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/categoria_card.dart';
import 'subcategoria_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: AppColors.azul,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('ORION'),
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
                "MENU",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("inicio"),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.history),
              title: const Text("historial (desarrollo)"),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("configuracion (desarrollo)"),
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
          children: [
            CategoriaCard(
              titulo: "SALUD",
              color: AppColors.verde,
              icono: Icons.favorite,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                      const SubcategoriaScreen(categoria: "SALUD"),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            CategoriaCard(
              titulo: "INFRAESTRUCTURA",
              color: AppColors.amarillo,
              icono: Icons.build,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                      const SubcategoriaScreen(categoria: "INFRAESTRUCTURA"),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            CategoriaCard(
              titulo: "SEGURIDAD",
              color: AppColors.rojo,
              icono: Icons.security,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                      const SubcategoriaScreen(categoria: "SEGURIDAD"),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}