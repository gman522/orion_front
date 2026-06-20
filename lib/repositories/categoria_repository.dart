import '../models/incidente_request.dart';
import '../services/api_service.dart';
import '../config/api_config.dart';
import '../models/categoria.dart';
import 'dart:io';

class CategoriaRepository{
    final ApiService apiService;

    CategoriaRepository(this.apiService);

    Future<List<Categoria>> obtenerCategorias() async{
        final response =
            await apiService.get(ApiConfig.categoriasEndpoint);

        final List data = response.data;

        return data.map((e) => Categoria.fromJson(e)).toList();
    }

    Future<dynamic> crearIncidente(IncidenteRequest request) async{
        final response = await apiService.post(
            ApiConfig.incidentesEndpoint,
            request.toJson(),
        );

        return response.data;
    }

    Future<String> subirImagen(File file) async{
        final fileName = file.path.split('/').last;

        final presigned = await apiService.getPresignedUrl(fileName);

        final uploadUrl = presigned.data["uploadUrl"];
        final publicUrl = presigned.data["publicUrl"];

        await apiService.uploadFileToUrl(uploadUrl, await file.readAsBytes());

        return publicUrl;
    }
}