import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/subcategorias_data.dart';
import '../theme/app_colors.dart';

class SubcategoriaScreen extends StatefulWidget {
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
    Widget build(BuildContext context){
        final lista = SubcategoriaData.data[widget.categoria] ?? [];
            
            return Scaffold(
                backgroundColor: Colors.white,

                appBar: AppBar(
                    backgroundColor: AppColors.azul,
                    foregroundColor: Colors.white,

                    leading: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: (){
                            context.go('/home');
                        },
                    ),
                    title: Text(widget.categoria),
                ),

                body: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[

                            const Text(
                                "Selecciona el tipo de incidente",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),

                            const SizedBox(height: 20),

                            Expanded(
                                child: ListView.builder(
                                    itemCount: lista.length,
                                    itemBuilder: (context, index){
                                        final item = lista[index];
                                        final isSelected = seleccionada == item.nombre;

                                        return GestureDetector(
                                            onTap:(){
                                                setState((){
                                                    seleccionada = item.nombre;
                                                });
                                            },
                                            child: Container(
                                                margin: const EdgeInsets.only(bottom: 12),
                                                padding: const EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                    color: isSelected
                                                        ? AppColors.azul
                                                        : Colors.grey.shade200,
                                                    borderRadius: BorderRadius.circular(15),
                                                ),
                                                child: Row(
                                                    children:[

                                                        Icon(
                                                            item.icono,
                                                            color: isSelected
                                                                ? Colors.white
                                                                : Colors.black,
                                                        ),

                                                        const SizedBox(width: 15),

                                                        Text(
                                                            item.nombre,
                                                            style: TextStyle(
                                                                color: isSelected
                                                                    ? Colors.white
                                                                    : Colors.black,
                                                                fontWeight: FontWeight.bold,
                                                            ),
                                                        ),
                                                    ],
                                                ),
                                            ),
                                        );
                                    },
                                ),
                            ),

                            const SizedBox(height: 10),

                            SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: seleccionada == null ? null : () {},
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.azul,
                                    ),
                                    child: const Text("Enviar alerta"),
                                ),
                            ),
                        ],
                    ),
                ),
            );

    }
}