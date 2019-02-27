import 'package:flutter/material.dart';
import 'rank_title.dart';

// 排行榜 - 综合榜
class RankAll extends StatelessWidget {
  final Widget child;

  RankAll({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: <Widget>[
          RankTitle(type: 'all', title: '综合榜',)
        ],
      ),
    );
  }
}
