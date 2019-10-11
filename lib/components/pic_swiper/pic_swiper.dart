import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PicSwiper extends StatefulWidget {
  final int index;
  final List<PicSwiperItem> pics;
  final bool needHero;

  PicSwiper(
    this.index,
    this.pics, {
    this.needHero = true,
  });

  @override
  _PicSwiperState createState() => _PicSwiperState();
}

class _PicSwiperState extends State<PicSwiper>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  var rebuildIndex = StreamController<int>.broadcast();
  var rebuildSwiper = StreamController<bool>.broadcast();
  AnimationController _animationController;
  Animation<double> _animation;
  Function animationListener;
//  CancellationToken _cancelToken;
//  CancellationToken get cancelToken {
//    if (_cancelToken == null || _cancelToken.isCanceled)
//      _cancelToken = CancellationToken();
//
//    return _cancelToken;
//  }
  List<double> doubleTapScales = <double>[1.0, 2.0];

  int currentIndex;
  bool _showSwiper = true;

  @override
  void initState() {
    currentIndex = widget.index;
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 150), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    rebuildIndex.close();
    rebuildSwiper.close();
    _animationController?.dispose();
    clearGestureDetailsCache();
    //cancelToken?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget result = Material(

        /// if you use ExtendedImageSlidePage and slideType =SlideType.onlyImage,
        /// make sure your page is transparent background
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            ExtendedImageGesturePageView.builder(
              itemBuilder: (BuildContext context, int index) {
                var item = widget.pics[index].picUrl;
                Widget image = ExtendedImage.network(
                  item,
                  fit: BoxFit.contain,
                  enableSlideOutPage: true,
                  mode: ExtendedImageMode.gesture,
                  loadStateChanged: (state) {
                    if (state.extendedImageLoadState == LoadState.loading) {
                      return Center(
                        child: Platform.isIOS
                            ? CupertinoActivityIndicator(
                                animating: true,
                                radius: 16.0,
                              )
                            : CircularProgressIndicator(
                                strokeWidth: 2.0,
                                valueColor: AlwaysStoppedAnimation(
                                    Theme.of(context).primaryColor),
                              ),
                      );
                    }
                    if (state.extendedImageLoadState == LoadState.failed) {
                      return Center(
                        child: GestureDetector(
                          onTap: () {
                            state.reLoadImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.error,
                                size: ScreenUtil().setSp(50),
                                color: Colors.grey,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(10),
                                ),
                                child: Text(
                                  '点击重新加载',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: ScreenUtil().setSp(24),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    // return Container();
                  },
                  initGestureConfigHandler: (state) {
                    double initialScale = 1.0;

                    // if (state.extendedImageInfo != null &&
                    //     state.extendedImageInfo.image != null) {
                    //       print('ddddddddddddddd');
                    //   initialScale = _initalScale(
                    //       size: size,
                    //       initialScale: initialScale,
                    //       imageSize: Size(
                    //           state.extendedImageInfo.image.width.toDouble(),
                    //           state.extendedImageInfo.image.height.toDouble()));
                    //   print(initialScale);
                    // }
                    return GestureConfig(
                      inPageView: true,
                      initialScale: initialScale,
                      maxScale: max(initialScale, 5.0),
                      animationMaxScale: max(initialScale, 5.0),
                      //you can cache gesture state even though page view page change.
                      //remember call clearGestureDetailsCache() method at the right time.(for example,this page dispose)
                      cacheGesture: false,
                    );
                  },
                  onDoubleTap: (ExtendedImageGestureState state) {
                    ///you can use define pointerDownPosition as you can,
                    ///default value is double tap pointer down postion.
                    var pointerDownPosition = state.pointerDownPosition;
                    double begin = state.gestureDetails.totalScale;
                    double end;

                    //remove old
                    _animation?.removeListener(animationListener);

                    //stop pre
                    _animationController.stop();

                    //reset to use
                    _animationController.reset();

                    if (begin == doubleTapScales[0]) {
                      end = doubleTapScales[1];
                    } else {
                      end = doubleTapScales[0];
                    }

                    animationListener = () {
                      //print(_animation.value);
                      state.handleDoubleTap(
                          scale: _animation.value,
                          doubleTapPosition: pointerDownPosition);
                    };
                    _animation = _animationController
                        .drive(Tween<double>(begin: begin, end: end));

                    _animation.addListener(animationListener);

                    _animationController.forward();
                  },
                );

                if (index == currentIndex) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: widget.needHero
                        ? Hero(
                            tag: item + index.toString(),
                            child: image,
                          )
                        : image,
                  );
                } else {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: image,
                  );
                }
              },
              itemCount: widget.pics.length,
              onPageChanged: (int index) {
                currentIndex = index;
                rebuildIndex.add(index);
              },
              controller: PageController(
                initialPage: currentIndex,
              ),
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              //physics: ClampingScrollPhysics(),
            ),
            StreamBuilder<bool>(
              builder: (c, d) {
                if (d.data == null || !d.data) return Container();

                return Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child:
                      MySwiperPlugin(widget.pics, currentIndex, rebuildIndex),
                );
              },
              initialData: true,
              stream: rebuildSwiper.stream,
            )
          ],
        ));
    var slideAxis = SlideAxis.vertical;
    return ExtendedImageSlidePage(
      child: result,
      slideAxis: slideAxis,
      slideType: SlideType.onlyImage,
      resetPageDuration: Duration(milliseconds: 300),
      slideEndHandler: (offset) {
        Size pageSize = context.size;
        if (slideAxis == SlideAxis.both) {
          return offset.distance >
              Offset(pageSize.width, pageSize.height).distance / 3.5;
        } else if (slideAxis == SlideAxis.horizontal) {
          return offset.dx.abs() > 100;
        } else if (slideAxis == SlideAxis.vertical) {
          return offset.dy.abs() > 100;
        }
        return true;
      },
      slidePageBackgroundHandler: (offset, size) {
        Color color = Colors.grey[850];
        double opacity = 0.0;
        if (slideAxis == SlideAxis.both) {
          opacity = offset.distance /
              (Offset(size.width, size.height).distance / 2.0);
        } else if (slideAxis == SlideAxis.horizontal) {
          opacity = offset.dx.abs() / (size.width / 2.0);
        } else if (slideAxis == SlideAxis.vertical) {
          opacity = offset.dy.abs() / (size.height / 2.0);
        }
        return color.withOpacity(min(1.0, max(1.0 - opacity, 0.0)));
      },
      onSlidingPage: (state) {
        ///you can change other widgets' state on page as you want
        ///base on offset/isSliding etc
        //var offset= state.offset;
        var showSwiper = !state.isSliding;
        if (showSwiper != _showSwiper) {
          // do not setState directly here, the image state will change,
          // you should only notify the widgets which are needed to change
          // setState(() {
          // _showSwiper = showSwiper;
          // });

          _showSwiper = showSwiper;
          rebuildSwiper.add(_showSwiper);
        }
      },
    );
  }

  double _initalScale({Size imageSize, Size size, double initialScale}) {
    var n1 = imageSize.height / imageSize.width;
    var n2 = size.height / size.width;
    if (n1 > n2) {
      final FittedSizes fittedSizes =
          applyBoxFit(BoxFit.contain, imageSize, size);
      //final Size sourceSize = fittedSizes.source;
      Size destinationSize = fittedSizes.destination;
      return size.width / destinationSize.width;
    } else if (n1 / n2 < 1 / 4) {
      final FittedSizes fittedSizes =
          applyBoxFit(BoxFit.contain, imageSize, size);
      //final Size sourceSize = fittedSizes.source;
      Size destinationSize = fittedSizes.destination;
      return size.height / destinationSize.height;
    }

    return initialScale;
  }
}

class MySwiperPlugin extends StatelessWidget {
  final List<PicSwiperItem> pics;
  final int index;
  final StreamController<int> reBuild;

  MySwiperPlugin(this.pics, this.index, this.reBuild);

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
      color: Colors.white,
      fontSize: ScreenUtil().setSp(28),
    );

    return StreamBuilder<int>(
      builder: (BuildContext context, data) {
        return DefaultTextStyle(
          style: style,
          child: Container(
            height: 50.0,
            width: double.infinity,
            // color: Colors.grey.withOpacity(0.2),
            child: Row(
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(40),
                ),
                Text(
                  "${data.data + 1}",
                ),
                Text(
                  "/${pics.length}",
                ),
                Expanded(
                  child: Text(
                    pics[data.data].des ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: style,
                  ),
                ),
                Container(
                  width: 10.0,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    print('点击保持图片');
                    // saveNetworkImageToPhoto(pics[index].picUrl)
                    //     .then((bool done) {
                    //   showToast(done ? "save succeed" : "save failed",
                    //       position: ToastPosition(align: Alignment.topCenter));
                    // });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    child: Text(
                      "保存",
                      style: style,
                    ),
                  ),
                ),
                Container(
                  width: ScreenUtil().setWidth(40),
                ),
              ],
            ),
          ),
        );
      },
      initialData: index,
      stream: reBuild.stream,
    );
  }
}

class PicSwiperItem {
  String picUrl;
  String des;

  PicSwiperItem(
    this.picUrl, {
    this.des = "",
  });
}
