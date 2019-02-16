import 'package:flutter/material.dart';

/// 自定义底部导航栏
class BottomNavigation extends StatefulWidget {
  final int currentIndex;
  final Function onChangeIndex;

  BottomNavigation({Key key, this.currentIndex, this.onChangeIndex})
      : super(key: key);

  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  Widget buildBottonNavigationItem(
      {@required String defaultName,
      @required String title,
      @required int index,
      String activeName}) {
    String imgName = widget.currentIndex == index ? activeName : defaultName;
    Color color =
        widget.currentIndex == index ? Colors.lightBlue : Colors.grey[600];

    return Expanded(
      child: InkResponse(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              '$imgName',
              height: 24.0,
              fit: BoxFit.fitHeight,
            ),
            Container(
              // padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                '$title',
                style: TextStyle(fontSize: 12.0, color: color),
              ),
            )
          ],
        ),
        highlightColor: Colors.transparent,
        highlightShape: BoxShape.rectangle,
        containedInkWell: true,
        splashColor: Colors.transparent,
        enableFeedback: false,
        onTap: () {
          widget.onChangeIndex(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
            border:
                Border(top: BorderSide(width: 0.5, color: Colors.grey[200]))),
        child: Card(
          margin: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    buildBottonNavigationItem(
                      defaultName: 'lib/images/tab/icon_tab_sy2.png',
                      activeName: 'lib/images/tab/icon_tab_sy1.png',
                      title: '首页',
                      index: 0,
                    ),
                    buildBottonNavigationItem(
                      defaultName: 'lib/images/tab/icon_tab_gx2.png',
                      activeName: 'lib/images/tab/icon_tab_gx1.png',
                      title: '更新',
                      index: 1,
                    ),
                    buildBottonNavigationItem(
                      defaultName: 'lib/images/tab/icon_tab_mht2.png',
                      activeName: 'lib/images/tab/icon_tab_mht1.png',
                      title: '漫画台',
                      index: 2,
                    ),
                    buildBottonNavigationItem(
                      defaultName: 'lib/images/tab/icon_tab_sj2.png',
                      activeName: 'lib/images/tab/icon_tab_sj1.png',
                      title: '书架',
                      index: 3,
                    ),
                    buildBottonNavigationItem(
                      defaultName: 'lib/images/tab/icon_tab_wd2.png',
                      activeName: 'lib/images/tab/icon_tab_wd1.png',
                      title: '我的',
                      index: 4,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
