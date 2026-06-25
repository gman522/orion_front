import '../repositories/categoria_repository.dart';
import 'package:image_picker/image_picker.dart';
import '../models/incidente_request.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../constants/app_strings.dart';
import '../services/api_service.dart';
import '../models/subcategoria.dart';
import '../theme/app_colors.dart';
import 'dart:io';



class SubcategoriaScreen extends StatefulWidget {
    final int categoriaId;

    const SubcategoriaScreen({
        super.key,
        required this.categoriaId,
    });

    @override
    State<SubcategoriaScreen> createState() => _SubcategoriaScreenState();
}

class _SubcategoriaScreenState extends State<SubcategoriaScreen>{
    bool isLoading = false;
    final TextEditingController comentarioController = TextEditingController();
    final repo = CategoriaRepository(ApiService());
    final ImagePicker picker = ImagePicker();
    late Future<List<Subcategoria>> futureSubcategorias;
    int? seleccionada;
    Subcategoria? subcategoriaSeleccionada;
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

    @override
    void initState(){
        super.initState();
        futureSubcategorias =
            repo.obtenerSubcategorias(widget.categoriaId);
    }

    Color getColorCategoria(String categoria) {
        switch (categoria) {
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

    String get nombreCategoria{
        switch (widget.categoriaId){
            case 1:
                return "SALUD";
            case 2:
                return "INFRAESTRUCTURA";
            case 3:
                return "SEGURIDAD";
            default:
                return "CATEGORIA";
        }
    }

    @override
    Widget build(BuildContext context){
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
                title: Text(nombreCategoria),
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
                                color: getColorCategoria(nombreCategoria.toUpperCase()),
                                borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                                nombreCategoria,
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
                            child: FutureBuilder<List<Subcategoria>>(
                                future: futureSubcategorias,
                                builder: (context, snapshot){

                                    if(snapshot.connectionState == ConnectionState.waiting){
                                        return const Center(child: CircularProgressIndicator());
                                    }

                                    if(snapshot.hasError){
                                        return Center(child: Text("Error: ${snapshot.error}"));
                                    }

                                    final lista = snapshot.data ?? [];

                                    return ListView.builder(
                                        itemCount: lista.length,
                                        itemBuilder: (context, index){
                                            final item = lista[index];
                                            final isSelected = seleccionada == item.id;

                                            return ListTile(
                                                tileColor: isSelected ? Colors.grey.shade300 : null,
                                                title: Text(item.nombre),
                                                trailing: isSelected
                                                    ? const Icon(Icons.check_circle, color: Colors.blue)
                                                    : null,
                                                onTap: (){
                                                    setState((){
                                                        seleccionada = item.id;
                                                        subcategoriaSeleccionada = item;
                                                    });
                                                },
                                            );
                                        },
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
                        
                        Row(
                            children:[
                                Expanded(
                                    child: ElevatedButton.icon(
                                        onPressed: tomarFoto,
                                        icon:const Icon(Icons.camera_alt),
                                        label: const Text("Camara (opcional)"),
                                    ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                    child: ElevatedButton.icon(
                                        onPressed: seleccionarDeGaleria,
                                        icon: const Icon(Icons.photo),
                                        label: const Text("Galeria (Opcional)")
                                    ),
                                ),
                            ],
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
                                onPressed: seleccionada == null || isLoading
                                    ? null 
                                    : () async {
                                        try{
                                            setState(() => isLoading = true);

                                            final request = IncidenteRequest(
                                                subcategoriaId: seleccionada!,
                                                descripcion: comentarioController.text.trim().isEmpty
                                                    ? null
                                                    : comentarioController.text.trim(),
                                            );

                                            await repo.crearIncidente(request);

                                            if(!context.mounted) return;

                                            context.go(
                                                '/alerta-success',
                                                extra:{
                                                    "categoria": widget.categoriaId == 1
                                                        ? "Salud"
                                                        : widget.categoriaId == 2
                                                            ? "Infraestructura"
                                                            : "Seguridad",
                                                    "subcategoria": subcategoriaSeleccionada?.nombre ?? "N/A",
                                                    "ubicacion": "casino",
                                                    "fecha": DateTime.now().toString(),
                                                    "hora": TimeOfDay.now().format(context),
                                                },
                                            );

                                        } catch(e){
                                            print("Error POST incidente: $e");
                                        }finally{
                                            if(mounted){
                                                setState(() => isLoading = false);
                                            }
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