import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/api_service.dart';
import '../repositories/categoria_repository.dart';

final apiServiceProvider = Provider<ApiService>((ref){
    return ApiService();
});

final categoriaRepositoryProvider =
    Provider<CategoriaRepository>((ref){
        
        final apiService = ref.watch(apiServiceProvider);

        return CategoriaRepository(apiService);
    });