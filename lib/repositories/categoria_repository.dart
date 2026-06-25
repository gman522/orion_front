import '../models/incidente_request.dart';
import '../data/mock_subcategorias.dart';
import '../services/api_service.dart';
import '../models/subcategoria.dart';
import '../config/api_config.dart';
import '../models/categoria.dart';
import 'dart:io';

class CategoriaRepository{
    final ApiService apiService;

    CategoriaRepository(this.apiService);

    Future<List<Categoria>> obtenerCategorias() async{
        return[
            Categoria(id: 1, nombre: "Salud"),
            Categoria(id: 2, nombre: "Infraestructura"),
            Categoria(id: 3, nombre: "Seguridad"),
        ];
    }

    Future<void> crearIncidente(IncidenteRequest request) async{
        await Future.delayed(const Duration(seconds: 1));
        print("INCIDENTE MOCK: ${request.toJson()}");
    }

    Future<String> subirImagen(File file) async{
        final fileName = file.path.split('/').last;

        final presigned = await apiService.getPresignedUrl(fileName);

        final uploadUrl = presigned.data["uploadUrl"];
        final publicUrl = presigned.data["publicUrl"];

        await apiService.uploadFileToUrl(uploadUrl, await file.readAsBytes());

        return publicUrl;
    }

    Future<List<Subcategoria>> obtenerSubcategorias(int categoriaId) async{
        return MockSubcategorias.porCategoria(categoriaId);
    }
}