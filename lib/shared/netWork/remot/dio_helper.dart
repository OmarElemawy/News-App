
import 'package:dio/dio.dart';

class DioHelper{

  static Dio dio=Dio();

  static init(){
    dio = Dio(BaseOptions(
    baseUrl:'https://newsapi.org/',
    receiveDataWhenStatusError: true
    ));
  }
  static Future<Response> getData({required String url,required Map<String,dynamic> query})async
  {
    return await dio.get(url,queryParameters: query,);
  }
}
//https://newsapi.org/v2/everything?q=tesla&apiKey=a1835b629e5d4d189ead989c673a5acb