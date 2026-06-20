import '../repositories/categoria_repository.dart';
import 'package:image_picker/image_picker.dart';
import '../models/incidente_request.dart';
import 'package:go_router/go_router.dart';
import '../data/subcategorias_data.dart';
import 'package:flutter/material.dart';
import '../constants/app_strings.dart';
import '../services/api_service.dart';
import '../theme/app_colors.dart';
import 'dart:io';



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
    final TextEditingController comentarioController = TextEditingController();
    final repo = CategoriaRepository(ApiService());
    final ImagePicker picker = ImagePicker();
    String? seleccionada;
    String? imagenPath;
    File? imagenSeleccionada;

    @override
    void dispose(){
        comentarioController.dispose();
        super.dispose();
    }

    Future<void> tomarFoto() async{
        final pickedFile = await picker.pickImage(
            source: ImageSource.camera,
        );

        if (pickedFile != null){
            setState((){
                imagenSeleccionada = File(pickedFile.path);
            });
        }
    }

    Future<void> seleccionarDeGaleria() async{
        final pickedFile = await picker.pickImage(
            source: ImageSource.gallery,
        );

        if(pickedFile != null){
            setState((){
                imagenSeleccionada = File(pickedFile.path);
            });
        }
    }

    Color getColorCategoria(String categoria){
        switch(categoria){
            case "SALUD":
                return AppColors.verde;
            
            case "INFRAESTRUCTURA":
                return AppColors.amarillo;

            case "SEGURIDAD":
                return AppColors.azul;
            
            default:
                return AppColors.azul;
        }
    }

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
                        
                        Container(
                            width:double.infinity,
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                                color: getColorCategoria(widget.categoria),
                                borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                                widget.categoria,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                        ),

                        const Text(
                            AppStrings.selectIncident,
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

                        TextField(
                            controller: comentarioController,
                            maxLines: 3,
                            decoration: InputDecoration(
                                labelText: "Comentarios (opcional)",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                ),
                            ),
                        ),

                        const SizedBox(height: 10),

                        ElevatedButton.icon(
                            onPressed: tomarFoto,
                            icon:const Icon(Icons.camera_alt),
                            label: const Text("Tomar foto (opcional)"),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                            child: ElevatedButton.icon(
                                onPressed: seleccionarDeGaleria,
                                icon: const Icon(Icons.photo),
                                label: const Text("Galeria")
                            ),
                        ),

                        if(imagenSeleccionada != null)
                            Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Image.file(
                                    imagenSeleccionada!,
                                    height: 150,
                                ),
                            ),

                        const SizedBox(height: 10),

                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: seleccionada == null 
                                    ? null 
                                    : () async {
                                        
                                        try{
                                            String? imageUrl;

                                            final request = IncidenteRequest(
                                                categoria:widget.categoria,
                                                subcategoria: seleccionada!,
                                                comentario: comentarioController.text,
                                                imagen: imageUrl,
                                            );

                                            await repo.crearIncidente(request);

                                            if(!context.mounted) return;

                                            context.go(
                                                '/alerta-succes',
                                                extra:{
                                                    "categoria": widget.categoria,
                                                    "subcategoria": seleccionada,
                                                    "comentario": comentarioController.text,
                                                    "imagen": imageUrl,
                                                    "ubicacion": "edificio C",//stos mecanicos
                                                    "fecha": "20/06/2026",
                                                    "hora": "12:00",
                                                },
                                            );

                                        } catch(e){
                                            print("Error POST incidente: $e");
                                        }
                                    },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.azul,
                                ),
                                child: const Text(AppStrings.sendAlert),
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}