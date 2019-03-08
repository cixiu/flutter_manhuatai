import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './components/input_phone.dart';
import './components/input_validate_code.dart';
import './components/img_code_dialog.dart';
import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/models/user_info.dart';
import 'package:flutter_manhuatai/common/const/app_const.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _phone = '';
  var _validateCode = '';
  int _countSeconds = 60;
  bool _hasSendSms = false;
  bool _isRequestValidateCode = false;
  Uint8List imgCodeBytes;
  String content = '';

  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  void initState() {
    super.initState();
    _phoneController.value = TextEditingValue(text: _phone);
    _codeController.value = TextEditingValue(text: _validateCode);
  }

  void _showToast() {
    showToast(
      '无效的手机号码',
      radius: 20.0,
      backgroundColor: Colors.black.withOpacity(0.8),
    );
  }

  // 登录操作
  void onPressLogin() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(prefs.getKeys());
    // 无效的手机号码
    if (!AppConst.phoneReg.hasMatch(_phone)) {
      return _showToast();
    }

    print(_phone);
    print(_validateCode);
    // 发送数据 获取用户登录所需的token
    var response = await Api.mobileBind(
      mobile: _phone,
      vcode: _validateCode,
    );

    // 拿到返回的token即可进行登录获取用户信息
    if (response['status'] == 0) {
      String token = response['data']['appToken'];
      var userInfoMap = await Api.getUserInfo(token: token);
      var userInfoString = json.encode(userInfoMap);
      var userInfo = UserInfo.fromJson(userInfoMap);
      // 将登录的用户存入SharedPreferences缓存且存入redux中
      print(userInfoString);
      // userInfo.commerceauth.
      print(userInfo);
      print(response);
    } else {
      showToast(response['msg']);
      print(response);
    }
  }

  // 获取短信验证码
  _getValidateCode(BuildContext context) async {
    // 验证手机号码是否符合手机格式
    if (!AppConst.phoneReg.hasMatch(_phone)) {
      return _showToast();
    }

    // 正在发送请求，则直接返回
    if (_hasSendSms || _isRequestValidateCode) {
      return;
    }

    setState(() {
      _isRequestValidateCode = true;
    });

    try {
      var response = await Api.sendSms(
        mobile: _phone,
        refresh: '0',
      );

      print(response);

      setState(() {
        _isRequestValidateCode = false;
      });

      // 短信验证码获取成功，
      if (response['status'] == 0) {
        print(response);
        if (response['data'] is Map && (response['data']['Image'] as String).isNotEmpty) {
          showToast(response['msg']);
        } else {
          return _countDownSms();
        }
      } else {
        if ((response['data']['Content'] as String).isNotEmpty) {
          setState(() {
            imgCodeBytes = base64.decode('${response['data']['Image']}');
            content = response['data']['Content'];
          });
          _showDialog(context);
        }
        showToast(response['msg']);
      }
    } catch (e) {
      setState(() {
        _isRequestValidateCode = false;
      });
    }
  }

  // 显示图形验证码Dialog
  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ImgCodeDialog(
          imgCodeBytes: imgCodeBytes,
          content: content,
          phone: _phone,
          success: _validateSuccess,
        );
      },
    );
  }

  // 验证图形码成功
  _validateSuccess() {
    setState(() {
      _hasSendSms = true;
      imgCodeBytes = null;
      content = '';
    });
    _countDownSms();
  }

  // 短信倒计时
  void _countDownSms() {
    int i = 60;
    setState(() {
      _hasSendSms = true;
    });
    showToast('短信发送成功');

    Timer timer = Timer.periodic(Duration(seconds: 1), (Timer _) {
      i--;
      setState(() {
        _countSeconds = i;
      });
      print(i);

      if (i == 0) {
        _.cancel();
        setState(() {
          _countSeconds = 60;
          _hasSendSms = false;
          _isRequestValidateCode = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _showDialog(context);
                    },
                    child: Container(
                      width: 90.0,
                      height: 90.0,
                      margin: EdgeInsets.symmetric(vertical: 35.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          'lib/images/ic_default_avatar.png',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // 手机号
              InputPhone(
                phone: _phone,
                controller: _phoneController,
                onChange: (String val) {
                  setState(() {
                    _phone = val;
                  });
                },
              ),
              // 验证码
              InputValidateCode(
                validateCode: _validateCode,
                controller: _codeController,
                onChange: (String val) {
                  setState(() {
                    _validateCode = val;
                  });
                },
                getValidateCode: _getValidateCode,
                hasGetValidateCode: _hasSendSms,
                countSeconds: _countSeconds,
              ),
              // 登录按钮
              Container(
                margin: EdgeInsets.only(
                  top: 50.0,
                ),
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                width: MediaQuery.of(context).size.width,
                height: 45.0,
                // child: Text,
                child: FlatButton(
                  color: Colors.blue,
                  shape: StadiumBorder(),
                  child: Text(
                    '登录',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: onPressLogin,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
