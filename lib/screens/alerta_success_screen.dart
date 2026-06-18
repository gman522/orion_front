import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../widgets/categoria_card.dart';
import '../theme/app_colors.dart';


class AlertaSuccessScreen extends StatelessWidget{
    final String categoria;
    final String subcategoria;
    final String ubicacion;
    final String fecha;
    final String hora;

    const AlertaSuccessScreen({
        super.key,
        required this.categoria,
        required this.subcategoria,
        required this.ubicacion,
        required this.fecha,
        required this.hora,
    });

    Widget _buildRow(String left, String right){
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children:[
                    Text(
                        left,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(right),
                ],
            ),
        );
    }

    @override
    Widget build(BuildContext context){
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                backgroundColor: AppColors.azul,
                foregroundColor: Colors.white,
            ),
            body: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    children:[
                        const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 80,
                        ),

                        const Text(
                            "Alerta enviada exitosamente",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight : FontWeight.bold,
                            ),
                        ),

                        Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Column(
                                children:[
                                    _buildRow("Tipo de emergencia", subcategoria),
                                    _buildRow("Categoria", categoria),
                                    _buildRow("Ubicacion", ubicacion),
                                    _buildRow("Hora", hora),
                                    _buildRow("Fecha", fecha),
                                    _buildRow("Estado", "Pendiente"),
                                ],
                            ),
                        ),

                        const Spacer(),

                        CategoriaCard(
                            titulo: "Seguimiento",
                            color: AppColors.azul,
                            icono: Icons.timeline,
                            verticalPadding: 15,
                            onTap: (){
                                context.go('/seguimiento');
                            },
                        ),

                        const SizedBox(height: 12),

                        CategoriaCard(
                            titulo: "Hacer otra alerta",
                            color: AppColors.verde,
                            icono: Icons.add_alert,
                            verticalPadding: 15,
                            onTap: (){
                                context.go('/home');
                            },
                        ),

                        const SizedBox(height: 12),

                        CategoriaCard(
                            titulo: "Necesitas ayuda mientras esperas? Has click aqui",
                            color: AppColors.azul,
                            icono: Icons.smart_toy,
                            verticalPadding: 15,
                            onTap: (){
                                context.go('/chat');
                            },
                        ),
                    ],
                ),
            ),
        );
    }
}