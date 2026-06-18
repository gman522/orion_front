import 'package:flutter/material.dart';

class CategoriaCard extends StatelessWidget {
  final String titulo;
  final Color color;
  final IconData icono;
  final VoidCallback? onTap;
  final double verticalPadding;

  const CategoriaCard({
    super.key,
    required this.titulo,
    required this.color,
    required this.icono,
    this.onTap,
    this.verticalPadding = 30,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              icono,
              color: Colors.white,
            ),

            const SizedBox(width: 15),
            Expanded(
              child: Text(
                titulo,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}