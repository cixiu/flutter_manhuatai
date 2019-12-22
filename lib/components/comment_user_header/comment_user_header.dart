import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/utils/utils.dart';

class CommentUserHeaderType {
  final int uid;
  final int ulevel;
  final String uname;
  final String floorDesc;
  final int createtime;
  final String deviceTail;

  CommentUserHeaderType({
    @required this.uid,
    @required this.ulevel,
    @required this.uname,
    this.floorDesc,
    @required this.createtime,
    this.deviceTail,
  });
}

class CommentUserHeader extends StatelessWidget {
  final CommentUserHeaderType item;

  CommentUserHeader({
    this.item,
  });

  @override
  Widget build(BuildContext context) {
    double width = ScreenUtil().setWidth(80);
    double height = width;

    return Container(
      height: ScreenUtil().setWidth(80),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: ScreenUtil().setWidth(1),
                  ),
                  borderRadius: BorderRadius.circular(
                    ScreenUtil().setWidth(40),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    width / 2,
                  ),
                  child: ImageWrapper(
                    url: Utils.generateImgUrlFromId(
                      id: item.uid,
                      aspectRatio: '1:1',
                      type: 'head',
                    ),
                    width: width,
                    height: height,
                  ),
                ),
                // child: CircleAvatar(
                //   backgroundColor: Colors.white,
                //   backgroundImage: NetworkImage(
                //     Utils.generateImgUrlFromId(
                //       id: item.uid,
                //       aspectRatio: '1:1',
                //       type: 'head',
                //     ),
                //   ),
                //   radius: ScreenUtil().setWidth(40),
                // ),
              ),
              Stack(
                alignment: Alignment(0.5, 1.5),
                children: <Widget>[
                  Image.asset(
                    'lib/images/icon_lv_bg_big.png',
                    width: ScreenUtil().setWidth(66),
                    height: ScreenUtil().setWidth(24),
                  ),
                  Text(
                    '${item.ulevel}',
                    strutStyle: StrutStyle(
                      forceStrutHeight: true,
                      fontSize: ScreenUtil().setSp(18),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(18),
                    ),
                  ),
                ],
              )
            ],
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      right: ScreenUtil().setWidth(10),
                    ),
                    height: ScreenUtil().setSp(42),
                    child: Text(
                      item.uname,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(28),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      item.floorDesc != null && item.floorDesc.isNotEmpty
                          ? Container(
                              margin: EdgeInsets.only(
                                right: ScreenUtil().setWidth(30),
                              ),
                              child: Text(
                                '${item.floorDesc}',
                                strutStyle: StrutStyle(
                                  forceStrutHeight: true,
                                  fontSize: ScreenUtil().setSp(20),
                                ),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: ScreenUtil().setSp(20),
                                ),
                              ),
                            )
                          : Container(),
                      Container(
                        margin: EdgeInsets.only(
                          right: ScreenUtil().setWidth(30),
                        ),
                        child: Text(
                          '${Utils.fromNow(item.createtime)}',
                          strutStyle: StrutStyle(
                            forceStrutHeight: true,
                            fontSize: ScreenUtil().setSp(20),
                          ),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: ScreenUtil().setSp(20),
                          ),
                        ),
                      ),
                      item.deviceTail != null
                          ? Text(
                              '${item.deviceTail}',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: ScreenUtil().setSp(20),
                              ),
                            )
                          : Container(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
