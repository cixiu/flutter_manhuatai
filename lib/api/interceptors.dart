import 'package:dio/dio.dart';

interceptorsDio() {
  BaseOptions options = BaseOptions(
    connectTimeout: 60000,
    receiveTimeout: 60000,
  );

  Dio dio = Dio(options);

  dio.interceptors.add(InterceptorsWrapper(
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
}
