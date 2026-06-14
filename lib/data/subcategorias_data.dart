import 'package:flutter/material.dart';

class Subcategoria{
    final String nombre;
    final IconData icono;

    const Subcategoria({
        required this.nombre,
        required this.icono,
    });
}

class SubcategoriaData{
    static const Map<String, List<Subcategoria>> data={
        "SALUD":[
            Subcategoria(nombre: "Desmayo", icono: Icons.personal_injury),
            Subcategoria(nombre: "Accidente", icono: Icons.health_and_safety),
        ],
        "INFRAESTRUCTURA":[
            Subcategoria(nombre: "Caida de estructura", icono: Icons.build),
            Subcategoria(nombre: "Falla electrica", icono: Icons.electrical_services),
        ],
        "SEGURIDAD":[
            Subcategoria(nombre: "Robo", icono: Icons.security),
            Subcategoria(nombre: "Emergencia violenta", icono: Icons.warning),
        ],
    };
}