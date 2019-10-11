import 'package:extended_text_library/extended_text_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///emoji/image text
class ImageText extends SpecialText {
  static const String flag = "{emoji:";
  final int start;
  ImageText(
    TextStyle textStyle, {
    this.start,
  }) : super(ImageText.flag, "}", textStyle);

  @override
  InlineSpan finishText() {
    var key = toString();
    var content = getContent();
    // if (ImageUitl.instance.imageMap.containsKey(key)) {
    //fontsize id define image height
    //size = 30.0/26.0 * fontSize
    double size = ScreenUtil().setWidth(80);

    ///fontSize 26 and text height =30.0
    //final double fontSize = 26.0;

    return ImageSpan(
      // AssetImage(ImageUitl.instance.imageMap[key]),
      NetworkImage('https://image.zymk.cn/file/emot/$content.gif'),
      actualText: key,
      imageWidth: size,
      imageHeight: size,
      start: start,
      fit: BoxFit.fill,
      margin: EdgeInsets.only(
        left: 1.0,
        top: 1.0,
        right: 1.0,
      ),
    );
    // }

    // return TextSpan(
    //   text: toString(),
    //   style: textStyle,
    // );
  }
}

class ImageUitl {
  final Map<String, String> _imageMap = Map();

  Map<String, String> get imageMap => _imageMap;

  // final String _emojiFilePath = "assets";

  static ImageUitl _instance;
  static ImageUitl get instance {
    if (_instance == null) {
      _instance = ImageUitl._();
    }
    return _instance;
  }

  ImageUitl._() {
    // _imageMap["[love]"] = "$_emojiFilePath/love.png";
    // _imageMap["[sun_glasses]"] = "$_emojiFilePath/sun_glasses.png";
  }
}
