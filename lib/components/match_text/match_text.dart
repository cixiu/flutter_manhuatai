import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MatchText extends StatelessWidget {
  final String text;
  final String matchText;
  final TextOverflow overflow;
  final TextStyle commonStyle;
  final TextStyle matchedStyle;

  MatchText(
    this.text, {
    @required this.matchText,
    this.overflow,
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

    bool _hasContainMatchText =
        matchText.isNotEmpty && text.contains(matchText);
    List<String> nameList = [];

    // 将漫画中的关键词提取出来
    if (_hasContainMatchText) {
      nameList = text.split(matchText);
    }

    return !_hasContainMatchText
        ? Text(
            '$text',
            overflow: overflow ?? TextOverflow.ellipsis,
            style: commonStyle ?? defaultCommonStyle,
          )
        : Text.rich(
            TextSpan(
              text: '',
              style: commonStyle,
              children: _buildTextSpan(
                nameList: nameList,
                matchText: matchText,
                defaultCommonStyle: defaultCommonStyle,
                defaultMatchedStyle: defaultMatchedStyle,
              ),
            ),
            overflow: overflow ?? TextOverflow.ellipsis,
          );
  }

  List<TextSpan> _buildTextSpan({
    List<String> nameList,
    String matchText,
    TextStyle defaultCommonStyle,
    TextStyle defaultMatchedStyle,
  }) {
    List<String> newNameList = List()..addAll(nameList);
    for (var i = 0; i < nameList.length - 1; i++) {
      newNameList.insert(i + i + 1, matchText);
    }

    return newNameList.map((item) {
      return item == matchText
          ? TextSpan(
              text: '$matchText',
              style: matchedStyle ?? defaultMatchedStyle,
            )
          : TextSpan(
              text: item,
              style: commonStyle ?? defaultCommonStyle,
            );
    }).toList();
  }
}
