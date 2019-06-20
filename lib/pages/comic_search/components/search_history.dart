import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/components/cancel_dialog/cancel_dialog.dart';
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/routes/routes.dart';
import 'package:flutter_manhuatai/utils/sp.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchHistory extends StatelessWidget {
  final List<String> historyList;
  final VoidCallback update;

  SearchHistory({
    this.historyList,
    this.update,
  });

  void _navigateToSearchResultPage(BuildContext context, String query) {
    String keyword = Uri.encodeComponent(query);
    Application.router
        .navigateTo(context, '${Routes.searchResult}?keyword=$keyword');
    SpUtils.saveSearchHistory(query);
  }

  void _deleteOneSearchHistory(String query) async {
    await SpUtils.deleteOneSearchHistory(query);
    update();
  }

  void _clearSearchHistory(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return CancelDialog(
          title: '是否清空搜索记录',
          confirm: () async {
            await SpUtils.clearSearchHistory();
            update();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[200],
                width: ScreenUtil().setWidth(1),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: ScreenUtil().setWidth(86),
                padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(20),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  '我的搜索历史',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: ScreenUtil().setSp(32),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _clearSearchHistory(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setWidth(20),
                    horizontal: ScreenUtil().setWidth(40),
                  ),
                  child: Icon(
                    Icons.delete,
                    color: Colors.grey,
                    size: ScreenUtil().setSp(42),
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: historyList.map((item) {
            return Container(
              height: ScreenUtil().setWidth(96),
              margin: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(20),
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[200],
                    width: ScreenUtil().setWidth(1),
                  ),
                ),
              ),
              child: InkResponse(
                onTap: () {
                  _navigateToSearchResultPage(context, item);
                },
                highlightShape: BoxShape.rectangle,
                containedInkWell: true,
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(12),
                        right: ScreenUtil().setWidth(24),
                      ),
                      child: Image.asset(
                        'lib/images/icon_rihuo.png',
                        width: ScreenUtil().setWidth(34),
                        height: ScreenUtil().setWidth(34),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '$item',
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: ScreenUtil().setSp(28),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _deleteOneSearchHistory(item);
                      },
                      child: Container(
                        padding: EdgeInsets.all(
                          ScreenUtil().setWidth(20),
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.grey,
                          size: ScreenUtil().setWidth(42),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
