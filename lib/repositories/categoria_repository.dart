import '../services/api_service.dart';
import '../models/categoria.dart';
import '../config/api_config.dart';

class CategoriaRepository{
    final ApiService apiService;

    CategoriaRepository(this.apiService);

    Future<List<Categoria>> obtenerCategorias() async{
        final response =
            await apiService.get(ApiConfig.categoriasEndpoint);

        final List data = response.data;

        return data.map((e) => Categoria.fromJson(e)).toList();
    }
}