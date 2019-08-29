import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum WhyFarther { hot, newest }

class CommentTypeHeader extends StatelessWidget {
  final int count;
  final WhyFarther commentType;
  final void Function(WhyFarther) onSelected;

  CommentTypeHeader({
    this.count,
    this.commentType,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(30),
      ),
      color: Colors.white,
      height: ScreenUtil().setWidth(80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '评论 （$count）',
            style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setWidth(32),
            ),
          ),
          PopupMenuButton(
            child: Text(
              commentType == WhyFarther.hot ? '最热' : '最新',
              style: TextStyle(
                color: Colors.grey,
                fontSize: ScreenUtil().setWidth(24),
              ),
            ),
            onSelected: (WhyFarther result) {
              if (onSelected != null) {
                onSelected(result);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<WhyFarther>>[
              PopupMenuItem<WhyFarther>(
                value: WhyFarther.hot,
                enabled: commentType != WhyFarther.hot,
                child: Text('最热'),
              ),
              PopupMenuItem<WhyFarther>(
                value: WhyFarther.newest,
                enabled: commentType != WhyFarther.newest,
                child: Text('最新'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
