import 'package:dio/dio.dart';
import '../config/api_config.dart';

class ApiService{
    final Dio _dio = Dio(
        BaseOptions(
            baseUrl: ApiConfig.baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
        ),
    );

    Future<Response> get(String path) async{
        try{
            return await _dio.get(path);
        } catch(e){
            throw Exception("Error GET: $e");
        }
    }

    Future<Response> post(String path, dynamic data) async{
        try{
            return await _dio.post(path, data: data);
        } catch(e){
            throw Exception("Error Post: $e");
        }
    }
}