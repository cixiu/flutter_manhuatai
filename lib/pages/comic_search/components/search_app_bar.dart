import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/routes/routes.dart';
import 'package:flutter_manhuatai/utils/sp.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef void OnChange(String val);

class SearchAppBar extends StatelessWidget {
  final TextEditingController controller;
  final String searchKey;
  final OnChange onChange;
  final VoidCallback close;

  SearchAppBar({
    this.controller,
    this.searchKey,
    this.onChange,
    this.close,
  });

  void _navigateToSearchResultPage(BuildContext context, String query) {
    String keyword = Uri.encodeComponent(query);
    Application.router
        .navigateTo(context, '${Routes.searchResult}?keyword=$keyword');
    SpUtils.saveSearchHistory(query);
  }

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
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: controller,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(28),
                            ),
                            decoration: InputDecoration(
                              hintText: '请输入漫画名或其他关键词',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(20),
                                vertical: ScreenUtil().setWidth(6),
                              ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: onChange,
                            onSubmitted: (val) {
                              if (val.isEmpty) {
                                return;
                              }
                              _navigateToSearchResultPage(context, val);
                            },
                          ),
                        ),
                        searchKey.isEmpty
                            ? Container(
                                height: 0.0,
                              )
                            : GestureDetector(
                                onTap: close,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(20),
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    size: ScreenUtil().setSp(40),
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                      ],
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
