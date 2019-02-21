import 'dart:async';
import 'package:dio/dio.dart';

/// http请求
class HttpRequest {
  static Dio dio = Dio(BaseOptions(
    connectTimeout: 60000,
    receiveTimeout: 60000,
  ))..interceptors.add(InterceptorsWrapper(
    onRequest: (RequestOptions request) {
      print('正在 request');
      return request;
    },
    onResponse: (Response response) {
      print('正在 response');
      return response;
    },
    onError: (DioError e) {
      print('出错了');
      return e;
    }
  ));

  static Future<T> get<T>(String url, {Map<String, dynamic> params}) async {
    Response<T> response = await dio.get(url, queryParameters: params);
    return response.data;
  }

  static Future<T> post<T>(String url,
      {Map<String, dynamic> data, Map<String, dynamic> params}) async {
    Response<T> response =
        await dio.post(url, data: data, queryParameters: params);
    return response.data;
  }
}
