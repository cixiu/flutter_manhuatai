import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/common/const/app_const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:flutter_manhuatai/models/book_list.dart';

import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';

class RecommendBannerSliverList extends StatelessWidget {
  final List<Book> bannerList;

  RecommendBannerSliverList({
    this.bannerList,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        bannerList.length == 0
            ? Container()
            : Container(
                height: ScreenUtil().setWidth(250),
                margin: EdgeInsets.only(
                  bottom: ScreenUtil().setWidth(30),
                ),
                child: Swiper(
                  itemCount: bannerList.first.comicInfo.length,
                  itemBuilder: (context, index) {
                    var item = bannerList.first.comicInfo[index];
                    return GestureDetector(
                      onTap: () {
                        print('banner 的 $index');
                        // Application.router.navigateTo(context,
                        //     '/comic/detail/${bannerList[index].comicId}');
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            ScreenUtil().setWidth(8),
                          ),
                          child: ImageWrapper(
                            url: '${AppConst.cmsHost}/${item.imgUrl}',
                            height: ScreenUtil().setWidth(250),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                  itemHeight: ScreenUtil().setWidth(250),
                  pagination: SwiperPagination(
                    alignment: Alignment.bottomRight,
                    builder: DotSwiperPaginationBuilder(
                      color: Colors.grey[800],
                      size: ScreenUtil().setWidth(10),
                      activeSize: ScreenUtil().setWidth(10),
                    ),
                    margin: EdgeInsets.only(
                      right: ScreenUtil().setWidth(30),
                      bottom: ScreenUtil().setWidth(20),
                    ),
                  ),
                  autoplay: true,
                ),
              ),
      ]),
    );
  }
}
