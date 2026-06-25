import 'package:dio/dio.dart';
import '../config/api_config.dart';

class ApiService{
    final Dio _dio = Dio(
        BaseOptions(
            baseUrl: ApiConfig.baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),

            headers:{
                'ngrok-skip-browser-warning': 'true',
                'Content-Type': 'application/json',
            },
        ),
    );

    Future<Response> get(String path) async{
        try{
            final fullUrl = "${ApiConfig.baseUrl}$path";
            print("GET -> $fullUrl");

            return await _dio.get(path);
        } catch(e){
            print("Error GET: $e");
            rethrow;
        }
    }

    Future<Response> post(String path, dynamic data) async{
        try{
            return await _dio.post(path, data: data);
        } catch(e){
            throw Exception("Error Post: $e");
        }
    }

    Future<Response> getPresignedUrl(String fileName) async{
        return await _dio.get(
            ApiConfig.uploadUrlEndpoint,
            queryParameters:{
                "fileName": fileName,
            },
        );
    }

    Future<void> uploadFileToUrl(String url, List<int> bytes) async{
        await _dio.put(
            url,
            data: bytes,
            options: Options(
                headers:{
                    "Content-Type": "image/jpeg",
                },
            ),
        );
    }
}