import 'package:extended_text_library/extended_text_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/common/const/app_const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///emoji/image text
class EmojiText extends SpecialText {
  static const String flag = "[/";
  final int start;
  EmojiText(
    TextStyle textStyle, {
    this.start,
  }) : super(EmojiText.flag, "]", textStyle);

  @override
  InlineSpan finishText() {
    var key = toString();
    if (EmojiUitl.instance.emojiMap.containsKey(key)) {
      //fontsize id define image height
      //size = 30.0/26.0 * fontSize
      final double size = ScreenUtil().setSp(36);

      ///fontSize 26 and text height =30.0
      //final double fontSize = 26.0;

      return ImageSpan(
        AssetImage(EmojiUitl.instance.emojiMap[key]),
        actualText: key,
        imageWidth: size,
        imageHeight: size,
        start: start,
        fit: BoxFit.fill,
        margin: EdgeInsets.only(
          left: 1.0,
          top: 1.0,
          right: 1.0,
          bottom: 1.0,
        ),
      );
    }

    return TextSpan(
      text: toString(),
      style: textStyle,
    );
  }
}

class EmojiUitl {
  final Map<String, String> _emojiMap = AppConst.emojiMap;

  Map<String, String> get emojiMap => _emojiMap;

  List<String> get emojiList => emojiMap.keys.toList();

  // final String _emojiFilePath = "assets";

  static EmojiUitl _instance;
  static EmojiUitl get instance {
    if (_instance == null) {
      _instance = EmojiUitl._();
    }
    return _instance;
  }

  EmojiUitl._() {
    // _emojiMap["[love]"] = "$_emojiFilePath/love.png";
    // _emojiMap["[sun_glasses]"] = "$_emojiFilePath/sun_glasses.png";
  }
}
