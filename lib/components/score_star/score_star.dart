import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

class ScoreStar extends StatefulWidget {
  final String score;

  ScoreStar({@required this.score});

  @override
  _ScoreStarState createState() => _ScoreStarState();
}

class _ScoreStarState extends State<ScoreStar> {
  List<String> _result = [];

  @override
  void initState() {
    _setStarList();
    super.initState();
  }

  // 通过评分来计算图片的列表需要显示的星星
  _setStarList() {
    List<String> result = [];
    double _score = double.parse(widget.score);
    // 获取评分中的整数
    int integerFull = _score.floor();
    // 获取评分中的小数
    double decimal = double.parse((_score - integerFull).toStringAsFixed(1));
    // 最大的评分
    int maxScore = 5;
    // 空星的数量
    int integerEmpty = 0;

    // 满星
    for (int i = 0; i < integerFull; i++) {
      result.add('lib/images/ic_comic_detail_star_yellow_full2.png');
    }
    // 半星
    if (decimal > 0 && decimal <= 0.2) {
      result.add('lib/images/ic_comic_detail_star_yellow_full20.png');
    } else if (decimal > 0.2 && decimal <= 0.4) {
      result.add('lib/images/ic_comic_detail_star_yellow_full40.png');
    } else if (decimal == 0.5) {
      result.add('lib/images/ic_comic_detail_star_yellow_full50.png');
    } else if (decimal > 0.5 && decimal <= 0.7) {
      result.add('lib/images/ic_comic_detail_star_yellow_full60.png');
    } else if (decimal > 0.7) {
      result.add('lib/images/ic_comic_detail_star_yellow_full80.png');
    }
    // 如果评分小于 总分(maxScore) - 1 = 4 分，则后面的使用空星
    if (integerFull < maxScore - 1) {
      if (decimal == 0) {
        integerEmpty = maxScore - integerFull;
      } else {
        integerEmpty = maxScore - 1 - integerFull;
      }
      for (int i = 0; i < integerEmpty; i++) {
        result.add('lib/images/ic_comic_detail_star_yellow_empty2.png');
      }
    }

    setState(() {
      _result = result;
    });
  }

  List<Widget> _buildStarListWidget() {
    return _result.map((item) {
        return Container(
          margin: EdgeInsets.only(right: ScreenUtil().setWidth(12)),
          child: Image.asset(
            item,
            width: ScreenUtil().setWidth(35),
            height: ScreenUtil().setWidth(32),
          ),
        );
      }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: _buildStarListWidget(),
    );
  }
}
