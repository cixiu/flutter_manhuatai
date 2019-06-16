import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: statusBarHeight,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(20),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                        width: ScreenUtil().setWidth(1),
                      ),
                      borderRadius: BorderRadius.circular(
                        ScreenUtil().setWidth(30),
                      ),
                    ),
                    child: TextField(
                      // controller: widget.controller,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(28),
                      ),
                      decoration: InputDecoration(
                        hintText: '请输入漫画名或其他关键词',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(10),
                          vertical: ScreenUtil().setWidth(6),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      // onChanged: widget.onChange,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      left: ScreenUtil().setWidth(30),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setWidth(20),
                    ),
                    child: Text(
                      '取消',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: ScreenUtil().setSp(28),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
