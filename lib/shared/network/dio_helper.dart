import 'package:dio/dio.dart';

class DioHelper{
  static late Dio dio;
  static Future dioInitialization() async {
    dio = Dio(
        BaseOptions(
          baseUrl: 'https://api.escuelajs.co/api/v1/',
          receiveDataWhenStatusError: true,
        ));
  }

  static Future<Response> postData({required String methodUrl,required Map<String,dynamic> data,Map<String,dynamic>? queryParameters}){
    dio.options.headers =
    {
      'content-type' : 'application/json',
    };
    return dio.post(
      methodUrl,
      data: data,
      queryParameters: queryParameters,
    );
  }

  static Future<Response> updateData({required String methodUrl,required Map<String,dynamic> data,Map<String,dynamic>? queryParameters}){
    dio.options.headers =
    {
      'content-type' : 'application/json',
    };
    return dio.put(
      methodUrl,
      data: data,
      queryParameters: queryParameters,
    );
  }

  static Future<Response> deleteData({required String methodUrl,required Map<String,dynamic> data,Map<String,dynamic>? queryParameters}){
    dio.options.headers =
    {
      'content-type' : 'application/json',
    };
    return dio.delete(
      methodUrl,
      data: data,
      queryParameters: queryParameters,
    );
  }

  static Future<Response> getData({required String methodUrl,Map<String,dynamic>? queryParameters}){
    dio.options.headers =
    {
      'content-type' : 'application/json',
    };
    return dio.get(
      methodUrl,
      queryParameters: queryParameters,
    );
  }

}