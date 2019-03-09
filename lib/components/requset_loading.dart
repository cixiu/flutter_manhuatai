import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RequestLoading extends Dialog {
  final String message;

  RequestLoading({Key key, this.message = '正在请求中...'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SpinKitFadingCircle(
                color: Colors.black,
                size: 50.0,
              ),
              Text(
                message,
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

showLoading(BuildContext context, {String message}) {
  // 显示请求的loading
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return RequestLoading(message: message);
    },
  );
}

hideLoading(BuildContext context) {
  return Navigator.of(context, rootNavigator: true).pop();
}
