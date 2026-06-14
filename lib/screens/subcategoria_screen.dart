import 'package:flutter/material.dart';
import '../data/subcategorias_data.dart';
import '../theme/app_colors.dart';

CLASS SubcategoriaScreen extends StatelessWidget {
    final String categoria;

    const SubcategoriaScreen({
        super.key,
        required this.categoria,
    });

    @override
    State<SubcategoriaScreen> createState() => _SubcategoriaScreenState();
}

class _SubcategoriaScreenState extends State<SubcategoriaScreen>{
    String? seleccionada;

    @override
    widget build(BuildContext context){
        final lista = SubcategoriaData.data[widget.categoria] ?? [];

        
    }
}