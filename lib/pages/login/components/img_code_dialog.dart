import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import 'package:flutter_manhuatai/api/api.dart';

/// 一般的Dialog需要添加布局结构Material这个Widget
///
/// 验证码的Dialog
/// 由于此处有溢出的图片，点击溢出的图片的左右2侧也需要关闭Dialog,
/// 所以此处没有加入Material，Scaffold等布局结构，所以build方法里的widget是没有Theme主题的，
/// 对于Text这种Widget,则需要手动设置一些样式，否则会没有默认的样式（红色大号字体+黄色下划线）
class ImgCodeDialog extends StatefulWidget {
  final Uint8List imgCodeBytes;
  final String content;
  final String phone;
  final Function success;

  ImgCodeDialog({
    Key key,
    this.imgCodeBytes,
    this.content,
    this.phone,
    this.success,
  }) : super(key: key);

  @override
  _ImgCodeDialogState createState() => _ImgCodeDialogState();
}

class _ImgCodeDialogState extends State<ImgCodeDialog> {
  GlobalKey _imgKey = GlobalKey();
  Uint8List _imgCodeBytes;
  String _content;
  int _imgTapTimes = 0;
  bool _isValidating = false;
  Map<String, dynamic> imgCodeData;
  bool showFirstPointer = false;
  double firstLeft = 0.0;
  double firstTop = 0.0;
  bool showSecondPointer = false;
  double secondLeft = 0.0;
  double secondTop = 0.0;

  void initState() {
    super.initState();
    _imgCodeBytes = widget.imgCodeBytes;
    _content = widget.content;
    imgCodeData = {
      'appId': 2,
      'fontPoints': [],
      'userIdentifier': widget.phone,
      'verificaType': 2,
    };
  }

  // 点击图片验证码
  void _tapImgCode(TapUpDetails details) {
    _imgTapTimes++;
    if (_imgTapTimes > 2) {
      _imgTapTimes--;
      return;
    }

    RenderBox imgBox = _imgKey.currentContext.findRenderObject();
    Offset imgPosition = imgBox.localToGlobal(Offset.zero);

    // 在验证码图片中点击的位置(相对于屏幕左上角)
    double pointX = details.globalPosition.dx;
    double pointY = details.globalPosition.dy;

    // 验证码图片的尺寸大小
    double imgClientX = imgBox.size.width;
    double imgClientY = imgBox.size.height;

    // 验证码图片尺寸大小，相对于原始图片的尺寸比例
    double ratioX = 460 / imgClientX;
    double ratioY = 200 / imgClientY;

    // 验证码图片相对于屏幕左上角的位置
    double imgPositionX = imgPosition.dx;
    double imgPositionY = imgPosition.dy;

    // 在验证码图片中点击的位置
    double diffX = pointX - imgPositionX;
    double diffY = pointY - imgPositionY;

    // 在验证码图片中点击的原始位置（相对于图片的原始尺寸）
    int x = (diffX * ratioX).floor();
    int y = (diffY * ratioY).floor();

    (imgCodeData['fontPoints'] as List).add({'x': x, 'y': y});

    if (_imgTapTimes == 1) {
      setState(() {
        showFirstPointer = true;
        firstLeft = diffX;
        firstTop = diffY;
      });
    }

    if (_imgTapTimes == 2) {
      setState(() {
        showSecondPointer = true;
        secondLeft = diffX;
        secondTop = diffY;
      });
    }
    print(imgCodeData);
  }

  // 刷新图片验证码
  void _refreshImgCode() async {
    var res = await Api.sendSms(mobile: widget.phone);

    _resetState(res);
  }

  // 验证图形验证码
  void _validateImgCode() async {
    if (_isValidating) {
      return;
    }
    _isValidating = true;
    if (!showFirstPointer && !showSecondPointer) {
      showToast(
        '请在上图中点击正确的示例文字',
        position: ToastPosition.bottom,
      );
      return;
    }
    var res = await Api.sendSms(
      mobile: widget.phone,
      imgCode: json.encode(imgCodeData),
      refresh: '0',
    );
    _isValidating = false;
    _resetState(res);
  }

  // 重置state
  void _resetState(res) {
    print(res);
    if (res['data'] is Map) {
      String imgCode = res['data']['Image'];
      // 更新图形码
      if (imgCode != null && imgCode.isNotEmpty) {
        _imgTapTimes = 0;
        imgCodeData['fontPoints'] = [];
        setState(() {
          _imgCodeBytes = base64.decode(res['data']['Image']);
          _content = res['data']['Content'];
          showFirstPointer = false;
          showSecondPointer = false;
        });
      }
    }

    if (res['status'] == 0) {
      widget.success();
      Navigator.pop(context);
    } else {
      showToast(
        res['msg'],
        position: ToastPosition.bottom,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Center(
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Container(
            width: screenSize.width - 90.0,
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
                  width: screenSize.width - 90.0 - 40.0,
                  height: (screenSize.width - 90.0 - 40.0) * 200 / 460,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: <Widget>[
                      GestureDetector(
                        onTapUp: _tapImgCode,
                        child: Image.memory(
                          _imgCodeBytes,
                          key: _imgKey,
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
                          onPressed: _refreshImgCode,
                        ),
                      ),
                      showFirstPointer
                          ? Positioned(
                              top: firstTop - 15.0 / 2,
                              left: firstLeft - 15.0 / 2,
                              child: ClipOval(
                                child: Container(
                                  width: 15.0,
                                  height: 15.0,
                                  color: Colors.green,
                                  child: Text(
                                    '1',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      showSecondPointer
                          ? Positioned(
                              top: secondTop - 15.0 / 2,
                              left: secondLeft - 15.0 / 2,
                              child: ClipOval(
                                child: Container(
                                  width: 15.0,
                                  height: 15.0,
                                  color: Colors.green,
                                  child: Text(
                                    '2',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
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
                      Expanded(
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
                        width: 77.0,
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
                          padding: EdgeInsets.all(0.0),
                          child: Text(
                            _content,
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red[700],
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: screenSize.width - 90.0,
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
                    onPressed: _validateImgCode,
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
