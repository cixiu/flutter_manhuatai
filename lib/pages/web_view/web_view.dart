import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatefulWidget {
  final String url;

  WebViewPage({
    this.url,
  });

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  String _title = '';

  @override
  void initState() {
    super.initState();
    // 页面加载完成后，设置title
    flutterWebviewPlugin.onStateChanged.listen((state) async {
      if (state.type == WebViewState.finishLoad) {
        String title =
            await flutterWebviewPlugin.evalJavascript('document.title;');
        setState(() {
          _title = jsonDecode(title);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      userAgent: "Android",
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ScreenUtil().setWidth(88)),
        child: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            _title,
            style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(28),
            ),
          ),
        ),
      ),
    );
  }
}
