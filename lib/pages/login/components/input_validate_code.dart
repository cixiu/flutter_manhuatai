import 'package:flutter/material.dart';

typedef void InputOnChange(String val);
typedef void GetValidateCode();

class InputValidateCode extends StatefulWidget {
  final String validateCode;
  final TextEditingController controller;
  final InputOnChange onChange;
  final GetValidateCode getValidateCode;
  final bool hasGetValidateCode;
  final int countSeconds;

  InputValidateCode({
    Key key,
    @required this.validateCode,
    @required this.controller,
    @required this.onChange,
    @required this.getValidateCode,
    this.hasGetValidateCode = false,
    this.countSeconds = 60,
  }) : super(key: key);

  _InputValidateCodeState createState() => _InputValidateCodeState();
}

class _InputValidateCodeState extends State<InputValidateCode> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 12.0),
            child: Image.asset(
              'lib/images/ic_pwd.png',
              width: 22.0,
            ),
          ),
          Expanded(
            child: TextField(
              controller: widget.controller,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 16.0,
              ),
              decoration: InputDecoration(
                hintText: '请输入验证码',
                hintStyle: TextStyle(
                  color: Colors.grey[350],
                ),
                contentPadding: EdgeInsets.all(0.0),
                border: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: widget.onChange,
            ),
          ),
          Container(
            height: 28.0,
            child: FlatButton(
              disabledColor: Colors.grey,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28.0),
              ),
              child: Text(
                widget.hasGetValidateCode
                    ? '倒计时 ${widget.countSeconds.toString().padLeft(2, '0')}秒'
                    : '获取验证码',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed:
                  widget.hasGetValidateCode ? null : widget.getValidateCode,
            ),
          )
        ],
      ),
    );
  }
}
