import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MatchText extends StatelessWidget {
  final String text;
  final String matchText;
  final TextStyle commonStyle;
  final TextStyle matchedStyle;

  MatchText(
    this.text, {
    @required this.matchText,
    this.commonStyle,
    this.matchedStyle,
  })  : assert(text != null),
        assert(matchText != null);

  @override
  Widget build(BuildContext context) {
    TextStyle defaultCommonStyle = TextStyle(
      color: Colors.black,
      fontSize: ScreenUtil().setSp(28),
      fontWeight: FontWeight.normal,
    );
    TextStyle defaultMatchedStyle = TextStyle(
      color: Colors.blue,
      fontSize: ScreenUtil().setSp(28),
      fontWeight: FontWeight.bold,
    );

    bool _hasContainMatchText = text.contains(matchText);
    List<String> comicNameList = [];

    // 将漫画中的关键词提取出来
    if (_hasContainMatchText) {
      comicNameList = text.split(matchText);
    }

    return !_hasContainMatchText
        ? Text(
            '$text',
            overflow: TextOverflow.ellipsis,
            style: commonStyle ?? defaultCommonStyle,
          )
        : Text.rich(
            TextSpan(
              text: comicNameList[0],
              style: commonStyle,
              children: <TextSpan>[
                TextSpan(
                  text: '$matchText',
                  style: matchedStyle ?? defaultMatchedStyle,
                ),
                TextSpan(
                  text: comicNameList[1],
                  style: commonStyle ?? defaultCommonStyle,
                ),
              ],
            ),
            overflow: TextOverflow.ellipsis,
          );
  }
}
