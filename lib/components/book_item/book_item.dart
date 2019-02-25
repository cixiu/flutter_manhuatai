import 'package:flutter/material.dart';

import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';

import 'package:flutter_manhuatai/models/recommend_list.dart' as RecommendList;
import 'package:flutter_manhuatai/common/const/app_const.dart';
import 'package:flutter_manhuatai/utils/utils.dart';

class BookItem extends StatefulWidget {
  final RecommendList.Book book;

  BookItem({Key key, @required this.book}) : super(key: key);

  _BookItemState createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {
  @override
  Widget build(BuildContext context) {
    double horizonratio = Utils.computedRatio(widget.book.config.horizonratio);
    print(horizonratio);

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.book.title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              widget.book.config.isshowmore == 1
                  ? Text(
                      '更多',
                      style: TextStyle(color: Colors.grey),
                    )
                  : Text('')
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width - 20.0 - 4.0) / 3,
                    height: 188.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: ImageWrapper(
                              url: widget.book.comicInfo[0].imgUrl != ''
                                  ? '${AppConst.img_host}/${widget.book.comicInfo[0].imgUrl}'
                                  : 'https://image.mhxk.com/mh/${widget.book.comicInfo[0].comicId}.jpg',
                              // url:
                              //     'https://image.mhxk.com/mh/106908.jpg-480x640.jpg',
                              // width: 135.0,
                              // height: 188.0,
                              fit: BoxFit.fill),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            widget.book.comicInfo[0].comicName,
                            overflow: TextOverflow.ellipsis,
                            // style: TextStyle(
                            //   font
                            // ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width - 20.0 - 4.0) / 3,
                    height: 188.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: ImageWrapper(
                              url: widget.book.comicInfo[0].imgUrl != ''
                                  ? '${AppConst.img_host}/${widget.book.comicInfo[0].imgUrl}'
                                  : 'https://image.mhxk.com/mh/${widget.book.comicInfo[0].comicId}.jpg',
                              // url:
                              //     'https://image.mhxk.com/mh/106908.jpg-480x640.jpg',
                              // width: 135.0,
                              // height: 188.0,
                              fit: BoxFit.fill),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            widget.book.comicInfo[0].comicName,
                            overflow: TextOverflow.ellipsis,
                            // style: TextStyle(
                            //   font
                            // ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width - 20.0 - 20.0) / 3,
                    height: 188.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: ImageWrapper(
                              url: widget.book.comicInfo[0].imgUrl != ''
                                  ? '${AppConst.img_host}/${widget.book.comicInfo[0].imgUrl}'
                                  : 'https://image.mhxk.com/mh/${widget.book.comicInfo[0].comicId}.jpg',
                              // url:
                              //     'https://image.mhxk.com/mh/106908.jpg-480x640.jpg',
                              // width: 135.0,
                              // height: 188.0,
                              fit: BoxFit.fill),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            widget.book.comicInfo[0].comicName,
                            overflow: TextOverflow.ellipsis,
                            // style: TextStyle(
                            //   font
                            // ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
        // GridView.count(
        //   padding: EdgeInsets.symmetric(horizontal: 10.0),
        //   shrinkWrap: true,
        //   physics: NeverScrollableScrollPhysics(),
        //   crossAxisCount: horizonratio < 2.0 ? 3 : 2,
        //   crossAxisSpacing: 2.0,
        //   mainAxisSpacing: 10.0,
        //   childAspectRatio: horizonratio,
        //   semanticChildCount: 1,
        //   children: widget.book.comicInfo.take(6).map((item) {
        //     print('${item.comicName} ${MediaQuery.of(context).size.width}');
        //     return Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: <Widget>[
        //         Expanded(
        //           child: ImageWrapper(
        //               url: item.imgUrl != ''
        //                   ? '${AppConst.img_host}/${item.imgUrl}'
        //                   : 'https://image.mhxk.com/mh/${item.comicId}.jpg',
        //               // url:
        //               //     'https://image.mhxk.com/mh/106908.jpg-480x640.jpg',
        //               // width: 135.0,
        //               // height: 188.0,
        //               fit: BoxFit.fill),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.all(10.0),
        //           child: Text(
        //             item.comicName,
        //             overflow: TextOverflow.ellipsis,
        //             // style: TextStyle(
        //             //   font
        //             // ),
        //           ),
        //         )
        //       ],
        //     );
        //   }).toList(),
        // )
      ],
    );
  }
}
