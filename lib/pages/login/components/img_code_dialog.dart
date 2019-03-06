import 'dart:typed_data';
import 'package:flutter/material.dart';

/// 一般的Dialog需要添加布局结构Material这个Widget
///
/// 验证码的Dialog
/// 由于此处有溢出的图片，点击溢出的图片的左右2侧也需要关闭Dialog,
/// 所以此处没有加入Material，Scaffold等布局结构，所以build方法里的widget是没有Theme主题的，
/// 对于Text这种Widget,则需要手动设置一些样式，否则会没有默认的样式（红色大号字体+黄色下划线）
class ImgCodeDialog extends StatelessWidget {
  final Uint8List imgCodeBytes;

  ImgCodeDialog({Key key, this.imgCodeBytes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width - 90.0,
            margin: EdgeInsets.only(
              top: 55.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: 30.0,
                    right: 20.0,
                    left: 20.0,
                  ),
                  width: MediaQuery.of(context).size.width - 90.0 - 40.0,
                  height: (MediaQuery.of(context).size.width - 90.0 - 40.0) *
                      200 /
                      460,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          print('点击了验证码图片区域');
                        },
                        child: Image.memory(
                          imgCodeBytes,
                        ),
                      ),
                      Container(
                        width: 32.0,
                        height: 32.0,
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: FlatButton(
                          padding: EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.refresh,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          onPressed: () {
                            print('点击了refresh button区域');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 20.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints(maxWidth: 150.0),
                        child: Text(
                          '请在上图中点击正确的示例文字:',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Color(0xdd000000),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      Container(
                        width: 82.0,
                        height: 46.0,
                        margin: EdgeInsets.only(left: 12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xfffd715f), Color(0xffffcc70)],
                          ),
                        ),
                        child: FlatButton(
                          child: Text(
                            '云彩',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700],
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 90.0,
                  height: 45.0,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                  child: FlatButton(
                    child: Text(
                      '确定',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    onPressed: () {
                      print('点击了确定按钮');
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
          Image.asset(
            'lib/images/ico_verification_top.png',
            height: 74.0,
          )
        ],
      ),
    );
  }
}
