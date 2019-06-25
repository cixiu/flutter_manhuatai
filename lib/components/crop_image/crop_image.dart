import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui show Image;
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';

import 'package:flutter_manhuatai/components/pic_swiper/pic_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CropImage extends StatelessWidget {
  final ImageItem item;
  final int index;
  final double thumbWidth;
  final double thumbHeight;
  final BoxFit fit;
  final bool autoSetSize;
  final double margin;
  final bool knowImageSize;
  final List<ImageItem> imageList;
  CropImage({
    this.item,
    this.index,
    this.thumbWidth,
    this.thumbHeight,
    this.fit,
    this.autoSetSize = false,
    this.margin = 0.0,
    this.knowImageSize = false,
    this.imageList,
  });

  @override
  Widget build(BuildContext context) {
    if (item == null && imageList.length == 0) return Container();

    final double num300 =
        autoSetSize ? ScreenUtil.getInstance().setWidth(300) : thumbWidth;
    final double num400 =
        autoSetSize ? ScreenUtil.getInstance().setWidth(400) : thumbHeight;
    double height = num300;
    double width = num400;

    if (knowImageSize) {
      height = item.height.toDouble();
      width = item.width.toDouble();
      var n = height / width;
      if (n >= 4 / 3) {
        width = num300;
        height = num400;
      } else if (4 / 3 > n && n > 3 / 4) {
        var maxValue = max(width, height);
        height = num400 * height / maxValue;
        width = num400 * width / maxValue;
      } else if (n <= 3 / 4) {
        width = num400;
        height = num300;
      }
    }

    return Container(
      width: num300,
      height: num400,
      child: ExtendedImage.network(
        item.url,
        fit: fit ?? BoxFit.fill,
        //height: 200.0,
        width: width,
        height: height,
        loadStateChanged: (ExtendedImageState state) {
          Widget widget;
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              widget = Container(
                color: Colors.grey[200],
                width: num300,
                height: num400,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                ),
              );
              break;
            case LoadState.completed:
              //if you can't konw image size before build,
              //you have to handle crop when image is loaded.
              //so maybe your loading widget size will not the same
              //as image actual size, set returnLoadStateChangedWidget=true,so that
              //image will not to be limited by size which you set for ExtendedImage first time.
              state.returnLoadStateChangedWidget = !knowImageSize;

              widget = Hero(
                tag: item.url + index.toString(),
                child: buildImage(
                  state.extendedImageInfo.image,
                  num300,
                  num400,
                ),
              );
              break;
            case LoadState.failed:
              widget = GestureDetector(
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.asset(
                      "assets/failed.jpg",
                      fit: fit ?? BoxFit.fill,
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
              break;
          }

          widget = GestureDetector(
            child: widget,
            onTap: () {
              var page = PicSwiper(
                index,
                imageList
                    .map<PicSwiperItem>((f) => PicSwiperItem(f.url))
                    .toList(),
              );

              Navigator.push(
                context,
                Platform.isAndroid
                    ? TransparentMaterialPageRoute(
                        builder: (_) {
                          return page;
                        },
                      )
                    : TransparentCupertinoPageRoute(
                        builder: (_) {
                          return page;
                        },
                      ),
              );
            },
          );

          return widget;
        },
      ),
    );
  }

  Widget buildImage(ui.Image image, double num300, double num400) {
    if (!autoSetSize) {
      return ExtendedRawImage(
        image: image,
        width: num300,
        height: num400,
        fit: fit ?? BoxFit.fill,
      );
    }

    var n = image.height / image.width;
    if (n >= 4 / 3) {
      Widget imageWidget = ExtendedRawImage(
        image: image,
        width: num300,
        height: num400,
        fit: fit ?? BoxFit.fill,
        soucreRect: Rect.fromLTWH(
            0.0, 0.0, image.width.toDouble(), 4 * image.width / 3),
      );
      if (n >= 4) {
        imageWidget = Container(
          width: num300,
          height: num400,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0.0,
                right: 0.0,
                left: 0.0,
                bottom: 0.0,
                child: imageWidget,
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Container(
                  padding: EdgeInsets.all(2.0),
                  color: Colors.grey,
                  child: const Text(
                    "long image",
                    style: TextStyle(color: Colors.white, fontSize: 10.0),
                  ),
                ),
              )
            ],
          ),
        );
      }
      return imageWidget;
    } else if (4 / 3 > n && n > 3 / 4) {
      var maxValue = max(image.width, image.height);
      var height = num400 * image.height / maxValue;
      var width = num400 * image.width / maxValue;
      return ExtendedRawImage(
        height: height,
        width: width,
        image: image,
        fit: fit ?? BoxFit.fill,
      );
    } else if (n <= 3 / 4) {
      var width = 4 * image.height / 3;
      Widget imageWidget = ExtendedRawImage(
        image: image,
        width: num400,
        height: num300,
        fit: fit ?? BoxFit.fill,
        soucreRect: Rect.fromLTWH(
            (image.width - width) / 2.0, 0.0, width, image.height.toDouble()),
      );

      if (n <= 1 / 4) {
        imageWidget = Container(
          width: num400,
          height: num300,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0.0,
                right: 0.0,
                left: 0.0,
                bottom: 0.0,
                child: imageWidget,
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Container(
                  padding: EdgeInsets.all(2.0),
                  color: Colors.grey,
                  child: const Text(
                    "long image",
                    style: TextStyle(color: Colors.white, fontSize: 10.0),
                  ),
                ),
              )
            ],
          ),
        );
      }
      return imageWidget;
    }
    return Container();
  }
}

class ImageItem {
  final String url;
  final int width;
  final int height;

  ImageItem({
    this.url,
    this.width,
    this.height,
  });
}
