import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';

import 'package:flutter_manhuatai/models/book_list.dart' as RecommendList;
import 'package:flutter_manhuatai/common/const/app_const.dart';

class BannerSwipper extends StatelessWidget {
  final List<RecommendList.Comic_info> bannerList;

  BannerSwipper({Key key, @required this.bannerList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().setWidth(472),
      child: Swiper(
        itemCount: bannerList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Application.router.navigateTo(
                  context, '/comic/detail/${bannerList[index].comicId}');
            },
            child: Column(
              children: <Widget>[
                ImageWrapper(
                  url:
                      '${AppConst.img_host}/${bannerList[index].imgUrl}${AppConst.imageSizeSuffix.defaultSuffix}',
                  width: MediaQuery.of(context).size.width,
                  height: ScreenUtil().setWidth(400),
                  fit: BoxFit.fill,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(bannerList[index].comicName),
                        Text(
                          bannerList[index].lastComicChapterName,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                            color: Colors.grey[500],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
        // itemWidth: MediaQuery.of(context).size.width,
        itemHeight: ScreenUtil().setWidth(472),
        pagination: SwiperPagination(
          margin: EdgeInsets.only(
            bottom: ScreenUtil().setWidth(92),
          ),
        ),
        // controller: SwiperController(),
        autoplay: true,
      ),
    );
  }
}
