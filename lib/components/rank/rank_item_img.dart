import 'package:flutter/material.dart';

import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';
import 'package:flutter_manhuatai/utils/utils.dart';

import 'package:flutter_manhuatai/models/rank_list.dart' as RankList;

class RankItemImg extends StatefulWidget {
  final RankList.ListSub item;
  final double width;
  final double height;
  final int index;
  final String url;

  RankItemImg(
      {Key key, @required this.item, this.width, this.height, @required this.index, @required this.url})
      : super(key: key);

  @override
  RankItemImgState createState() => RankItemImgState();
}

class RankItemImgState extends State<RankItemImg> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              ImageWrapper(
                width: widget.width,
                height: widget.height,
                url: widget.url,
              ),
              Positioned(
                top: 8.0,
                right: 0.0,
                child: Container(
                  padding: EdgeInsets.fromLTRB(6.0, 2.0, 4.0, 2.0),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(33, 150, 243, 0.7),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'lib/images/icon_comic_human.png',
                        width: 12.0,
                        height: 12.0,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(Utils.formatNumber(widget.item.countNum), style: TextStyle(color: Colors.white, fontSize: 12.0),),
                      ),
                      ClipOval(
                        child: Container(
                          color: Colors.white,
                          width: 14.0,
                          height: 14.0,
                          child: Center(
                            child: Text(
                              '${widget.index + 1}',
                              style:
                                  TextStyle(fontSize: 12.0, color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(widget.item.comicName, overflow: TextOverflow.ellipsis,),
          )
        ],
      ),
    );
  }
}
