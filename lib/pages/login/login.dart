import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 90.0,
                height: 90.0,
                margin: EdgeInsets.symmetric(vertical: 35.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    'lib/images/ic_default_avatar.png',
                  ),
                ),
              ),
            ],
          ),
          Container(
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
                  child: TextFormField(
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
                  ),
                ),
              ],
            ),
          ),
          Container(
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
                  child: TextFormField(
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
                  ),
                ),
                Container(
                  height: 28.0,
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    child: Text(
                      '获取验证码',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
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
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
