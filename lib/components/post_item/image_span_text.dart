import 'package:extended_text_library/extended_text_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/common/const/app_const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///emoji/image text
class ImageSpanText extends SpecialText {
  static const String flag = "<!--IMG#";
  final int start;
  ImageSpanText(
    TextStyle textStyle, {
    this.start,
  }) : super(ImageSpanText.flag, "-->", textStyle);

  @override
  TextSpan finishText() {
    var key = toString();
    var content = getContent();
    // if (ImageUitl.instance.imageMap.containsKey(key)) {
    //fontsize id define image height
    //size = 30.0/26.0 * fontSize
    var reg = RegExp(r'@#de<!--IMG#\d+-->@#de(\d+:\d+)');
    print(content);
    // double size = ScreenUtil().setWidth(80);
    String url = '';
    double width = 0;
    double height = 0;
    String imgUrl = content.replaceAllMapped(
      reg,
      (matches) {
        List<String> imgWidthAndHeight = matches[1].split(':');
        double imgWidth = double.parse(imgWidthAndHeight[0]);
        double imgHeight = double.parse(imgWidthAndHeight[1]);
        width = ScreenUtil().setWidth(690);
        height = width * imgHeight / imgWidth;
        return '';
      },
    );

    url = 'https://comment.yyhao.com/$imgUrl';

    ///fontSize 26 and text height =30.0
    //final double fontSize = 26.0;

    return ImageSpan(
      // AssetImage(ImageUitl.instance.imageMap[key]),
      NetworkImage(url),
      actualText: key,
      imageWidth: width,
      imageHeight: height,
      start: start,
      fit: BoxFit.cover,
      // margin: EdgeInsets.only(
      //   left: 1.0,
      //   top: 1.0,
      //   right: 1.0,
      // ),
    );
    // }

    // return TextSpan(
    //   text: toString(),
    //   style: textStyle,
    // );
  }
}
