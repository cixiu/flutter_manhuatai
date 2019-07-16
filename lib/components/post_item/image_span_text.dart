import 'package:extended_image/extended_image.dart';
import 'package:extended_text_library/extended_text_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/common/const/app_const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///emoji/image text
class ImageSpanText extends SpecialText {
  static const String flag = "<%";
  final int start;
  ImageSpanText(
    TextStyle textStyle, {
    this.start,
  }) : super(ImageSpanText.flag, "%", textStyle);

  @override
  InlineSpan finishText() {
    var key = toString();
    var content = getContent();
    // if (ImageUitl.instance.imageMap.containsKey(key)) {
    //fontsize id define image height
    //size = 30.0/26.0 * fontSize
    var reg = RegExp(r'@#de<!--IMG#\d+-->@#de(\d+:\d+)');
    // print(content);
    // double size = ScreenUtil().setWidth(80);
    String url = '';
    double width = ScreenUtil().setWidth(690);
    double height = 0;
    String imgUrl = content.replaceAllMapped(
      reg,
      (matches) {
        List<String> imgWidthAndHeight = matches[1].split(':');
        double imgWidth = double.parse(imgWidthAndHeight[0]);
        double imgHeight = double.parse(imgWidthAndHeight[1]);
        // width = ;
        height = width * imgHeight / imgWidth;
        return '';
      },
    );

    // if (imgUrl == 'error') {
    //   return ImageSpan(
    //     AssetImage('lib/images/pic_cache.png'),
    //     actualText: key,
    //     imageWidth: 50,
    //     imageHeight: 50,
    //     loadingBuilder: (context, widget, event) {
    //       return Container(
    //         color: Colors.grey,
    //         width: width,
    //         height: 200,
    //         child: widget,
    //       );
    //     },
    //     start: start,
    //     fit: BoxFit.cover,
    //     margin: EdgeInsets.symmetric(
    //       vertical: ScreenUtil().setWidth(15),
    //     ),
    //   );
    // }

    url = 'https://comment.yyhao.com/$imgUrl';
    // print('++++++++++++++++++  $url ++++++++++++++++++++++++++');

    ///fontSize 26 and text height =30.0
    //final double fontSize = 26.0;
    /* return WidgetSpan(
      child: ExtendedImage.network(
        url,
        width: width,
        height: height,
        loadStateChanged: loadStateChanged,
      ),
    ); */
    return WidgetSpan(
      child: Text(url),
    );
    return ImageSpan(
      // AssetImage(ImageUitl.instance.imageMap[key]),
      NetworkImage(url),
      actualText: key,
      imageWidth: width,
      imageHeight: height,
      loadingBuilder: (context, widget, event) {
        return Container(
          color: Colors.grey,
          child: widget,
        );
      },
      start: start,
      fit: BoxFit.cover,
      margin: EdgeInsets.symmetric(
        vertical: ScreenUtil().setWidth(15),
      ),
    );
    // }

    // return TextSpan(
    //   text: toString(),
    //   style: textStyle,
    // );
  }

  Widget loadStateChanged(ExtendedImageState state) {
    switch (state.extendedImageLoadState) {
      case LoadState.loading:
        return Container(
          color: Colors.grey,
        );
      case LoadState.completed:
        return null;
      case LoadState.failed:
        state.imageProvider.evict();
        return GestureDetector(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.asset(
                "assets/failed.jpg",
                fit: BoxFit.fill,
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Text(
                  "load image failed, click to reload",
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          onTap: () {
            state.reLoadImage();
          },
        );
    }
    return Container();
  }
}
