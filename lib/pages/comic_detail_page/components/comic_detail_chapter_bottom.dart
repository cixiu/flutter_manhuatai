import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComicDetailChapterBottom extends StatelessWidget {
  final String collect;
  final String comicCommentCount;
  final VoidCallback onTapCloseAll;

  ComicDetailChapterBottom({
    this.collect,
    this.comicCommentCount,
    this.onTapCloseAll,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
            child: Container(
              height: ScreenUtil().setWidth(114),
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(30),
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.blue,
                    width: ScreenUtil().setSp(1),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: ScreenUtil().setWidth(58),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '${Utils.formatNumber(collect)}',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                            color: Colors.blue,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(20),
                          ),
                          child: Image.asset(
                            'lib/images/icon_detail_colect_tag.png',
                            width: ScreenUtil().setWidth(58),
                            height: ScreenUtil().setWidth(58),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: onTapCloseAll,
                    child: Container(
                      height: ScreenUtil().setWidth(58),
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(44),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xff019eed),
                        borderRadius: BorderRadius.circular(
                          ScreenUtil().setWidth(29),
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '小主，请收起',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(28),
                            ),
                          ),
                          Icon(
                            Icons.expand_less,
                            color: Colors.white,
                            size: ScreenUtil().setSp(40),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: ScreenUtil().setWidth(58),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            right: ScreenUtil().setWidth(20),
                          ),
                          child: Image.asset(
                            'lib/images/icon_detail_revert_tag.png',
                            width: ScreenUtil().setWidth(58),
                            height: ScreenUtil().setWidth(58),
                          ),
                        ),
                        Text(
                          '${Utils.formatNumber(comicCommentCount)}',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
