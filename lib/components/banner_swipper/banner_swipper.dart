import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';

import 'package:flutter_manhuatai/models/recommend_list.dart' as RecommendList;
import 'package:flutter_manhuatai/common/const/app_const.dart';

class BannerSwipper extends StatelessWidget {
  final List<RecommendList.Comic_info> bannerList;

  BannerSwipper({Key key, @required this.bannerList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 236.0,
      child: Swiper(
        itemCount: bannerList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Application.router.navigateTo(context, '/comic/detail/${bannerList[index].comicId}');
            },
            child: Column(
              children: <Widget>[
                ImageWrapper(
                  url:
                      '${AppConst.img_host}/${bannerList[index].imgUrl}${AppConst.imageSizeSuffix.defaultSuffix}',
                  width: MediaQuery.of(context).size.width,
                  height: 200.0,
                  fit: BoxFit.fill,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(bannerList[index].comicName),
                        Text(
                          bannerList[index].lastComicChapterName,
                          style: TextStyle(
                            fontSize: 12.0,
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
        itemHeight: 236.0,
        pagination:
            SwiperPagination(margin: const EdgeInsets.only(bottom: 46.0)),
        // controller: SwiperController(),
        autoplay: true,
      ),
    );
  }
}
