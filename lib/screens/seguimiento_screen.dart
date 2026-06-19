import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum EstadoPaso{
    completado,
    activo,
    pendiente,
}

class SeguimientoScreen extends StatefulWidget{
    const SeguimientoScreen({super.key});

    @override
    State<SeguimientoScreen> createState() => _SeguimientoScreenState();
}

class _SeguimientoScreenState extends State<SeguimientoScreen>{

    final List<Map<String, String>> estados = [
        {
            "titulo": "Recibido",
            "fecha": "12/05/2025 14:32",
            "descripcion": "Tu alerta ha sido recibida por nuestro equipo.",
        },
        {
            "titulo": "En camino",
            "fecha": "12/05/2025 14:35",
            "descripcion": "El equipo de respuesta está en camino al lugar.",
        },
        {
            "titulo": "Resuelto",
            "fecha": "Pendiente",
            "descripcion": "Aún estamos atendiendo la emergencia.",
        },
    ];

    int estadoActual = 0;

    Widget _buildCircle(EstadoPaso estado){
        switch (estado){
            case EstadoPaso.completado:
                return Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                    ),
                    child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 18,
                    ),
                );

            case EstadoPaso.activo:
                return Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                    ),
                    child: const Icon(
                        Icons.sync,
                        color: Colors.white,
                        size: 18,
                    ),
                );

            case EstadoPaso.pendiente:
                return Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.grey,
                            width: 2,
                        ),
                    ),
                );
        }
    }

    Widget _buildLine(){
        return Container(
            width: 2,
            height: 60,
            color: Colors.grey.shade400,
        );
    }

    Widget _estadoItem({
        required Widget icono,
        required String titulo,
        required String fecha,
        required String descripcion,
        bool mostrarLinea = true,
    }){
        return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
                Column(
                    children:[
                        icono,
                        if(mostrarLinea) _buildLine(),
                    ],
                ),

                const SizedBox(width: 15),

                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                            Text(
                                titulo,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                                fecha,
                                style: const TextStyle(
                                    color: Colors.grey,
                                ),
                            ),

                            const SizedBox(height: 5),

                            Text(descripcion),
                        ],
                    ),
                ),
            ],
        );
    }

    @override
    Widget build(BuildContext context){
        return Scaffold(
            backgroundColor: Colors.white,

            appBar: AppBar(
                title: const Text("Seguimiento"),
                backgroundColor: AppColors.azul,
                foregroundColor: Colors.white,
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed:(){
                        context.pop();
                    },
                ),
            ),

            body: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[

                        Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration:BoxDecoration(
                                color: Colors.blueGrey.shade100,
                                borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Text(
                                "codigo de alerta: no generado :v",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                        ),

                        const SizedBox(height: 25),

                        const Text(
                            "Estado del incidente",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                            ),
                        ),

                        const SizedBox(height: 20),

                        Column(
                            children: List.generate(estados.length, (index){
                                final estado = estados[index];

                                final isDone = index < estadoActual;
                                final isActive = index == estadoActual;

                                return _estadoItem(
                                    icono: _buildCircle(
                                        isDone
                                            ? EstadoPaso.completado
                                            : isActive
                                                ? EstadoPaso.activo
                                                : EstadoPaso.pendiente,
                                    ),
                                    titulo: estado["titulo"]!,
                                    fecha: estado["fecha"]!,
                                    descripcion: estado["descripcion"]!,
                                    mostrarLinea: index != estados.length -1,
                                );
                            }),
                        ),
                        
                        const SizedBox(height: 20),

                        ElevatedButton(
                            onPressed:(){
                                setState((){
                                    if(estadoActual < 3){
                                        estadoActual++;
                                    }else{
                                        estadoActual = 0;
                                    }
                                });
                            },
                            child: const Text("avanzar estado (pa probar)"),
                        ),
                    ],
                ),
            ),
        );
    }
}