import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/components/radius_container/radius_container.dart';

import 'package:flutter_manhuatai/models/comic_info_body.dart';
import 'package:flutter_manhuatai/utils/utils.dart';

class ComicDetailChapterTitle extends StatefulWidget {
  final GlobalKey absKey;
  final ComicInfoBody comicInfoBody;
  final VoidCallback onTap;
  final String sortType;

  ComicDetailChapterTitle({
    this.absKey,
    this.comicInfoBody,
    this.onTap,
    this.sortType,
  });

  @override
  _ComicDetailChapterTitleState createState() =>
      _ComicDetailChapterTitleState();
}

class _ComicDetailChapterTitleState extends State<ComicDetailChapterTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.absKey,
      height: ScreenUtil().setWidth(96),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(20),
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[100],
          ),
        ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: widget.onTap,
              behavior: HitTestBehavior.opaque,
              child: Container(
                height: ScreenUtil().setWidth(96),
                child: Row(
                  children: <Widget>[
                    Text(
                      widget.comicInfoBody.comicStatus == 2 ? '完结' : '连载',
                      style: TextStyle(
                        fontSize: ScreenUtil().setWidth(32),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                      child: Image.asset(
                        widget.sortType == 'ASC'
                            ? 'lib/images/icon_detail_list_b.png'
                            : 'lib/images/icon_detail_list_a.png',
                        width: ScreenUtil().setWidth(20),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(30),
                      ),
                      child: Text(
                        '${Utils.formatDate(widget.comicInfoBody.updateTime)}',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(20),
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          right: ScreenUtil().setWidth(30),
                        ),
                        child: Text(
                          '${widget.comicInfoBody.lastChapterName}',
                          overflow: TextOverflow.ellipsis,
                          strutStyle: StrutStyle(
                            forceStrutHeight: true,
                            fontSize: ScreenUtil().setSp(20),
                          ),
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(20),
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          RadiusContainer(
            text: '选集',
          ),
        ],
      ),
    );
  }
}
