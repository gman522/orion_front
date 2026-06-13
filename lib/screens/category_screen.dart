import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: AppColors.azul,
        title: const Text('ORION'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton('SALUD', AppColors.verde),
            const SizedBox(height: 20),
            _buildButton('INFRAESTRUCTURA', AppColors.amarillo),
            const SizedBox(height: 20),
            _buildButton('SEGURIDAD', AppColors.rojo),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}