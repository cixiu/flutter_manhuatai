import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/components/radius_container/radius_container.dart';
import 'package:flutter_manhuatai/models/comic_info_role.dart';

class ComicDetailRole extends StatelessWidget {
  final List<Data> comicInfoRole;

  ComicDetailRole({
    this.comicInfoRole,
  });

  List<Widget> _buildRoleWidget() {
    return comicInfoRole.take(4).map((role) {
      return Container(
        width: ScreenUtil().setWidth(175),
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    ScreenUtil().setWidth(33),
                  ),
                  child: ImageWrapper(
                    url: role.sculpture,
                    width: ScreenUtil().setWidth(66),
                    height: ScreenUtil().setWidth(66),
                    fit: BoxFit.cover,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    ScreenUtil().setWidth(34),
                  ),
                  child: Image.asset(
                    'lib/images/pic_tx.png',
                    width: ScreenUtil().setWidth(68),
                    height: ScreenUtil().setWidth(68),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: ScreenUtil().setWidth(2),
                  ),
                  child: Text(
                    role.typename,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(16),
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setWidth(12),
              ),
              constraints: BoxConstraints(
                maxWidth: ScreenUtil().setWidth(160),
              ),
              child: Text(
                role.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(20),
                  color: Colors.black54,
                ),
              ),
            )
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (comicInfoRole == null || comicInfoRole.length == 0) {
      return Container();
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(20),
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: ScreenUtil().setWidth(1),
            color: Colors.grey[200],
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setWidth(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '作者&角色',
                  style: TextStyle(
                    fontSize: ScreenUtil().setWidth(32),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                RadiusContainer(
                  text: '全部',
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: ScreenUtil().setWidth(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: _buildRoleWidget(),
            ),
          )
        ],
      ),
    );
  }
}
