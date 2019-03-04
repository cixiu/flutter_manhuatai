import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';

/// http请求
class HttpRequest {
  static Dio dio = Dio(BaseOptions(
    connectTimeout: 30000,
    receiveTimeout: 30000,
  ))
    ..interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions request) {
      print('正在 request');
      return request;
    }, onResponse: (Response response) {
      print('正在 response');
      return response;
    }, onError: (DioError e) {
      print('出错了');
      return e;
    }));

  static _proxyClient() {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.findProxy = (uri) {
        //proxy all request to localhost:8888
        // android emuldator ip = 10.0.2.2
        return "PROXY 10.0.2.2:8888";
      };
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };
  }

  static Future<T> get<T>(
    String url, {
    Map<String, dynamic> params,
  }) async {
    // _proxyClient();
    Response<T> response = await dio.get(
      url,
      queryParameters: params,
    );
    return response.data;
  }

  static Future<T> post<T>(
    String url, {
    Map<String, dynamic> data,
    Map<String, dynamic> params,
    Options options,
  }) async {
    // _proxyClient();
    Response<T> response = await dio.post<T>(
      url,
      data: data,
      queryParameters: params,
      options: options,
    );
    return response.data;
  }
}
