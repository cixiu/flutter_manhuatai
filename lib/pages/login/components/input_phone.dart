import 'package:flutter/material.dart';

typedef void InputOnChange(String val);

class InputPhone extends StatefulWidget {
  final String phone;
  final TextEditingController controller;
  final InputOnChange onChange;

  InputPhone({
    Key key,
    @required this.phone,
    @required this.controller,
    @required this.onChange,
  }) : super(key: key);

  _InputPhoneState createState() => _InputPhoneState();
}

class _InputPhoneState extends State<InputPhone> {
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
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: Colors.grey[400]),
              ),
            ),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'lib/images/ic_user_account.png',
                  width: 22.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    '+86',
                    style: TextStyle(
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
              ],
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
                hintText: '请输入手机号',
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
        ],
      ),
    );
  }
}
