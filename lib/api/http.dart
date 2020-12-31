import 'dart:io';
import 'dart:async';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

/// http请求
class HttpRequest {
  static Dio dio = Dio(BaseOptions(
    connectTimeout: 60000,
    receiveTimeout: 60000,
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

  // 开发模式下打开代理进行 http 抓包
  static _proxyClient() {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.findProxy = (uri) {
        //proxy all request to localhost:8888
        // android emuldator ip = 10.0.2.2
        // 如果使用的是安卓模拟器则打开下面的注释
        // return "PROXY 10.0.2.2:8888";

        // android real proxy ip = 192.168.xx.xxx:xxxx
        // 如果使用的是安卓真机则打开下面的注释
        return "PROXY 192.168.1.147:8888";
      };
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };
  }

  static Future<T> get<T>(
    String url, {
    Map<String, dynamic> params,
    Options options,
  }) async {
    // _proxyClient();
    Response<T> response = await dio.get<T>(
      url,
      queryParameters: params,
      options: options,
    );
    return response.data;
  }

  static Future<Map> post(
    String url, {
    Map<String, dynamic> data,
    Map<String, dynamic> params,
    Options options,
  }) async {
    // _proxyClient();
    Response<Map> response = await dio.post<Map>(
      url,
      data: data,
      queryParameters: params,
      options: options,
    );
    return response.data;
  }

  static Future<Map> put(
    String url, {
    Map<String, dynamic> data,
    Map<String, dynamic> params,
    Options options,
  }) async {
    // _proxyClient();
    Response<Map> response = await dio.put<Map>(
      url,
      data: data,
      queryParameters: params,
      options: options,
    );
    return response.data;
  }
}
